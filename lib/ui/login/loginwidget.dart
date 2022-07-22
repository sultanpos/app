import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:sultanpos/model/auth.dart';
import 'package:sultanpos/model/error.dart';
import 'package:sultanpos/singleton.dart';
import 'package:sultanpos/ui/home.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  String _username = "";
  String _password = "";
  bool _isProcess = false;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Form(
      key: _formKey,
      child: Container(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              const SizedBox(height: 200, width: 200, child: Image(image: AssetImage("resources/images/icon_1024.png"))),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Username / email",
                  labelText: "Username / email",
                ),
                validator: (value) {
                  if (value == null || value == "") return "Username is mandatory";
                  return null;
                },
                onSaved: (value) => _username = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Password",
                  labelText: "Password",
                ),
                validator: (value) {
                  if (value == null || value == "") return "Password is mandatory";
                  return null;
                },
                onSaved: (value) => _password = value!,
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 35,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isProcess
                      ? null
                      : () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          _formKey.currentState!.save();
                          _isProcess = true;
                          setState(() {});
                          final data = LoginUsernamePasswordRequest(_username, _password);
                          try {
                            final result = await Singleton.instance().httpApi!.post<LoginResponse>(data, skipAuth: true);
                            Singleton.instance().httpApi!.setLogin(result);
                            _isProcess = false;
                            setState(() {});
                            if (!mounted) return;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeWidget(),
                              ),
                            );
                          } on ErrorResponse catch (e) {
                            _isProcess = false;
                            setState(() {});
                            if (!mounted) return;
                            MotionToast.error(
                              title: const Text('Login failed'),
                              description: Text(e.message),
                              position: MotionToastPosition.top,
                              animationType: AnimationType.fromTop,
                              animationCurve: Curves.ease,
                              animationDuration: const Duration(milliseconds: 200),
                            ).show(context);
                          }
                        },
                  child: Text(
                    _isProcess ? "Loading..." : "Login",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
