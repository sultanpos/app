import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/master.dart';
import 'package:sultanpos/ui/master/category/category.dart';
import 'package:sultanpos/ui/master/pricegroup/pricegroup.dart';
import 'package:sultanpos/ui/master/unit/unit.dart';
import 'package:sultanpos/ui/widget/verticalmenu.dart';

class MasterRootWidget extends StatelessWidget {
  const MasterRootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AppState().masterState,
      child: Builder(
        builder: (ctx) {
          return VerticalMenu(
            currentId: ctx.select<MasterState, String?>((value) => value.currentId) ?? "category",
            onChanged: (value) => AppState().masterState.setCurrentId(value),
            width: 80,
            menus: [
              VerticalMenuItem<String>(
                  title: 'Kategori', id: 'category', icon: Icons.account_tree, widget: (ctx) => const CategoryWidget()),
              VerticalMenuItem<String>(
                  title: 'Unit', id: 'unit', icon: Icons.scale, widget: (ctx) => const UnitWidget()),
              VerticalMenuItem<String>(
                  title: 'Harga', id: 'price', icon: Icons.attach_money, widget: (ctx) => const PriceGroupWidget()),
            ],
          );
        },
      ),
    );
  }
}
