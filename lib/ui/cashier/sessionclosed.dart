import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/cashier.dart';
import 'package:sultanpos/ui/widget/basewindow.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/labelfield.dart';
import 'package:sultanpos/ui/widget/space.dart';
import 'package:sultanpos/util/format.dart';

class CashierSessionClosedWidget extends StatelessWidget {
  const CashierSessionClosedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CashierRootState>();
    return BaseWindowWidget(
      title: 'Kasir tertutup',
      width: 350,
      height: 450,
      icon: Icons.check,
      child: Column(children: [
        LeftRightText("Nama", state.currentSession?.user?.name ?? "-"),
        const SVSpaceSmall(),
        LeftRightText("Tanggal buka", formatDateTimeNullable(state.currentSession?.dateOpen) ?? '-'),
        const SVSpaceSmall(),
        LeftRightText("Tanggal tutup", formatDateTimeNullable(state.currentSession?.dateClose) ?? '-'),
        const Divider(),
        LeftRightText("Modal awal", formatMoney(state.currentSession?.openValue ?? 0)),
        const SVSpaceSmall(),
        LeftRightText("Total masuk", formatMoney(state.report?.paymentInTotal ?? 0)),
        const SVSpaceSmall(),
        LeftRightText("Total keluar", formatMoney(state.report?.paymentOutTotal ?? 0)),
        const Divider(),
        LeftRightText(
          "System",
          formatMoney((state.currentSession?.openValue ?? 0) +
              (state.report?.paymentInTotal ?? 0) -
              (state.report?.paymentOutTotal ?? 0)),
        ),
        const SVSpaceSmall(),
        LeftRightText("Fisik", formatMoney(state.currentSession?.closeValue ?? 0)),
        const Spacer(),
        Row(
          children: [
            Expanded(
              child: SButton(
                positive: false,
                shortCut: const [LogicalKeyboardKey.escape],
                label: "Tutup",
                onPressed: state.saving
                    ? null
                    : () {
                        Navigator.of(context).pop(false);
                      },
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: SButton(
                autofocus: true,
                shortCut: const [LogicalKeyboardKey.enter],
                label: "Print",
                onPressed: () async {
                  AppState().printer.printCashierClose(state.currentSession!.id);
                },
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
