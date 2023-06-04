import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/purchase.dart';
import 'package:sultanpos/ui/purchase/purchaselist.dart';
import 'package:sultanpos/ui/widget/verticalmenu.dart';
import 'dart:math';
import 'dart:convert';

class PurchaseWidget extends StatelessWidget {
  const PurchaseWidget({Key? key}) : super(key: key);

  String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AppState().purchaseState,
      child: Builder(
        builder: (ctx) {
          final state = ctx.watch<PurchaseState>();
          return VerticalMenu(
            currentId: state.currentId ?? "list",
            onChanged: (value) => AppState().purchaseState.setCurrentId(value),
            width: 60,
            menus: [
              VerticalMenuItem(
                title: 'Daftar',
                id: 'list',
                icon: Icons.list_alt,
                widget: () => const PurchaseListWidget(),
              ),
              /*...state.items
                  .map(
                    (e) => VerticalMenuItem(
                        title: e.title,
                        id: e.id,
                        widget: () => ChangeNotifierProvider.value(
                              value: state.getPurchaseEditState(e.id),
                              child: const PurchaseEditWidget(),
                            ),
                        vertical: true,
                        closable: true,
                        onCloseClicked: () {
                          state.closeTab(e.id);
                        }),
                  )
                  .toList(),*/
            ],
          );
        },
      ),
    );
  }
}
