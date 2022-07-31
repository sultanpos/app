import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/master.dart';

class MasterRootWidget extends StatelessWidget {
  const MasterRootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AppState().masterState!,
      child: Builder(builder: (ctx) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      AppState().masterState!.setCurrentIndex(3);
                    },
                    icon: const Icon(Icons.straighten),
                    label: const Text('Unit'),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      AppState().masterState!.setCurrentIndex(2);
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
                child: _getWidget(ctx),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget _getWidget(BuildContext context) {
    final index = context.select<MasterState, int>((value) => value.currentIndex);
    return Text(
      'Widget $index',
      key: ValueKey<int>(index),
    );
  }
}
