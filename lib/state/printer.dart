import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pos_printer_platform/flutter_pos_printer_platform.dart';
import 'package:sultanpos/model/appconfig.dart';
import 'package:sultanpos/preference.dart';
import 'package:sultanpos/repository/repository.dart';
import 'package:flutter_pos_printer_platform/esc_pos_utils_platform/esc_pos_utils_platform.dart';
import 'package:sultanpos/util/escp.dart';
import 'package:sultanpos/util/format.dart';

class PrinterState extends ChangeNotifier {
  final SaleRepository saleRepo;
  final UnitRepository unitRepo;
  final CashierSessionRepository cashierSessionRepo;
  final Preference preference;
  StreamSubscription? _discoverStream;
  List<PrinterDevice> printers = [];

  PrinterState({
    required this.preference,
    required this.saleRepo,
    required this.unitRepo,
    required this.cashierSessionRepo,
  });

  discover() {
    printers = [];
    //notifyListeners();
    //discover usb
    _discoverStream = PrinterManager.instance.discovery(type: PrinterType.usb).listen((event) {
      printers.add(event);
      notifyListeners();
    });
  }

  stopDiscover() {
    _discoverStream?.cancel();
    _discoverStream = null;
  }

  printSale(int id) async {
    final printer = preference.getDefaultPrinter();
    if (printer == null) {
      throw 'no printer found';
    }
    try {
      final sale = await saleRepo.get(id);
      final items = await saleRepo.items(id);
      final payments = await saleRepo.payments(id);
      final profile = await CapabilityProfile.load();
      final Escp escp = Escp(PaperSize.mm58, profile);

      escp.text(printer.title ?? "Sultan POS",
          style: const PosStyles(height: PosTextSize.size2, align: PosAlign.center));
      if (printer.subtitles != null) {
        for (var item in printer.subtitles!) {
          escp.text(item, style: const PosStyles(align: PosAlign.center));
        }
      } else {
        escp.text("Jln. Tambangan 1", style: const PosStyles(align: PosAlign.center));
        escp.text("Purwosari Bojonegoro", style: const PosStyles(align: PosAlign.center));
      }
      escp
          .hr()
          .style(const PosStyles())
          .leftRight("Tanggal", formatDateTimeWithMonthName(sale.date.toLocal()))
          .leftRight("Kasir", sale.user!.name)
          .leftRight("No.", sale.id.toRadixString(36).toUpperCase())
          .hr();

      for (int i = 0; i < items.data.length; i++) {
        final data = items.data[i];
        final unit = await unitRepo.get(data.product!.unitId);
        escp.text("${data.product!.barcode} ${data.product!.name}").leftRight(
            "${formatStock(data.amount)} ${unit.name} x ${formatMoney(data.price)}", formatMoney(data.total));
      }
      escp.hr().leftRight("Total", formatMoney(sale.total));
      if (payments.data.length == 1) {
        final payment = payments.data[0];
        escp
            .leftRight("Pembayaran", formatMoney(payment.payment))
            .leftRight("Kembali", formatMoney(payment.payment - sale.total));
      } else {
        for (int i = 0; i < payments.data.length; i++) {
          final payment = payments.data[i];
          escp
              .hr()
              .leftRight("Metode", payment.paymentMethod.name)
              .leftRight("Pembayaran", formatMoney(payment.amount));
        }
      }
      if (sale.paymentResidual == 0) {
        escp
            .hr()
            .text("*** LUNAS ***", style: const PosStyles(bold: true, align: PosAlign.center))
            .style(const PosStyles());
      }
      escp.hr();
      if (printer.footnotes != null) {
        for (var item in printer.footnotes!) {
          escp.text(item, style: const PosStyles(align: PosAlign.center));
        }
      } else {
        escp.text("Terima kasih sudah berbelanja", style: const PosStyles(align: PosAlign.center));
      }
      escp.feed(printer.feed ?? 2);

      printToDevice(printer, escp.data);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  printCashierClose(int id) async {
    final printer = preference.getDefaultPrinter();
    if (printer == null) {
      throw 'no printer found';
    }
    try {
      final session = await cashierSessionRepo.get(id);
      final report = await cashierSessionRepo.getReport(id);
      final profile = await CapabilityProfile.load();
      final Escp escp = Escp(PaperSize.mm58, profile);
      escp
          .text("Laporan Kasir", style: const PosStyles(height: PosTextSize.size2, align: PosAlign.center))
          .style(const PosStyles())
          .hr()
          .leftRight("Nama", session.user?.name ?? "-")
          .leftRight("Tanggal buka", formatDateTime(session.dateOpen))
          .leftRight("Tanggal tutup", formatDateTime(session.dateClose))
          .hr()
          .leftRight("Modal awal", formatMoney(session.openValue))
          .leftRight("Uang masuk", formatMoney(report.paymentInTotal))
          .leftRight("Uang keluar", formatMoney(report.paymentOutTotal))
          .hr()
          .leftRight("Uang system", formatMoney(session.openValue + report.paymentInTotal))
          .leftRight("Fisik", formatMoney(session.closeValue))
          .hr()
          .feed(printer.feed ?? 2);
      printToDevice(printer, escp.data);
    } catch (e) {
      rethrow;
    }
  }

  printToDevice(AppConfigPrinter printer, List<int> data) async {
    final connect = await PrinterManager.instance.connect(
        type: PrinterType.usb,
        model: UsbPrinterInput(
          name: printer.name,
          productId: printer.productId,
          vendorId: printer.vendorId,
        ));
    if (connect) {
      await PrinterManager.instance.send(type: PrinterType.usb, bytes: data);
      await PrinterManager.instance.disconnect(type: PrinterType.usb);
    } else {
      throw 'unable to connect printer';
    }
  }

  AppConfigPrinter? getConfigPrinter() {
    return preference.getDefaultPrinter();
  }

  saveChasierPrinter(AppConfigPrinter config) {
    preference.setDefaultPrinter(config);
  }
}
