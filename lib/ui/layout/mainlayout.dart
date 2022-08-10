import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:sultanpos/ui/layout/navigator.dart';
import 'package:sultanpos/ui/layout/drawer.dart';
import 'package:sultanpos/ui/util/color.dart';

final buttonColors = WindowButtonColors(
    iconNormal: const Color(0xFF805306),
    mouseOver: const Color(0xFFF6A00C),
    mouseDown: const Color(0xFF805306),
    iconMouseOver: const Color(0xFF805306),
    iconMouseDown: const Color(0xFFFFD500));

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F), mouseDown: const Color(0xFFB71C1C), iconNormal: const Color(0xFF805306), iconMouseOver: Colors.white);

class WindowButtons extends StatefulWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  _WindowButtonsState createState() => _WindowButtonsState();
}

class _WindowButtonsState extends State<WindowButtons> {
  void maximizeOrRestore() {
    setState(() {
      appWindow.maximizeOrRestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        appWindow.isMaximized
            ? RestoreWindowButton(
                colors: buttonColors,
                onPressed: maximizeOrRestore,
              )
            : MaximizeWindowButton(
                colors: buttonColors,
                onPressed: maximizeOrRestore,
              ),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}

class MainLayoutWidget extends StatelessWidget {
  const MainLayoutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return WindowBorder(
      color: Colors.grey,
      width: 1,
      child: Column(children: [
        Container(
          height: 64,
          color: Colors.black, // lighterOrDarkerColor(Theme.of(context), Theme.of(context).scaffoldBackgroundColor, amount: 0.1),
          child: SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 2.0),
                  child: DrawerWidget(),
                ),
                Expanded(child: MoveWindow()),
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: WindowButtons(),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.red,
          height: 2,
        ),
        const Expanded(child: NavigatorWidget()),
      ]),
    );
  }
}
