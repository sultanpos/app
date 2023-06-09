import 'package:flutter/material.dart';
import 'package:sultanpos/model/purchase.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/ui/purchase/add.dart';
import 'package:sultanpos/ui/widget/columnaction.dart';
import 'package:sultanpos/ui/widget/confirmation.dart';
import 'package:sultanpos/ui/widget/datatable.dart';
import 'package:sultanpos/ui/widget/dialogutil.dart';
import 'package:sultanpos/ui/widget/showerror.dart';
import 'package:sultanpos/util/format.dart';

class PurchaseListWidget extends StatelessWidget {
  const PurchaseListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Daftar Pembelian',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Expanded(child: SizedBox()),
              ElevatedButton(
                onPressed: () {
                  AppState().purchaseState.resetForm();
                  sShowDialog(
                    context: context,
                    builder: (c) {
                      return const PurchaseAddWidget(
                        title: "Tambah Pembelian Baru",
                      );
                    },
                  );
                },
                child: const Text('Tambah Pembelian'),
              ),
              const SizedBox(
                width: 4,
              ),
              SizedBox(
                width: 30,
                child: ElevatedButton(
                  onPressed: () {
                    AppState().purchaseState.listData.load(refresh: true);
                  },
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(0)),
                  child: const Icon(
                    Icons.refresh,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: SDataTable<PurchaseModel>(
              onDoubleClicked: (value) {
                AppState().purchaseState.open(value);
              },
              columns: [
                SDataColumn(
                  width: 80,
                  id: 'action',
                  title: 'Action',
                  getWidget: (v) => SColumnAction(
                    [
                      SColumActionItem('detail', Icons.document_scanner, () {
                        AppState().purchaseState.open(v);
                      }),
                      SColumActionItem('edit', Icons.edit, () {
                        AppState().purchaseState.editForm(v);
                        sShowDialog(
                          context: context,
                          builder: (c) {
                            return const PurchaseAddWidget(title: 'Ubah pembelian');
                          },
                        );
                      }),
                      SColumActionItem('hapus', Icons.delete_forever, () async {
                        final result = await showConfirmation(context,
                            title: 'Yakin hapus', message: 'Yakin untuk menghapus "${v.number}"');
                        if (result) {
                          try {
                            await AppState().purchaseState.remove(v.id);
                            // ignore: use_build_context_synchronously
                            showSuccess(context, title: 'Berhasil', message: 'Pembelian telah dihapus');
                          } catch (e) {
                            // ignore: use_build_context_synchronously
                            showError(context, title: 'Error menghapus', message: e.toString());
                          }
                        }
                      }, iconColor: Colors.red),
                    ],
                  ),
                ),
                SDataColumn(
                  id: 'number',
                  title: 'Nomor',
                  get: (v) => v.number,
                ),
                SDataColumn(
                  id: 'refNumber',
                  title: 'Nomor referensi',
                  get: (v) => v.refNumber,
                ),
                SDataColumn(
                  id: 'partner',
                  title: 'Supplier',
                  get: (v) => v.partner?.name ?? "-",
                ),
                SDataColumn(
                  id: 'total',
                  title: 'Total',
                  width: 120,
                  align: Alignment.centerRight,
                  get: (v) => formatMoney(v.total),
                ),
              ],
              name: 'purchase',
              state: AppState().purchaseState.listData,
            ),
          ),
        ],
      ),
    );
  }
}
