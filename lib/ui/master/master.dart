import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/ui/master/category/category.dart';
import 'package:sultanpos/ui/master/pricegroup/pricegroup.dart';
import 'package:sultanpos/ui/master/unit/unit.dart';
import 'package:sultanpos/ui/widget/verticalmenu.dart';

class MasterRootWidget extends StatelessWidget {
  const MasterRootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AppState().masterState!,
      child: Builder(
        builder: (ctx) {
          return VerticalMenu(width: 80, menus: [
            VerticalMenuItem(title: 'Kategori', id: 'category', icon: Icons.account_tree, widget: () => const CategoryWidget()),
            VerticalMenuItem(title: 'Unit', id: 'unit', icon: Icons.scale, widget: () => const UnitWidget()),
            VerticalMenuItem(title: 'Harga', id: 'price', icon: Icons.attach_money, widget: () => const PriceGroupWidget()),
          ]);
        },
      ),
    );
  }
}
