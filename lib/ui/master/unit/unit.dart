import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/model/unit.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/unit.dart';
import 'package:sultanpos/ui/master/unit/add.dart';
import 'package:sultanpos/ui/widget/confirmation.dart';
import 'package:sultanpos/ui/widget/listwidget.dart';
import 'package:sultanpos/ui/widget/showerror.dart';

class UnitWidget extends HookWidget {
  const UnitWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      AppState().unitState!.listData.load();
      return null;
    }, []);
    return ChangeNotifierProvider<UnitState>.value(
      value: AppState().unitState!,
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
                    ElevatedButton(
                      onPressed: () {
                        AppState().unitState!.resetForm();
                        showDialog(
                          context: ctx,
                          useRootNavigator: false,
                          builder: (c) {
                            return const UnitAddWidget(
                              title: "Tambah Unit Baru",
                            );
                          },
                        );
                      },
                      child: const Text('Tambah Unit'),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: ListWidget<UnitModel>(
                    AppState().unitState!.listData,
                    builder: (BuildContext ctx, UnitModel value) {
                      return ListTile(
                        title: Text(value.name),
                        onTap: () {
                          AppState().unitState!.editForm(value);
                          showDialog(
                            context: ctx,
                            useRootNavigator: false,
                            builder: (c) {
                              return const UnitAddWidget(title: "Edit Unit");
                            },
                          );
                        },
                        trailing: IconButton(
                            onPressed: () async {
                              final result = await showConfirmation(ctx, title: 'Yakin hapus', message: 'Yakin untuk menghapus "${value.name}"');
                              if (result) {
                                try {
                                  await AppState().unitState!.remove(value.publicId);
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
