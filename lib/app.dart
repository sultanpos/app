import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sultanpos/ui/splashscreen.dart';
import 'package:sultanpos/util/color.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: createMaterialColor(const Color(0xff3D928A)),
        primaryColor: const Color(0xff3D928A),
        fontFamily: 'Ubuntu',
      ),
      dark: ThemeData(
        useMaterial3: false,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xff111827),
        secondaryHeaderColor: const Color(0xff1F2937),
        primarySwatch: createMaterialColor(const Color(0xff3D928A)),
        primaryColor: const Color(0xff3D928A),
        fontFamily: 'Ubuntu',
        inputDecorationTheme: const InputDecorationTheme(
          isDense: true,
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide(width: 0)),
          contentPadding: EdgeInsets.all(12),
        ),
      ),
      initial: AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => OKToast(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          theme: theme,
          darkTheme: darkTheme,
          title: "Sultan POS 2",
        ),
      ),
    );
  }
}
