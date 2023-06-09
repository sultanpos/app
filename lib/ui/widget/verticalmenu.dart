import 'package:flutter/material.dart';

class VerticalMenuItem<T> {
  final String title;
  final T id;
  final IconData? icon;
  final Widget Function() widget;
  final bool closable;
  final bool vertical;
  final VoidCallback? onCloseClicked;
  VerticalMenuItem({
    required this.title,
    required this.id,
    this.icon,
    required this.widget,
    this.closable = false,
    this.vertical = false,
    this.onCloseClicked,
  });
}

class VerticalMenuItemWidget<T> extends StatefulWidget {
  final VerticalMenuItem<T> item;
  final bool selected;
  final VoidCallback? onClick;
  final double? width;
  const VerticalMenuItemWidget(this.item, {required this.selected, required this.onClick, this.width, Key? key})
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
        width: widget.item.vertical ? 60 : widget.width,
        decoration: BoxDecoration(
            color: _onHover || widget.selected ? bgColor : Colors.black,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(4.0), bottomLeft: Radius.circular(4.0))),
        padding: const EdgeInsets.all(8),
        child: widget.item.vertical
            ? verticalText(context)
            : Column(children: [Icon(widget.item.icon), Text(widget.item.title)]),
      ),
    );
  }

  Widget verticalText(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: Row(
        children: [
          Text(widget.item.title),
          if (widget.item.closable)
            SizedBox(
              width: 40,
              child: TextButton(
                onPressed: widget.item.onCloseClicked,
                child: const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              ),
            )
        ],
      ),
    );
  }
}

class VerticalMenu<T> extends StatelessWidget {
  final List<VerticalMenuItem<T>> menus;
  final double? width;
  final T currentId;
  final Function(T) onChanged;
  const VerticalMenu({required this.menus, this.width, required this.currentId, required this.onChanged, Key? key})
      : super(key: key);

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
          child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: menus
                  .map((e) => VerticalMenuItemWidget<T>(
                        e,
                        selected: e.id == currentId,
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
