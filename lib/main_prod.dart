import 'package:flutter/material.dart';
import 'package:sultanpos/app.dart';
import 'package:sultanpos/flavor.dart';

Future<void> main() async {
  Flavor.appFlavor = FlavorType.production;
  Flavor.baseUrl = "https://sultanpos-api.lekapin.com";
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}
