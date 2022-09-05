import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/ui/product/add.dart';
import 'package:sultanpos/ui/widget/confirmation.dart';
import 'package:sultanpos/ui/widget/datatable.dart';
import 'package:sultanpos/ui/widget/dialogutil.dart';
import 'package:sultanpos/ui/widget/showerror.dart';

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
                  const SizedBox(
                    width: 4,
                  ),
                  SizedBox(
                    width: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        AppState().productState.listData.load(refresh: true);
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
                    getWidget: (v) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Icon(Icons.edit),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text("edit"),
                                ],
                              ),
                              onTap: () {
                                AppState().productState.editForm(v);
                                sShowDialog(
                                  context: ctx,
                                  builder: (c) {
                                    return const AddProductWidget(
                                      title: "Edit Barang",
                                    );
                                  },
                                );
                              },
                            ),
                            PopupMenuItem(
                              height: 30,
                              onTap: () async {
                                final result = await showConfirmation(ctx, title: 'Yakin hapus', message: 'Yakin untuk menghapus "${v.name}"');
                                if (result) {
                                  try {
                                    await AppState().productState.remove(v.publicId);
                                  } catch (e) {
                                    // ignore: use_build_context_synchronously
                                    showError(ctx, title: 'Error menghapus', message: e.toString());
                                  }
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text("hapus"),
                                ],
                              ),
                            ),
                          ],
                          child: const Text(
                            "aksi",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        )
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
