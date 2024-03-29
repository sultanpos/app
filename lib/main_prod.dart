import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:lehttp_overrides/lehttp_overrides.dart';
import 'package:scaled_app/scaled_app.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sultanpos/app.dart';
import 'package:sultanpos/flavor.dart';
import 'package:sultanpos/ui/theme.dart';

Future<void> main() async {
  Flavor.appFlavor = FlavorType.production;
  Flavor.baseUrl = "https://sultanpos-api.lekapin.com";
  Flavor.baseUrlWs = "wss://sultanpos-api.lekapin.com";
  ScaledWidgetsFlutterBinding.ensureInitialized(
    scaleFactor: (deviceSize) => 1,
  );
  if (Platform.isAndroid) {
    HttpOverrides.global = LEHttpOverrides();
  }
  STheme().init();
  sqfliteFfiInit();
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
