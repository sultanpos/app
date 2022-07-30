import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sultanpos/flavor.dart';
import 'package:sultanpos/http/authinterceptor.dart';
import 'package:sultanpos/http/fetch.dart';
import 'package:sultanpos/http/httpapi.dart';
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
    await Preference().init();
    final interceptor = AuthInterceptor(Dio(BaseOptions(baseUrl: Flavor.baseUrl!)), "/auth/refresh");
    final httpAPI = HttpAPI.create(Flavor.baseUrl!, interceptor);
    AppState().init(httpAPI);
    try {
      await AppState().authState!.loadLogin();
      _gotoHome = true;
      // ignore: empty_catches
    } catch (e) {}
    next();
  }

  next() {
    _step++;
    if (_step >= 2) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => _gotoHome ? const RootWidget() : const LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Splash Screen")),
    );
  }
}
