import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sultanpos/ui/widget/space.dart';

class BaseWindowWidget extends StatefulWidget {
  final Widget child;
  final String title;
  final double? width;
  final double? height;
  final IconData? icon;
  const BaseWindowWidget({Key? key, required this.title, this.width, this.height, required this.child, this.icon})
      : super(key: key);

  @override
  State<BaseWindowWidget> createState() => _BaseWindowWidgetState();
}

class _BaseWindowWidgetState extends State<BaseWindowWidget> {
  final _focusNode = FocusNode(debugLabel: "dialog");

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = Theme.of(context).secondaryHeaderColor;
    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.escape): () {
          Navigator.pop(context, false);
        },
      },
      child: Dialog(
        backgroundColor: bgColor,
        child: Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          width: widget.width ?? 300,
          height: widget.height ?? 300,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  BaseWindowIcon(
                    icon: widget.icon,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  ),
                ],
              ),
              const SVSpace(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
                  child: widget.child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BaseWindowIcon extends StatelessWidget {
  final IconData? icon;
  const BaseWindowIcon({super.key, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(color: Color(0xff374151), shape: BoxShape.circle),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(color: Color(0xff1F2937), shape: BoxShape.circle),
        child: Icon(icon),
      ),
    );
  }
}
