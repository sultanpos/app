import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/error.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/auth.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/ui/root.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<AuthState, bool>((value) => value.isLoading);
    return Center(
        child: ReactiveForm(
      formGroup: AppState().authState!.loginForm,
      child: SizedBox(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              const SizedBox(height: 200, width: 200, child: Image(image: AssetImage("resources/images/icon_1024.png"))),
              ReactiveTextField(
                formControlName: 'username',
                decoration: const InputDecoration(
                  hintText: "Username / email",
                  labelText: "Username / email",
                ),
              ),
              ReactiveTextField(
                formControlName: 'password',
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Password",
                  labelText: "Password",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  ReactiveCheckbox(
                    formControlName: 'remember',
                  ),
                  const Text('Remember me')
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 35,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          var auth = AppState().authState!;
                          try {
                            await auth.login();
                            if (!mounted) return;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RootWidget(),
                              ),
                            );
                          } on ErrorResponse catch (e) {
                            auth.setLoading(false);
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
                    isLoading ? "Loading..." : "Login",
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
