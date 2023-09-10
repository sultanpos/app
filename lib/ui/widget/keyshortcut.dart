import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef KeyboardKeyEvent = KeyEventResult Function(KeyEvent event);
typedef KeyboardKeyAddRemoveChildren = Function(KeyboardShortcutState);

class KeyboardManager extends InheritedWidget {
  final KeyboardKeyAddRemoveChildren addChildren;
  final KeyboardKeyAddRemoveChildren removeChildren;
  const KeyboardManager({super.key, required super.child, required this.addChildren, required this.removeChildren});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static KeyboardManager? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<KeyboardManager>());
  }
}

class KeyboardShortcutManager extends StatefulWidget {
  final Widget child;
  const KeyboardShortcutManager({super.key, required this.child});

  @override
  State<KeyboardShortcutManager> createState() => _KeyboardShortcutManagerState();
}

class _KeyboardShortcutManagerState extends State<KeyboardShortcutManager> {
  List<KeyboardShortcutState> children = [];

  addChildren(KeyboardShortcutState instance) {
    children.add(instance);
  }

  removeChildren(KeyboardShortcutState instance) {
    children.remove(instance);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardManager(
      addChildren: addChildren,
      removeChildren: removeChildren,
      child: Focus(
        canRequestFocus: false,
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent) {
            for (var i = children.length - 1; i >= 0; i--) {
              if (children[i].onKey(event) == KeyEventResult.handled) {
                return KeyEventResult.handled;
              }
            }
          }
          return KeyEventResult.ignored;
        },
        child: widget.child,
      ),
    );
  }
}

class KeyboardShortcut extends StatefulWidget {
  final Widget child;
  final KeyboardKeyEvent keyEvent;
  final String? debugName;
  const KeyboardShortcut({super.key, required this.child, required this.keyEvent, this.debugName});

  @override
  State<KeyboardShortcut> createState() => KeyboardShortcutState();
}

class KeyboardShortcutState extends State<KeyboardShortcut> {
  late KeyboardManager? keyManager;
  @override
  void initState() {
    Future.microtask(() {
      keyManager = KeyboardManager.of(context);
      keyManager?.addChildren(this);
    });
    super.initState();
  }

  @override
  void dispose() {
    keyManager?.removeChildren(this);
    super.dispose();
  }

  KeyEventResult onKey(KeyEvent event) {
    return widget.keyEvent(event);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: widget.child,
    );
  }
}
