import 'package:flutter/material.dart';
import 'package:sultanpos/app.dart';
import 'package:sultanpos/flavor.dart';

Future<void> main() async {
  Flavor.appFlavor = FlavorType.development;
  Flavor.baseUrl = "http://localhost:6789";
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}
