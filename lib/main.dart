import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:sultanpos/app.dart';
import 'package:sultanpos/flavor.dart';

Future<void> main() async {
  Flavor.appFlavor = FlavorType.development;
  Flavor.baseUrl = "https://dev.sultanpos-api.lekapin.com";
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
  doWhenWindowReady(() {
    const initialSize = Size(1280, 720);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}
