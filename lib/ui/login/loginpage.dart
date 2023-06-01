import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/ui/layout/mainlayout.dart';
import 'package:sultanpos/ui/login/loginwidget.dart';

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
            const Spacer(),
            Container(
              width: 400,
              decoration: BoxDecoration(
                color: Theme.of(context).secondaryHeaderColor,
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              child: const LoginWidget(),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
