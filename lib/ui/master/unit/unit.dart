import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/model/unit.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/unit.dart';
import 'package:sultanpos/ui/master/unit/add.dart';
import 'package:sultanpos/ui/widget/listwidget.dart';

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
                    const Text('Daftar Unit'),
                    const Expanded(child: SizedBox()),
                    ElevatedButton(
                      onPressed: () {
                        AppState().unitState!.resetForm();
                        showDialog(
                          context: ctx,
                          useRootNavigator: false,
                          builder: (c) {
                            return const UnitAddWidget();
                          },
                        );
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: ListWidget<Unit>(
                    AppState().unitState!.listData,
                    builder: (BuildContext ctx, Unit value) {
                      return ListTile(
                        title: Text(value.name),
                        onTap: () {},
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
