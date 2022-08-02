import 'package:flutter/material.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/ui/cashier/cashier.dart';
import 'package:sultanpos/ui/layout/home.dart';
import 'package:sultanpos/ui/layout/noroute.dart';
import 'package:sultanpos/ui/master/master.dart';
import 'package:sultanpos/ui/product/productroot.dart';

class NavigatorWidget extends StatelessWidget {
  const NavigatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: AppState().navState!.navigatorKey,
      initialRoute: "/",
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const HomeWidget());
          case "/product":
            return MaterialPageRoute(builder: (_) => const ProductRootWidget());
          case "/cashier":
            return MaterialPageRoute(builder: (_) => const CashierWidget());
          case "/master":
            return MaterialPageRoute(builder: (_) => MasterRootWidget());
          default:
            return MaterialPageRoute(builder: (_) => const NoRouteWidget());
        }
      },
    );
  }
}
