import 'package:flutter/material.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/ui/layout/home.dart';
import 'package:sultanpos/ui/layout/noroute.dart';

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
          default:
            return MaterialPageRoute(builder: (_) => const NoRouteWidget());
        }
      },
    );
  }
}
