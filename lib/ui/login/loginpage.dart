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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
                child: Row(children: [
                  Expanded(child: MoveWindow()),
                  const WindowButtons(),
                ]),
              ),
              const LoginWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
