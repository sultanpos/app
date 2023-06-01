import 'package:flutter/material.dart';

class SColumActionItem {
  final VoidCallback onTap;
  final String title;
  final IconData icon;
  final Color? iconColor;
  SColumActionItem(this.title, this.icon, this.onTap, {this.iconColor});
}

class SColumnAction extends StatelessWidget {
  final List<SColumActionItem> items;
  const SColumnAction(this.items, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PopupMenuButton(
        itemBuilder: (context) => items.map((e) {
          return PopupMenuItem(
            height: 30,
            onTap: e.onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  e.icon,
                  color: e.iconColor,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(e.title),
              ],
            ),
          );
        }).toList(),
        child: Text(
          "aksi",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
