import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/model/pricegroup.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/pricegroup.dart';
import 'package:sultanpos/ui/master/pricegroup/add.dart';
import 'package:sultanpos/ui/widget/columnaction.dart';
import 'package:sultanpos/ui/widget/confirmation.dart';
import 'package:sultanpos/ui/widget/datatable.dart';
import 'package:sultanpos/ui/widget/dialogutil.dart';
import 'package:sultanpos/ui/widget/showerror.dart';

class PriceGroupWidget extends StatelessWidget {
  const PriceGroupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PriceGroupState>.value(
      value: AppState().priceGroupState,
      child: Builder(
        builder: (ctx) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Daftar Group',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Expanded(child: SizedBox()),
                    ElevatedButton(
                      onPressed: () {
                        AppState().priceGroupState.resetForm();
                        sShowDialog(
                          context: ctx,
                          builder: (c) {
                            return const PriceGroupAddWidget(
                              title: "Tambah Group Harga Baru",
                            );
                          },
                        );
                      },
                      child: const Text('Tambah Group'),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    SizedBox(
                      width: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          AppState().priceGroupState.listData.load(refresh: true);
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
                  height: 16,
                ),
                Expanded(
                    child: SDataTable<PriceGroupModel>(
                  name: "pricegroup",
                  state: AppState().priceGroupState.listData,
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
                                  AppState().priceGroupState.editForm(v);
                                  sShowDialog(
                                    context: ctx,
                                    builder: (c) {
                                      return const PriceGroupAddWidget(title: "Edit group harga");
                                    },
                                  );
                                }),
                                SColumActionItem('hapus', Icons.delete_forever, () async {
                                  final result = await showConfirmation(ctx,
                                      title: 'Yakin hapus', message: 'Yakin untuk menghapus "${v.name}"');
                                  if (result) {
                                    try {
                                      await AppState().priceGroupState.remove(v.id);
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
                      id: 'description',
                      title: 'Keterangan',
                      get: (v) => v.description,
                    ),
                    SDataColumn(
                      id: 'descriptionPublic',
                      title: 'Keterangan Public',
                      get: (v) => v.publicDescription,
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
