import 'package:flutter/material.dart';

class LabelField extends StatelessWidget {
  final String title;
  final bool skipPadding;
  const LabelField(
    this.title, {
    super.key,
    this.skipPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(bottom: skipPadding ? 0 : 8),
      child: Text(
        title,
        style: textTheme.bodyMedium!.copyWith(color: textTheme.headlineLarge!.color),
      ),
    );
  }
}

class LeftRightText extends StatelessWidget {
  final String title;
  final String value;
  const LeftRightText(this.title, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textTheme.bodyMedium!.copyWith(color: textTheme.headlineLarge!.color),
        ),
        Text(
          value,
        ),
      ],
    );
  }
}
