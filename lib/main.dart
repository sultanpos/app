import 'package:flutter/material.dart';
import 'package:sultanpos/app.dart';
import 'package:sultanpos/flavor.dart';

Future<void> main() async {
  Flavor.appFlavor = FlavorType.development;
  Flavor.baseUrl = "https://dev.sultanpos-api.lekapin.com";
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}
