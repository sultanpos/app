import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/ui/setting/app.dart';
import 'package:sultanpos/ui/setting/printer.dart';
import 'package:sultanpos/ui/widget/verticalmenu.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget({super.key});

  @override
  State<SettingWidget> createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  String _currentId = "app";
  @override
  Widget build(BuildContext context) {
    return VerticalMenu(
      currentId: _currentId,
      onChanged: (value) {
        setState(() {
          _currentId = value;
        });
      },
      width: 80,
      menus: [
        VerticalMenuItem<String>(
            title: 'Aplikasi', id: 'app', icon: Icons.app_settings_alt, widget: (ctx) => const AppSettingWidget()),
        VerticalMenuItem<String>(
          title: 'Printer',
          id: 'printer',
          icon: Icons.print,
          widget: (ctx) => ChangeNotifierProvider.value(
            value: AppState().printer,
            child: const PrinterSettingWidget(),
          ),
        ),
      ],
    );
  }
}
