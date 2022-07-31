import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/product.dart';

class ProductRootWidget extends StatelessWidget {
  const ProductRootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AppState().productState!,
      child: Builder(builder: (ctx) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  TextButton.icon(
                      onPressed: () {
                        AppState().productState!.setCurrentIndex(0);
                      },
                      icon: const Icon(Icons.inventory),
                      label: const Text('Barang')),
                  TextButton.icon(
                      onPressed: () {
                        AppState().productState!.setCurrentIndex(1);
                      },
                      icon: const Icon(Icons.attach_money),
                      label: const Text('Harga')),
                  TextButton.icon(
                      onPressed: () {
                        AppState().productState!.setCurrentIndex(2);
                      },
                      icon: const Icon(Icons.sell),
                      label: const Text('Group Harga')),
                  TextButton.icon(
                      onPressed: () {
                        AppState().productState!.setCurrentIndex(3);
                      },
                      icon: const Icon(Icons.straighten),
                      label: const Text('Unit')),
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
    final index = context.select<ProductState, int>((value) => value.currentIndex);
    return Text(
      'Widget $index',
      key: ValueKey<int>(index),
    );
  }
}
