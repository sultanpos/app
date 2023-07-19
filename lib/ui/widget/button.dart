import 'package:flutter/material.dart';
import 'package:sultanpos/ui/theme.dart';

class SButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? label;
  final double? height;
  final double? width;
  final bool positive;
  final Widget? child;
  final Icon? icon;
  final Color? color;
  const SButton({
    super.key,
    this.onPressed,
    this.child,
    this.label,
    this.height,
    this.width,
    this.positive = true,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final style = color != null
        ? ElevatedButton.styleFrom(
            side: BorderSide(width: 2, color: color!),
            backgroundColor: color,
            elevation: 0,
          )
        : positive
            ? null
            : ElevatedButton.styleFrom(
                side: BorderSide(width: 2, color: Theme.of(context).primaryColor),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
    return SizedBox(
      height: height ?? STheme().buttonHeight,
      width: width,
      child: icon != null
          ? ElevatedButton.icon(
              onPressed: onPressed,
              icon: icon!,
              label: Text(label ?? ''),
              style: style,
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: style,
              child: label != null ? Text(label!) : child,
            ),
    );
  }
}
