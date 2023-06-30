import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/model/category.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/category.dart';
import 'package:sultanpos/ui/master/category/add.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/columnaction.dart';
import 'package:sultanpos/ui/widget/confirmation.dart';
import 'package:sultanpos/ui/widget/datatable.dart';
import 'package:sultanpos/ui/widget/dialogutil.dart';
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
                    SButton(
                      onPressed: () {
                        AppState().categoryState.resetForm();
                        sShowDialog(
                          context: ctx,
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
                    SButton(
                      positive: false,
                      onPressed: () {
                        AppState().categoryState.listData.load(refresh: true);
                      },
                      child: const Icon(
                        Icons.refresh,
                        size: 20,
                      ),
                    ),
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
                          : SColumnAction(
                              [
                                SColumActionItem('edit', Icons.edit, () {
                                  AppState().categoryState.editForm(v);
                                  sShowDialog(
                                    context: ctx,
                                    builder: (c) {
                                      return const CategoryAddWidget(title: "Edit Kategori");
                                    },
                                  );
                                }),
                                SColumActionItem('hapus', Icons.delete_forever, () async {
                                  final result = await showConfirmation(ctx,
                                      title: 'Yakin hapus', message: 'Yakin untuk menghapus "${v.name}"');
                                  if (result) {
                                    try {
                                      await AppState().categoryState.remove(v.id);
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
