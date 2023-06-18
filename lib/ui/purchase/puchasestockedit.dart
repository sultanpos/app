import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/model/purchase.dart';
import 'package:sultanpos/state/purchaseitem.dart';
import 'package:sultanpos/ui/widget/basewindow.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/showerror.dart';
import 'package:sultanpos/ui/widget/tileselect.dart';

class PurchaseStockEditWidget extends StatefulWidget {
  const PurchaseStockEditWidget({super.key});

  @override
  State<PurchaseStockEditWidget> createState() => _PurchaseStockEditWidgetState();
}

class _PurchaseStockEditWidgetState extends State<PurchaseStockEditWidget> {
  late PurchaseStockStatus status;

  @override
  void initState() {
    status = context.read<PurchaseItemState>().purchase.stockStatus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PurchaseItemState>();
    return BaseWindowWidget(
      title: 'Status Persediaan',
      icon: Icons.inventory,
      width: 400,
      height: 400,
      child: Column(
        children: [
          Expanded(
            child: TileSelect<PurchaseStockStatus>(
              onSelected: (value) {
                status = value;
                setState(() {});
              },
              current: status,
              items: [
                TileSelectData(
                    id: PurchaseStockStatus.none,
                    title: "None",
                    description: "Status default awal, tidak mempengaruhi stock disistem"),
                TileSelectData(
                    id: PurchaseStockStatus.transit,
                    title: "Transit",
                    description: "Stock masih dalam pengiriman, belum terhitung oleh system"),
                TileSelectData(
                    id: PurchaseStockStatus.received,
                    title: "Diterima",
                    description: "Stock sudah diterima dan akan dihitung oleh sistem"),
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
      await state.updateStockStatus(status);
      state.refreshPurchase();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      showSuccess(context, title: 'Berhasil', message: 'Item berhasil disimpan');
    } catch (e) {
      showError(context, title: 'Error', message: e.toString());
    }
  }
}
