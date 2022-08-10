import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/model/pricegroup.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/pricegroup.dart';
import 'package:sultanpos/ui/master/pricegroup/add.dart';
import 'package:sultanpos/ui/widget/confirmation.dart';
import 'package:sultanpos/ui/widget/datatable.dart';
import 'package:sultanpos/ui/widget/listwidget.dart';
import 'package:sultanpos/ui/widget/showerror.dart';

class PriceGroupWidget extends HookWidget {
  const PriceGroupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      AppState().priceGroupState!.listData.load();
      return null;
    }, []);
    return ChangeNotifierProvider<PriceGroupState>.value(
      value: AppState().priceGroupState!,
      child: Builder(
        builder: (ctx) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Daftar Group Harga',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Expanded(child: SizedBox()),
                    ElevatedButton(
                      onPressed: () {
                        AppState().priceGroupState!.resetForm();
                        showDialog(
                          context: ctx,
                          useRootNavigator: false,
                          builder: (c) {
                            return const PriceGroupAddWidget(
                              title: "Tambah Group Harga Baru",
                            );
                          },
                        );
                      },
                      child: const Text('Tambah Group Harga'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                    child: SDataTable<PriceGroupModel>(
                  name: "pricegroup",
                  state: AppState().priceGroupState!.listData,
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
                                  AppState().priceGroupState!.editForm(v);
                                  showDialog(
                                    context: ctx,
                                    useRootNavigator: false,
                                    builder: (c) {
                                      return const PriceGroupAddWidget(title: "Edit group harga");
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
                                      await AppState().unitState!.remove(v.publicId);
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
                /*Expanded(
                  child: ListWidget<PriceGroupModel>(
                    AppState().priceGroupState!.listData,
                    builder: (BuildContext ctx, PriceGroupModel value) {
                      return ListTile(
                        title: Text(value.name),
                        onTap: () {
                          AppState().priceGroupState!.editForm(value);
                          showDialog(
                            context: ctx,
                            useRootNavigator: false,
                            builder: (c) {
                              return const PriceGroupAddWidget(title: "Edit Group Harga");
                            },
                          );
                        },
                        trailing: value.isDefault
                            ? null
                            : IconButton(
                                onPressed: () async {
                                  final result = await showConfirmation(ctx, title: 'Yakin hapus', message: 'Yakin untuk menghapus "${value.name}"');
                                  if (result) {
                                    try {
                                      await AppState().priceGroupState!.remove(value.publicId);
                                    } catch (e) {
                                      // ignore: use_build_context_synchronously
                                      showError(ctx, title: 'Error menghapus', message: e.toString());
                                    }
                                  }
                                },
                                icon: const Icon(Icons.delete)),
                      );
                    },
                  ),
                ),*/
              ],
            ),
          );
        },
      ),
    );
  }
}
