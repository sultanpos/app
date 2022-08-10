import 'package:flutter/material.dart';

class NavigationState extends ChangeNotifier {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  String currentPath = "/";

  navigateTo(String path) {
    navigatorKey.currentState!.pushReplacementNamed(path);
    currentPath = path;
    notifyListeners();
  }
}
