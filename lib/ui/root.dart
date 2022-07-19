import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/state/auth.dart';
import 'package:sultanpos/ui/login/loginwidget.dart';

class RootWidgetProvider extends StatelessWidget {
  const RootWidgetProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StateAuth()),
      ],
      child: const RootWidget(),
    );
  }
}

class RootWidget extends StatelessWidget {
  const RootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loggedIn = context.select((StateAuth s) => s.loggedIn);
    return Scaffold(
      body: Stack(
        children: [
          if (!loggedIn) const LoginWidget(),
          if (loggedIn)
            Center(
              child: TextButton(
                onPressed: () {
                  final auth = context.read<StateAuth>();
                  auth.setLoggedIn(false);
                },
                child: const Text("Logout"),
              ),
            ),
        ],
      ),
    );
  }
}
