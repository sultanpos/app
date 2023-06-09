import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  final String title;
  final String value;
  const TileWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Color(0xff374151),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(
            width: 8,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
