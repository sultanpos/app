import 'package:flutter/material.dart';

class NoRouteWidget extends StatelessWidget {
  const NoRouteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No route found'),
    );
  }
}
