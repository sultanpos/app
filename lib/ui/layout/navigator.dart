import 'package:flutter/material.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/ui/cashier/cashier.dart';
import 'package:sultanpos/ui/layout/home.dart';
import 'package:sultanpos/ui/layout/noroute.dart';
import 'package:sultanpos/ui/master/master.dart';
import 'package:sultanpos/ui/partner/partner.dart';
import 'package:sultanpos/ui/product/product.dart';
import 'package:sultanpos/ui/profile/profile.dart';
import 'package:sultanpos/ui/purchase/purchase.dart';
import 'package:sultanpos/ui/report/report.dart';
import 'package:sultanpos/ui/setting/setting.dart';

class NavigatorWidget extends StatelessWidget {
  const NavigatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: AppState().navState.navigatorKey,
      initialRoute: "/",
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return _pageBuilder(settings, () => const HomeWidget());
          case "/product":
            return _pageBuilder(settings, () => const ProductRootWidget());
          case "/cashier":
            return _pageBuilder(settings, () => const CashierWidget());
          case "/master":
            return _pageBuilder(settings, () => const MasterRootWidget());
          case "/setting":
            return _pageBuilder(settings, () => const SettingWidget());
          case "/profile":
            return _pageBuilder(settings, () => const ProfileWidget());
          case "/purchase":
            return _pageBuilder(settings, () => const PurchaseWidget());
          case "/report":
            return _pageBuilder(settings, () => const ReportWidget());
          case "/partner":
            return _pageBuilder(settings, () => const PartnerWidget());
          default:
            return _pageBuilder(settings, () => const NoRouteWidget());
        }
      },
    );
  }

  _pageBuilder(RouteSettings settings, Function retWidget) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => retWidget(),
      transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
      transitionDuration: const Duration(milliseconds: 0),
    );
  }
}
