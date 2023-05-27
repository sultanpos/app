import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:sultanpos/ui/splashscreen.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        fontFamily: 'Oxanium',
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        fontFamily: 'Oxanium',
        inputDecorationTheme: const InputDecorationTheme(
          isDense: true,
          filled: true,
          border: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide(width: 0)),
          contentPadding: EdgeInsets.all(8),
          errorStyle: TextStyle(height: 0.1),
        ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(fontSize: 12, height: 1.5),
          labelLarge: TextStyle(fontSize: 12),
          bodyLarge: TextStyle(fontSize: 12),
          bodyMedium: TextStyle(fontSize: 12),
        ),
      ),
      initial: AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: theme,
        darkTheme: darkTheme,
        title: "Sultan POS 2",
      ),
    );
  }
}
