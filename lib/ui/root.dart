import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/ui/layout/mainlayout.dart';

class RootWidget extends StatelessWidget {
  const RootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Focus(
          canRequestFocus: false,
          onKey: (node, event) {
            if (event is RawKeyDownEvent && !event.repeat) {
              if (event.isControlPressed && event.isKeyPressed(LogicalKeyboardKey.keyD)) {
                AppState().navigateTo('/cashier');
              }
            }
            return KeyEventResult.ignored;
          },
          child: const MainLayoutWidget()),
    );
  }
}
