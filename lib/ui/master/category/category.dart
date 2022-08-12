import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/model/category.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/category.dart';
import 'package:sultanpos/ui/master/category/add.dart';
import 'package:sultanpos/ui/widget/confirmation.dart';
import 'package:sultanpos/ui/widget/datatable.dart';
import 'package:sultanpos/ui/widget/showerror.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CategoryState>.value(
      value: AppState().categoryState,
      child: Builder(
        builder: (ctx) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Daftar Kategori Barang',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Expanded(child: SizedBox()),
                    ElevatedButton(
                      onPressed: () {
                        AppState().categoryState.resetForm();
                        showDialog(
                          context: ctx,
                          useRootNavigator: false,
                          builder: (c) {
                            return const CategoryAddWidget(
                              title: "Tambah Kategori",
                            );
                          },
                        );
                      },
                      child: const Text('Tambah Kategori'),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          AppState().categoryState.listData.load(refresh: true);
                        },
                        child: const Icon(Icons.refresh)),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                    child: SDataTable<CategoryModel>(
                  name: "category",
                  state: AppState().categoryState.listData,
                  columns: [
                    SDataColumn(
                      width: 100,
                      id: 'action',
                      title: 'Action',
                      getWidget: (v) => v.isDefault
                          ? const SizedBox.shrink()
                          : Row(children: [
                              IconButton(
                                iconSize: 16,
                                splashRadius: 16,
                                onPressed: () {
                                  AppState().categoryState.editForm(v);
                                  showDialog(
                                    context: ctx,
                                    useRootNavigator: false,
                                    builder: (c) {
                                      return const CategoryAddWidget(title: "Edit Kategori");
                                    },
                                  );
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                iconSize: 16,
                                splashRadius: 16,
                                onPressed: () async {
                                  final result = await showConfirmation(ctx, title: 'Yakin hapus', message: 'Yakin untuk menghapus "${v.name}"');
                                  if (result) {
                                    try {
                                      await AppState().categoryState.remove(v.publicId);
                                    } catch (e) {
                                      // ignore: use_build_context_synchronously
                                      showError(ctx, title: 'Error menghapus', message: e.toString());
                                    }
                                  }
                                },
                                icon: const Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                ),
                              ),
                            ]),
                    ),
                    SDataColumn(
                      id: 'name',
                      title: 'Nama',
                      get: (v) => v.name,
                    ),
                    SDataColumn(
                      id: 'code',
                      title: 'Code',
                      get: (v) => v.code,
                    ),
                    SDataColumn(
                      id: 'description',
                      title: 'Keterangan',
                      get: (v) => v.description,
                    ),
                  ],
                )),
              ],
            ),
          );
        },
      ),
    );
  }
}
