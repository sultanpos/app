import 'package:flutter/material.dart';
import 'package:sultanpos/ui/layout/navigator.dart';
import 'package:sultanpos/ui/layout/drawer.dart';

class MainLayoutWidget extends StatelessWidget {
  const MainLayoutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      DrawerWidget(),
      const Expanded(child: NavigatorWidget()),
    ]);
  }
}
