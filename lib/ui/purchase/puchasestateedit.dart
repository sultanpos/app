import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/model/purchase.dart';
import 'package:sultanpos/state/purchaseitem.dart';
import 'package:sultanpos/ui/widget/basewindow.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/showerror.dart';
import 'package:sultanpos/ui/widget/tileselect.dart';

class PurchaseStateEditWidget extends StatefulWidget {
  const PurchaseStateEditWidget({super.key});

  @override
  State<PurchaseStateEditWidget> createState() => _PurchaseStateEditWidgetState();
}

class _PurchaseStateEditWidgetState extends State<PurchaseStateEditWidget> {
  late PurchaseStatus status;

  @override
  void initState() {
    status = context.read<PurchaseItemState>().purchase.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PurchaseItemState>();
    return BaseWindowWidget(
      title: 'Status Pembelian',
      icon: Icons.inventory,
      width: 400,
      height: 500,
      child: Column(
        children: [
          Expanded(
            child: TileSelect<PurchaseStatus>(
              onSelected: (value) {
                status = value;
                setState(() {});
              },
              current: status,
              items: [
                TileSelectData(
                    id: PurchaseStatus.draft,
                    title: PurchaseStatus.draft.text,
                    description: "Pembelian dapat dimodifikasi tanpa mengganggu apapun"),
                TileSelectData(
                    id: PurchaseStatus.validated,
                    title: PurchaseStatus.validated.text,
                    description: "Pembelian sudah tervalidasi dan pembayaran akan timbul"),
                TileSelectData(
                    id: PurchaseStatus.inProgress,
                    title: PurchaseStatus.inProgress.text,
                    description: "Pembelian belum lunas tapi barang sudah diterima"),
                TileSelectData(
                    id: PurchaseStatus.done, title: PurchaseStatus.done.text, description: "Pembelian selesai"),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: SButton(
                  positive: false,
                  label: "Batal",
                  onPressed: state.saving
                      ? null
                      : () {
                          Navigator.of(context).pop();
                        },
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: SButton(
                  label: "Simpan",
                  onPressed: state.saving
                      ? null
                      : () async {
                          save(context, state);
                        },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  save(BuildContext context, PurchaseItemState state) async {
    try {
      await state.updateStatus(status);
      await state.refreshPurchase();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      showSuccess(context, message: 'Item berhasil disimpan');
    } catch (e) {
      showError(context, message: e.toString());
    }
  }
}
