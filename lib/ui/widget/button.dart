import 'package:flutter/material.dart';

class SButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? height;
  final double? width;
  final bool positive;
  const SButton({super.key, this.onPressed, required this.label, this.height, this.width, this.positive = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 40,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: positive
            ? null
            : ElevatedButton.styleFrom(
                side: BorderSide(width: 2, color: Theme.of(context).primaryColor),
                backgroundColor: Colors.transparent,
              ),
        child: Text(label),
      ),
    );
  }
}
