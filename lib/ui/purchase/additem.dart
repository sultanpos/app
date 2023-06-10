import 'package:flutter/material.dart';
import 'package:sultanpos/ui/widget/basewindow.dart';

class PurchaseItemAddWidget extends StatefulWidget {
  final String title;
  const PurchaseItemAddWidget(this.title, {super.key});

  @override
  State<PurchaseItemAddWidget> createState() => _PurchaseItemAddWidgetState();
}

class _PurchaseItemAddWidgetState extends State<PurchaseItemAddWidget> {
  @override
  Widget build(BuildContext context) {
    //final state = context.watch<PurchaseItemState>();
    return BaseWindowWidget(
      title: widget.title,
      height: 400,
      width: 300,
      icon: Icons.scale,
      child: const Text('HOLA'),
    );
  }
}
