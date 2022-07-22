import 'package:flutter/material.dart';
import 'package:sultanpos/singleton.dart';
import 'package:sultanpos/ui/root.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _step = 0;
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 2),
      () {
        next();
      },
    );

    // make sure the splasscreen painted on screen first
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        initAll();
      },
    );
  }

  initAll() async {
    await Singleton.instance().init();
    next();
  }

  next() {
    _step++;
    if (_step >= 2) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const RootWidget()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Splash Screen")),
    );
  }
}
