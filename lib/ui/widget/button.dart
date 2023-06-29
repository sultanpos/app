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
  const SButton({
    super.key,
    this.onPressed,
    this.child,
    this.label,
    this.height,
    this.width,
    this.positive = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? STheme().buttonHeight,
      width: width,
      child: icon != null
          ? ElevatedButton.icon(onPressed: onPressed, icon: icon!, label: Text(label ?? ''))
          : ElevatedButton(
              onPressed: onPressed,
              style: positive
                  ? null
                  : ElevatedButton.styleFrom(
                      side: BorderSide(width: 2, color: Theme.of(context).primaryColor),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
              child: label != null ? Text(label!) : child,
            ),
    );
  }
}
