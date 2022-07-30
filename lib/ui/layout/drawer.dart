import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:sultanpos/state/app.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/state/navigation.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AppState().navState!,
      child: Builder(builder: (ctx) {
        return SideNavigationBar(
          selectedIndex: ctx.select<NavigationState, int>((value) => value.currentIndex),
          items: const [
            SideNavigationBarItem(
              icon: Icons.dashboard,
              label: 'Dashboard',
            ),
            SideNavigationBarItem(
              icon: Icons.person,
              label: 'Account',
            ),
            SideNavigationBarItem(
              icon: Icons.settings,
              label: 'Settings',
            ),
          ],
          onTap: (index) {
            ctx.read<NavigationState>().setCurrentIndex(index);
            AppState().navState!.navigatorKey.currentState!.pushReplacementNamed('/notfound');
          },
        );
      }),
    );
  }
}
