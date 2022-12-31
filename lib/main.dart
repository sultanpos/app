import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:sultanpos/app.dart';
import 'package:sultanpos/flavor.dart';
import 'package:sultanpos/ui/theme.dart';
import 'dart:io' show Platform;

Future<void> main() async {
  Flavor.appFlavor = FlavorType.development;
  Flavor.baseUrl = "https://dev.sultanpos-api.lekapin.com";
  WidgetsFlutterBinding.ensureInitialized();
  STheme().init();
  runApp(const App());
  if (Platform.isWindows) {
    doWhenWindowReady(() {
      const initialSize = Size(1280, 720);
      appWindow.minSize = initialSize;
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.show();
    });
  }
}
