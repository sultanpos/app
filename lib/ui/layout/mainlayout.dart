import 'package:flutter/material.dart';
import 'package:sultanpos/ui/layout/navigator.dart';
import 'package:sultanpos/ui/layout/drawer.dart';

class MainLayoutWidget extends StatelessWidget {
  const MainLayoutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(children: [
      DrawerWidget(),
      VerticalDivider(
        width: 0,
        color: isDark ? Colors.white : Colors.grey,
      ),
      const Expanded(child: NavigatorWidget()),
    ]);
  }
}
