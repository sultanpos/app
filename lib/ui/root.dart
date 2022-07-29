import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/ui/splashscreen.dart';

class RootWidgetProvider extends StatelessWidget {
  const RootWidgetProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
      child: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(settings: settings, builder: (c) => const SplashScreen());
        },
      ),
    );
  }
}

class RootWidget extends StatelessWidget {
  const RootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text("Logout"),
            ),
          ),
        ],
      ),
    );
  }
}
