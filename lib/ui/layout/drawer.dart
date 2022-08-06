import 'package:flutter/material.dart';
import 'package:sultanpos/state/app.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/state/navigation.dart';
import 'package:sultanpos/ui/login/loginpage.dart';
import 'package:sultanpos/ui/util/color.dart';

class MenuItem {
  final int index;
  final String title;
  final IconData icon;
  final String route;
  MenuItem(this.index, {required this.title, required this.icon, required this.route});
}

class MainMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback? onClick;
  const MainMenuItem(this.title, this.icon, this.selected, {Key? key, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 24,
      onPressed: onClick,
      tooltip: title,
      icon: Icon(
        icon,
        color: selected ? Colors.blue[700]! : null,
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  DrawerWidget({Key? key}) : super(key: key);

  final items = <MenuItem>[
    MenuItem(0, title: 'Dashboard', icon: Icons.dashboard, route: "/"),
    MenuItem(1, title: 'Barang', icon: Icons.inventory_2, route: "/product"),
    MenuItem(2, title: 'Kasir', icon: Icons.point_of_sale, route: "/cashier"),
    MenuItem(3, title: 'Pembelian', icon: Icons.shopping_cart, route: "/"),
    MenuItem(4, title: 'Laporan', icon: Icons.assessment, route: "/"),
    MenuItem(5, title: 'Master', icon: Icons.folder_open, route: "/master"),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AppState().navState!,
      child: Builder(
        builder: (ctx) {
          final curIndex = ctx.select<NavigationState, int>((value) => value.currentIndex);
          final bgColor = Theme.of(context).scaffoldBackgroundColor;
          return Container(
            padding: const EdgeInsets.all(4.0),
            color: lighterOrDarkerColor(Theme.of(context), bgColor),
            child: Column(
              children: [
                ...items.map((e) {
                  return MainMenuItem(
                    e.title,
                    e.icon,
                    curIndex == e.index,
                    onClick: () {
                      if (curIndex == e.index) return;
                      ctx.read<NavigationState>().setCurrentIndex(e.index);
                      AppState().navigateTo(items[e.index].route);
                    },
                  );
                }).toList(),
                const Expanded(child: SizedBox()),
                PopupMenuButton(
                  offset: const Offset(30, 0),
                  onSelected: (value) {
                    switch (value) {
                      case 'logout':
                        {
                          AppState().authState!.resetForm();
                          AppState().authState!.logout();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginPage(),
                            ),
                          );
                        }
                        break;
                    }
                  },
                  itemBuilder: (ctx) => [
                    _popupMenuItem("setting", "Setting", Icons.settings),
                    _popupMenuItem("profile", "Profile", Icons.person),
                    _popupMenuItem("logout", "Keluar", Icons.exit_to_app),
                  ],
                  icon: const Icon(Icons.person),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  PopupMenuItem<String> _popupMenuItem(String value, String title, IconData icon) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(
            width: 8,
          ),
          Text(title)
        ],
      ),
    );
  }
}
