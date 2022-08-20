import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/ui/product/add.dart';
import 'package:sultanpos/ui/widget/datatable.dart';
import 'package:sultanpos/ui/widget/dialogutil.dart';

class ProductRootWidget extends StatelessWidget {
  const ProductRootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AppState().productState,
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
                      AppState().productState.resetForm();
                      sShowDialog(
                        context: ctx,
                        builder: (c) {
                          return const AddProductWidget(
                            title: "Tambah Barang Baru",
                          );
                        },
                      );
                    },
                    child: const Text('Tambah Barang'),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: SDataTable<ProductModel>(columns: [
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
                    id: 'unit',
                    title: 'Unit',
                    get: (v) => v.unit.name,
                  ),
                  SDataColumn(
                    id: 'category',
                    title: 'Kategori',
                    get: (v) => v.category.name,
                  ),
                ], name: 'product', state: AppState().productState.listData),
              ),
            ],
          ),
        );
      }),
    );
  }
}
