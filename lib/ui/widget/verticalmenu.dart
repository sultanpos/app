import 'package:flutter/material.dart';

class VerticalMenuItem {
  final String title;
  final String id;
  final IconData? icon;
  final Widget Function() widget;
  VerticalMenuItem({required this.title, required this.id, this.icon, required this.widget});
}

class VerticalMenuItemWidget extends StatefulWidget {
  final String title;
  final String id;
  final IconData? icon;
  final bool selected;
  final VoidCallback? onClick;
  final double? width;
  const VerticalMenuItemWidget(
      {required this.title, required this.id, this.icon, required this.selected, required this.onClick, this.width, Key? key})
      : super(key: key);

  @override
  State<VerticalMenuItemWidget> createState() => _VerticalMenuItemWidgetState();
}

class _VerticalMenuItemWidgetState extends State<VerticalMenuItemWidget> {
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
        margin: const EdgeInsets.only(bottom: 4),
        width: widget.width,
        decoration: BoxDecoration(
            color: _onHover || widget.selected ? bgColor : Colors.black,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(4.0), bottomLeft: Radius.circular(4.0))),
        padding: const EdgeInsets.all(8),
        child: Column(children: [Icon(widget.icon), Text(widget.title)]),
      ),
    );
  }
}

class VerticalMenu extends StatelessWidget {
  final List<VerticalMenuItem> menus;
  final double? width;
  final String currentId;
  final Function(String) onChanged;
  const VerticalMenu({required this.menus, this.width, required this.currentId, required this.onChanged, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final index = menus.indexWhere(
      (element) => element.id == currentId,
    );
    return Row(
      children: [
        Container(
          color: Colors.black,
          width: width ?? 60,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: menus
                  .map((e) => VerticalMenuItemWidget(
                        title: e.title,
                        id: e.id,
                        selected: e.id == currentId,
                        icon: e.icon,
                        width: width,
                        onClick: () {
                          onChanged(e.id);
                        },
                      ))
                  .toList()),
        ),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            child: menus[index].widget(),
          ),
        ),
      ],
    );
  }
}
