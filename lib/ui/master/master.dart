import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/master.dart';
import 'package:sultanpos/ui/master/pricegroup/pricegroup.dart';
import 'package:sultanpos/ui/master/unit/unit.dart';

class MasterRootWidget extends StatelessWidget {
  MasterRootWidget({Key? key}) : super(key: key);

  final widgets = [
    () => UnitWidget(),
    () => const PriceGroupWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AppState().masterState!,
      child: Builder(
        builder: (ctx) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        AppState().masterState!.setCurrentIndex(0);
                      },
                      icon: const Icon(Icons.straighten),
                      label: const Text('Unit'),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        AppState().masterState!.setCurrentIndex(1);
                      },
                      icon: const Icon(Icons.sell),
                      label: const Text('Group Harga'),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  child: Builder(builder: (ctx) {
                    final index = ctx.select<MasterState, int>((value) => value.currentIndex);
                    return widgets[index]();
                  }),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
