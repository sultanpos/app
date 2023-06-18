import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/model/purchase.dart';
import 'package:sultanpos/state/purchaseitem.dart';
import 'package:sultanpos/ui/purchase/additem.dart';
import 'package:sultanpos/ui/purchase/puchasestateedit.dart';
import 'package:sultanpos/ui/purchase/puchasestockedit.dart';
import 'package:sultanpos/ui/theme.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/columnaction.dart';
import 'package:sultanpos/ui/widget/confirmation.dart';
import 'package:sultanpos/ui/widget/datatable.dart';
import 'package:sultanpos/ui/widget/dialogutil.dart';
import 'package:sultanpos/ui/widget/showerror.dart';
import 'package:sultanpos/ui/widget/space.dart';
import 'package:sultanpos/ui/widget/tilewidget.dart';
import 'package:sultanpos/util/format.dart';

class PurchaseEditWidget extends StatelessWidget {
  const PurchaseEditWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PurchaseItemState>();
    return Padding(
      padding: EdgeInsets.all(STheme().padding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "${state.purchase.number} (${state.purchase.partner?.name})",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              SButton(
                label: 'Tambah item',
                onPressed: () {
                  state.resetForm();
                  sShowDialog(
                    context: context,
                    builder: (c) {
                      return ChangeNotifierProvider.value(
                        value: state,
                        child: const PurchaseItemAddWidget(
                          title: "Tambah Item Baru",
                        ),
                      );
                    },
                  );
                },
              ),
              const SHSpaceSmall(),
              SButton(
                positive: false,
                onPressed: () {
                  state.listData.load(refresh: true);
                },
                child: const Icon(
                  Icons.refresh,
                  size: 20,
                ),
              ),
            ],
          ),
          const SVSpace(),
          Row(
            children: [
              TileWidget(title: 'Total: ', value: 'Rp. ${formatMoney(state.purchase.total)}'),
              const Spacer(),
              if (state.purchase.paymentResidual > 0) ...[
                TileIconWidget(
                  lead: const Icon(Icons.attach_money),
                  body: Text(
                      state.purchase.paymentResidual == 0 && state.purchase.paymentPaid > 0 ? 'Lunas' : 'Belum lunas'),
                  onTap: () {},
                ),
                const SHSpaceSmall(),
              ],
              if (state.purchase.editableStock()) ...[
                TileIconWidget(
                  lead: const Icon(Icons.inventory),
                  body: Text(state.purchase.stockStatus.value),
                  tail: const Icon(Icons.arrow_drop_down),
                  onTap: () {
                    sShowDialog(
                      context: context,
                      builder: (c) {
                        return ChangeNotifierProvider.value(
                          value: state,
                          child: const PurchaseStockEditWidget(),
                        );
                      },
                    );
                  },
                ),
                const SHSpaceSmall(),
              ],
              TileIconWidget(
                lead: const Icon(Icons.check),
                body: Text(state.purchase.status.value),
                tail: const Icon(Icons.arrow_drop_down),
                onTap: () {
                  sShowDialog(
                    context: context,
                    builder: (c) {
                      return ChangeNotifierProvider.value(
                        value: state,
                        child: const PurchaseStateEditWidget(),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          const SVSpace(),
          Expanded(
            child: SDataTable<PurchaseItemModel>(
              columns: [
                SDataColumn(
                  width: 80,
                  id: 'action',
                  title: 'Action',
                  getWidget: (v) => SColumnAction(
                    [
                      SColumActionItem('edit', Icons.edit, () {
                        state.editForm(v);
                        sShowDialog(
                          context: context,
                          builder: (c) {
                            return ChangeNotifierProvider.value(
                              value: state,
                              child: const PurchaseItemAddWidget(
                                title: 'Ubah pembelian',
                              ),
                            );
                          },
                        );
                      }),
                      SColumActionItem('hapus', Icons.delete_forever, () async {
                        final result = await showConfirmation(context,
                            title: 'Yakin hapus', message: 'Yakin untuk menghapus "${v.product?.barcode}"');
                        if (result) {
                          try {
                            await state.remove(v.id);
                            state.refreshPurchase();
                            // ignore: use_build_context_synchronously
                            showSuccess(context, title: 'Berhasil', message: 'Item telah dihapus');
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
                  id: 'barcode',
                  title: 'Barcode',
                  get: (v) => v.product?.barcode ?? '-',
                ),
                SDataColumn(
                  id: 'name',
                  title: 'Nama barang',
                  get: (v) => v.product?.name ?? '-',
                ),
                SDataColumn(
                  id: 'count',
                  title: 'Jumlah',
                  align: Alignment.centerRight,
                  get: (v) => formatStock(v.amount),
                ),
                SDataColumn(
                  id: 'price',
                  title: 'Harga satuan',
                  width: 120,
                  align: Alignment.centerRight,
                  get: (v) => formatMoney(v.price),
                ),
                SDataColumn(
                  id: 'discount',
                  title: 'Diskon',
                  align: Alignment.centerRight,
                  get: (v) => formatMoney(v.discount),
                ),
                SDataColumn(
                  id: 'total',
                  title: 'Total',
                  align: Alignment.centerRight,
                  get: (v) => formatMoney(v.total),
                ),
              ],
              name: 'purchaseedit',
              state: state.listData,
            ),
          ),
        ],
      ),
    );
  }
}
