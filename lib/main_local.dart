import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:lehttp_overrides/lehttp_overrides.dart';
import 'package:scaled_app/scaled_app.dart';
import 'package:sultanpos/app.dart';
import 'package:sultanpos/flavor.dart';
import 'package:sultanpos/ui/theme.dart';
import 'dart:io' show HttpOverrides, Platform;

Future<void> main() async {
  Flavor.appFlavor = FlavorType.development;
  Flavor.baseUrl = "http://172.30.191.65:6789";
  Flavor.baseUrlWs = "ws://172.30.191.65:6789";
  ScaledWidgetsFlutterBinding.ensureInitialized(
    scaleFactor: (deviceSize) => 1,
  );
  if (Platform.isAndroid) {
    HttpOverrides.global = LEHttpOverrides();
  }
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
