import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sultanpos/ui/layout/mainlayout.dart';

class RootWidget extends StatelessWidget {
  const RootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Focus(
              canRequestFocus: false,
              onKey: (node, event) {
                if (event is RawKeyDownEvent) print('${event.data.isControlPressed} :: ${event.data.logicalKey.toString()} :: ${event.repeat}');
                return KeyEventResult.ignored;
              },
              child: const MainLayoutWidget()),
        ],
      ),
    );
  }
}
