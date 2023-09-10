import 'package:flutter/material.dart';

class SChip extends StatelessWidget {
  final Color color;
  final String label;
  final double? fontSize;
  const SChip({super.key, required this.color, required this.label, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, borderRadius: const BorderRadius.all(Radius.circular(8))),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: Text(
        label,
        style: TextStyle(fontSize: fontSize ?? 12),
      ),
    );
  }
}
