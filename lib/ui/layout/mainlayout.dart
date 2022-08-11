import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:sultanpos/ui/layout/navigator.dart';
import 'package:sultanpos/ui/layout/drawer.dart';
import 'package:sultanpos/ui/layout/profile.dart';

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
          height: 60,
          color: Colors.black, // lighterOrDarkerColor(Theme.of(context), Theme.of(context).scaffoldBackgroundColor, amount: 0.1),
          child: SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 60,
                  child: const Center(child: Image(image: AssetImage("resources/images/icon_1024.png"))),
                ),*/
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: DrawerWidget(),
                ),
                Expanded(child: MoveWindow()),
                const ProfileMenuWidget(),
                const SizedBox(
                  width: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, right: 4),
                  child: Column(
                    children: [
                      const WindowButtons(),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        decoration: const BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(8))),
                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                        child: const Text(
                          'ONLINE',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.blue,
          height: 2,
        ),
        const Expanded(child: NavigatorWidget()),
      ]),
    );
  }
}
