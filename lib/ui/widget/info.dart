import 'package:flutter/material.dart';
import 'package:sultanpos/ui/theme.dart';

class InfoWidget extends StatelessWidget {
  final Widget child;
  final Color? color;
  const InfoWidget({required this.child, super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(STheme().padding / 2),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        color: color ?? Colors.blue,
      ),
      child: child,
    );
  }
}
