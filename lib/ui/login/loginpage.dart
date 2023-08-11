import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/ui/login/loginwidget.dart';
import 'package:sultanpos/ui/login/registerwidget.dart';
import 'package:sultanpos/ui/widget/windowbutton.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AppState().authState,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 30,
              child: Row(children: [
                Expanded(child: MoveWindow()),
                const WindowButtons(),
              ]),
            ),
            Expanded(
                child: Navigator(
              initialRoute: "/",
              onGenerateRoute: (settings) {
                switch (settings.name) {
                  case '/':
                    return _pageBuilder(settings, () => const LoginWidget());
                  case '/register':
                    return _pageBuilder(settings, () => const RegisterWidget());
                }
                return null;
              },
            ))
          ],
        ),
      ),
    );
  }

  _pageBuilder(RouteSettings settings, Function retWidget) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => retWidget(),
      //transitionsBuilder: (_, a, __, c) => SlideTransition(position: )),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, -1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 50),
    );
  }
}
