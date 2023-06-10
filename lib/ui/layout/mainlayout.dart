import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:sultanpos/ui/layout/navigator.dart';
import 'package:sultanpos/ui/layout/drawer.dart';
import 'package:sultanpos/ui/layout/profile.dart';
import 'package:sultanpos/ui/widget/windowbutton.dart';

class MainLayoutWidget extends StatelessWidget {
  const MainLayoutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //bool isDark = Theme.of(context).brightness == Brightness.dark;
    return WindowBorder(
      color: Colors.grey,
      width: 1,
      child: Column(children: [
        Container(
          height: 50,
          color: Colors
              .black, // lighterOrDarkerColor(Theme.of(context), Theme.of(context).scaffoldBackgroundColor, amount: 0.1),
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
                  padding: const EdgeInsets.only(top: 2.0),
                  child: DrawerWidget(),
                ),
                Expanded(child: MoveWindow()),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration:
                        const BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(8))),
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                    child: const Text(
                      'OFFLINE',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                const ProfileMenuWidget(),
                const SizedBox(
                  width: 8,
                ),
                const WindowButtons(),
                /*Padding(
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
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),*/
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
