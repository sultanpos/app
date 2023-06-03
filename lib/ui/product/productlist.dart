import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/ui/widget/columnaction.dart';
import 'package:sultanpos/ui/widget/confirmation.dart';
import 'package:sultanpos/ui/widget/datatable.dart';
import 'package:sultanpos/ui/widget/showerror.dart';
import 'package:sultanpos/util/format.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AppState().productRootState,
      child: Builder(builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Daftar Barang',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Expanded(child: SizedBox()),
                  ElevatedButton(
                    onPressed: () {
                      AppState().productRootState.addNew();
                    },
                    child: const Text('Tambah Barang'),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  SizedBox(
                    width: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        AppState().productRootState.productList.load(refresh: true);
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
                child: SDataTable<ProductModel>(columns: [
                  SDataColumn(
                    width: 100,
                    id: 'action',
                    title: 'Action',
                    getWidget: (v) => SColumnAction(
                      [
                        SColumActionItem('edit', Icons.edit, () {
                          AppState().productRootState.editProduct(v);
                        }),
                        SColumActionItem('hapus', Icons.delete_forever, () async {
                          final result = await showConfirmation(ctx,
                              title: 'Yakin hapus', message: 'Yakin untuk menghapus "${v.name}"');
                          if (result) {
                            try {
                              await AppState().productRootState.deleteProduct(v.id);
                              // ignore: use_build_context_synchronously
                              showSuccess(ctx, title: 'Berhasil', message: 'Barang telah dihapus');
                            } catch (e) {
                              // ignore: use_build_context_synchronously
                              showError(ctx, title: 'Error menghapus', message: e.toString());
                            }
                          }
                        }, iconColor: Colors.red),
                      ],
                    ),
                  ),
                  SDataColumn(
                    id: 'barcode',
                    title: 'Barcode',
                    get: (v) => v.barcode,
                  ),
                  SDataColumn(
                    id: 'name',
                    title: 'Nama',
                    get: (v) => v.name,
                  ),
                  SDataColumn(
                    id: 'buyPrice',
                    title: 'Harga beli',
                    align: Alignment.centerRight,
                    get: (v) {
                      final value = v.buyPrices.firstWhere((element) => element.branch.isDefault);
                      return formatMoney(value.buyPrice);
                    },
                  ),
                  SDataColumn(
                    id: 'sellPrice',
                    title: 'Harga Jual',
                    align: Alignment.centerRight,
                    get: (v) {
                      final value = v.prices.firstWhere((element) => element.priceGroup.isDefault);
                      return formatMoney(value.price0);
                    },
                  ),
                  SDataColumn(
                    id: 'stock',
                    title: 'Persediaan',
                    align: Alignment.centerRight,
                    get: (v) {
                      if (v.stocks != null) {
                        final total = v.stocks!.fold<int>(0, (previousValue, element) => previousValue + element.stock);
                        return formatMoneyDouble(total.toDouble() / 1000.0);
                      }
                      return "0";
                    },
                  ),
                  SDataColumn(
                    id: 'unit',
                    title: 'Unit',
                    get: (v) => v.unit.name,
                  ),
                  SDataColumn(
                    id: 'category',
                    title: 'Kategori',
                    get: (v) => v.category.name,
                  ),
                  SDataColumn(
                    id: 'partner',
                    title: 'Suplier',
                    get: (v) => v.partner.name,
                  ),
                ], name: 'product', state: AppState().productRootState.productList),
              ),
            ],
          ),
        );
      }),
    );
  }
}
