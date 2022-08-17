import 'package:flutter/material.dart';

class SChip extends StatelessWidget {
  final Color color;
  final String label;
  const SChip({Key? key, required this.color, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, borderRadius: const BorderRadius.all(Radius.circular(8))),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
