import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sultanpos/extension/rawkeyevent.dart';
import 'package:sultanpos/ui/widget/space.dart';
import 'package:tinycolor2/tinycolor2.dart';

class TileSelectData<T> {
  final T id;
  final String title;
  final String description;
  TileSelectData({required this.id, required this.title, required this.description});
}

typedef TileSelectOnSelect<T> = void Function(T value);

class TileSelect<T> extends StatelessWidget {
  final List<TileSelectData<T>> items;
  final T current;
  final TileSelectOnSelect<T> onSelected;
  const TileSelect({required this.items, required this.current, required this.onSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map((e) => Column(
                children: [
                  TileSelectItem(
                    selected: current == e.id,
                    autoFocus: current == e.id,
                    data: e,
                    onTap: () {
                      onSelected(e.id);
                    },
                  ),
                  const SVSpaceSmall(),
                ],
              ))
          .toList(),
    );
  }
}

class TileSelectItem<T> extends StatefulWidget {
  final bool selected;
  final TileSelectData<T> data;
  final VoidCallback onTap;
  final bool? autoFocus;
  const TileSelectItem({required this.selected, required this.data, required this.onTap, this.autoFocus, super.key});

  @override
  State<TileSelectItem> createState() => _TileSelectItemState();
}

class _TileSelectItemState extends State<TileSelectItem> {
  bool _inHover = false;
  bool _inFocus = false;
  final FocusNode _node = FocusNode();

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).scaffoldBackgroundColor;
    return Focus(
      autofocus: widget.autoFocus ?? false,
      focusNode: _node,
      onKeyEvent: (node, event) {
        if (node == _node && event.isPressed(LogicalKeyboardKey.space)) {
          widget.onTap();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      onFocusChange: (value) => setState(() {
        _inFocus = value;
      }),
      child: InkWell(
        onTap: widget.onTap,
        onHover: (value) => setState(() {
          _inHover = value;
        }),
        child: Container(
          decoration: BoxDecoration(
            color: _inHover || _inFocus ? TinyColor.fromColor(color).brighten(4).color : color,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                      child: widget.selected
                          ? const Icon(
                              Icons.check,
                              color: Colors.green,
                              size: 32,
                            )
                          : null,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.data.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SVSpaceSmall(),
                          Text(widget.data.description),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
