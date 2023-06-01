import 'package:flutter/material.dart';

class LabelField extends StatelessWidget {
  final String title;
  const LabelField(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title),
    );
  }
}
