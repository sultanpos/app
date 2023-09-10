import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/model/unit.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/unit.dart';
import 'package:sultanpos/ui/master/unit/add.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/columnaction.dart';
import 'package:sultanpos/ui/widget/confirmation.dart';
import 'package:sultanpos/ui/widget/datatable.dart';
import 'package:sultanpos/ui/widget/dialogutil.dart';
import 'package:sultanpos/ui/widget/showerror.dart';

class UnitWidget extends StatelessWidget {
  const UnitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UnitState>.value(
      value: AppState().unitState,
      child: Builder(
        builder: (ctx) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Daftar Unit',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Expanded(child: SizedBox()),
                    SButton(
                      onPressed: () {
                        AppState().unitState.resetForm();
                        sShowDialog(
                          context: ctx,
                          builder: (c) {
                            return const UnitAddWidget(
                              title: "Tambah Unit Baru",
                            );
                          },
                        );
                      },
                      child: const Text('Tambah Unit'),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    SButton(
                      positive: false,
                      onPressed: () {
                        AppState().unitState.listData.load(refresh: true);
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
                    child: SDataTable<UnitModel>(
                  name: "unit",
                  state: AppState().unitState.listData,
                  columns: [
                    SDataColumn(
                      width: 100,
                      id: 'action',
                      title: 'Action',
                      getWidget: (v) => SColumnAction(
                        [
                          SColumActionItem('edit', Icons.edit, () {
                            AppState().unitState.editForm(v);
                            sShowDialog(
                              context: ctx,
                              builder: (c) {
                                return const UnitAddWidget(title: "Edit Unit");
                              },
                            );
                          }),
                          SColumActionItem('hapus', Icons.delete_forever, () async {
                            final result = await showConfirmation(ctx,
                                title: 'Yakin hapus', message: 'Yakin untuk menghapus "${v.name}"');
                            if (result) {
                              try {
                                await AppState().unitState.remove(v.id);
                              } catch (e) {
                                // ignore: use_build_context_synchronously
                                showError(ctx, message: e.toString());
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
