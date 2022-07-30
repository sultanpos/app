import 'package:flutter/material.dart';

class NavigationState extends ChangeNotifier {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  int currentIndex = 0;

  setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
