import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sultanpos/extension/rawkeyevent.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/ui/layout/mainlayout.dart';
import 'package:sultanpos/ui/widget/keyshortcut.dart';

class RootWidget extends StatelessWidget {
  const RootWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardShortcutManager(
        child: Builder(
          builder: (ctx) {
            return KeyboardShortcut(
                keyEvent: (event) {
                  if (event.isPressed(LogicalKeyboardKey.keyD, isCtrl: true)) {
                    AppState().navigateTo('/cashier');
                    return KeyEventResult.handled;
                  }
                  return KeyEventResult.ignored;
                },
                child: const MainLayoutWidget());
          },
        ),
      ),
    );
  }
}
