import 'package:flutter/material.dart';
import 'package:sultanpos/ui/util/color.dart';

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
  const VerticalMenuItemWidget({required this.title, required this.id, this.icon, required this.selected, required this.onClick, Key? key})
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
        decoration: BoxDecoration(
            color: _onHover || widget.selected ? bgColor : lighterOrDarkerColor(Theme.of(context), bgColor, amount: 0.1),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(4.0), bottomLeft: Radius.circular(4.0))),
        padding: const EdgeInsets.all(8),
        child: Column(children: [Icon(widget.icon), Text(widget.title)]),
      ),
    );
  }
}

class VerticalMenu extends StatefulWidget {
  final List<VerticalMenuItem> menus;
  const VerticalMenu({required this.menus, Key? key}) : super(key: key);

  @override
  State<VerticalMenu> createState() => _VerticalMenuState();
}

class _VerticalMenuState extends State<VerticalMenu> {
  late String _currentId;

  @override
  void initState() {
    super.initState();
    _currentId = widget.menus[0].id;
  }

  @override
  Widget build(BuildContext context) {
    final index = widget.menus.indexWhere(
      (element) => element.id == _currentId,
    );
    return Row(
      children: [
        Container(
          color: Colors.black,
          width: 60,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: widget.menus
                  .map((e) => VerticalMenuItemWidget(
                        title: e.title,
                        id: e.id,
                        selected: e.id == _currentId,
                        icon: e.icon,
                        onClick: () {
                          _currentId = e.id;
                          setState(() {});
                        },
                      ))
                  .toList()),
        ),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            child: widget.menus[index].widget(),
          ),
        ),
      ],
    );
  }
}
