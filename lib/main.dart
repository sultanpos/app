import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:sultanpos/app.dart';
import 'package:sultanpos/flavor.dart';

Future<void> main() async {
  Flavor.appFlavor = FlavorType.development;
  Flavor.baseUrl = "https://dev.sultanpos-api.lekapin.com";
  WidgetsFlutterBinding.ensureInitialized();
  await hotKeyManager.unregisterAll();
  runApp(const App());
}
