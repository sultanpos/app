import 'package:flutter/material.dart';
import 'package:sultanpos/state/app.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/state/navigation.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final String route;
  MenuItem({required this.title, required this.icon, required this.route});
}

class MainMenuItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback? onClick;
  const MainMenuItem(this.title, this.icon, this.selected, {Key? key, this.onClick}) : super(key: key);

  @override
  State<MainMenuItem> createState() => _MainMenuItemState();
}

class _MainMenuItemState extends State<MainMenuItem> {
  bool _onHover = false;
  @override
  Widget build(BuildContext context) {
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    return InkWell(
      onTapDown: (details) {
        if (widget.onClick != null) widget.onClick!();
      },
      onHover: (value) {
        setState(() {
          _onHover = value;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: _onHover || widget.selected ? bgColor : Colors.black,
            //border: widget.selected ? Border.all(color: Colors.red) : null,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            )),
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          Icon(widget.icon),
          Text(
            widget.title,
            style: TextStyle(fontSize: 10),
          )
        ]),
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  DrawerWidget({Key? key}) : super(key: key);

  final items = <MenuItem>[
    MenuItem(title: 'Dashboard', icon: Icons.dashboard, route: "/"),
    MenuItem(title: 'Barang', icon: Icons.inventory_2, route: "/product"),
    MenuItem(title: 'Mitra', icon: Icons.people, route: "/partner"),
    MenuItem(title: 'Kasir', icon: Icons.point_of_sale, route: "/cashier"),
    MenuItem(title: 'Pembelian', icon: Icons.shopping_cart, route: "/purchase"),
    MenuItem(title: 'Laporan', icon: Icons.assessment, route: "/report"),
    MenuItem(title: 'Master', icon: Icons.folder_open, route: "/master"),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AppState().navState,
      child: Builder(
        builder: (ctx) {
          final curPath = ctx.select<NavigationState, String>((value) => value.currentPath);
          return Row(
            children: [
              ...items.map((e) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: MainMenuItem(
                    e.title,
                    e.icon,
                    curPath == e.route,
                    onClick: () {
                      if (curPath == e.route) return;
                      AppState().navigateTo(e.route);
                    },
                  ),
                );
              }).toList(),
            ],
          );
        },
      ),
    );
  }
}
