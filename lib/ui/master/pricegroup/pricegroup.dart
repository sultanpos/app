import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/model/pricegroup.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/pricegroup.dart';
import 'package:sultanpos/ui/master/pricegroup/add.dart';
import 'package:sultanpos/ui/widget/confirmation.dart';
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
                const Divider(),
                Expanded(
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
