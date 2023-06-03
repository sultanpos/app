import 'package:flutter/material.dart';
import 'package:sultanpos/ui/theme.dart';

class SVSpace extends StatelessWidget {
  const SVSpace({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: STheme().widgetSpace,
    );
  }
}

class SHSpace extends StatelessWidget {
  const SHSpace({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: STheme().widgetSpace,
    );
  }
}

class SVSpaceDouble extends StatelessWidget {
  const SVSpaceDouble({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: STheme().widgetSpace * 2,
    );
  }
}

class SHSpaceDouble extends StatelessWidget {
  const SHSpaceDouble({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: STheme().widgetSpace * 2,
    );
  }
}

class SVSpaceSmall extends StatelessWidget {
  const SVSpaceSmall({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: STheme().widgetSpace / 2,
    );
  }
}

class SHSpaceSmall extends StatelessWidget {
  const SHSpaceSmall({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: STheme().widgetSpace / 2,
    );
  }
}
