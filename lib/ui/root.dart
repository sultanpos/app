import 'package:flutter/material.dart';
import 'package:sultanpos/ui/layout/mainlayout.dart';

class RootWidget extends StatelessWidget {
  const RootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          MainLayoutWidget(),
        ],
      ),
    );
  }
}
