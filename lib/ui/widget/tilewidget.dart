import 'package:flutter/material.dart';
import 'package:sultanpos/ui/widget/space.dart';

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

class TileIconWidget extends StatelessWidget {
  final Widget? lead;
  final Widget? body;
  final Widget? tail;
  final VoidCallback? onTap;
  final Color? color;
  const TileIconWidget({this.lead, required this.body, this.tail, this.onTap, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onHover: (value) {},
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color ?? const Color(0xff374151),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (lead != null) lead!,
            const SHSpaceSmall(),
            body!,
            const SHSpaceSmall(),
            if (tail != null) tail!,
          ],
        ),
      ),
    );
  }
}
