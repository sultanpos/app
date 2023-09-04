import 'package:flutter/material.dart';
import 'package:scaled_app/scaled_app.dart';
import 'package:sultanpos/format.dart';
import 'package:sultanpos/preference.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/ui/login/loginpage.dart';
import 'package:sultanpos/ui/root.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _step = 0;
  bool _gotoHome = false;
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 1),
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
    try {
      Format().setup(locale: "id");
      await AppState().init();
      _gotoHome = true;
      // ignore: empty_catches
    } catch (e) {}
    next();
  }

  next() {
    _step++;
    if (_step >= 2) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (c) => _gotoHome ? const RootWidget() : const LoginPage()));
    }
    final scale = Preference().scale();
    if (scale > 1 || scale < 1) ScaledWidgetsFlutterBinding.instance.scaleFactor = (deviceSize) => scale;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(),
            ),
            Text("Splash Screen"),
            SizedBox(
              height: 16,
            ),
            CircularProgressIndicator(),
            Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
