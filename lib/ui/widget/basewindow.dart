import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseWindowWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final double? width;
  final double? height;
  final IconData? icon;
  const BaseWindowWidget({Key? key, required this.title, this.width, this.height, required this.child, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor = Theme.of(context).secondaryHeaderColor;
    return Dialog(
      backgroundColor: bgColor,
      child: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (value) {
          if (value.logicalKey == LogicalKeyboardKey.escape) {
            Navigator.pop(context);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          width: width ?? 300,
          height: height ?? 300,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  BaseWindowIcon(
                    icon: icon,
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(title, style: Theme.of(context).textTheme.titleLarge),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: child,
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
