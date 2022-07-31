import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:sultanpos/state/app.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/state/navigation.dart';
import 'package:sultanpos/ui/login/loginpage.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final String route;
  MenuItem({required this.title, required this.icon, required this.route});
}

class DrawerWidget extends StatelessWidget {
  DrawerWidget({Key? key}) : super(key: key);

  final items = <MenuItem>[
    MenuItem(title: 'Dashboard', icon: Icons.dashboard, route: "/"),
    MenuItem(title: 'Barang', icon: Icons.inventory_2, route: "/product"),
    MenuItem(title: 'Kasir', icon: Icons.desktop_windows, route: "/cashier"),
    MenuItem(title: 'Master', icon: Icons.folder, route: "/master"),
    MenuItem(title: 'Keluar', icon: Icons.exit_to_app, route: "/logout"),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AppState().navState!,
      child: Builder(
        builder: (ctx) {
          return SideNavigationBar(
            selectedIndex: ctx.select<NavigationState, int>((value) => value.currentIndex),
            items: items.map((e) => SideNavigationBarItem(icon: e.icon, label: e.title)).toList(),
            onTap: (index) {
              if (items[index].route == '/logout') {
                AppState().authState!.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginPage(),
                  ),
                );
                return;
              }
              ctx.read<NavigationState>().setCurrentIndex(index);
              AppState().navigateTo(items[index].route);
            },
          );
        },
      ),
    );
  }
}
