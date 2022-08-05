import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/error.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/auth.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/ui/root.dart';
import 'package:sultanpos/ui/widget/showerror.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

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
                  textInputAction: TextInputAction.next,
                ),
                ReactiveTextField(
                  formControlName: 'password',
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Password",
                    labelText: "Password",
                  ),
                  textInputAction: TextInputAction.go,
                  onSubmitted: () => _doLogin(context),
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
                    onPressed: isLoading ? null : () => _doLogin(context),
                    child: Text(
                      isLoading ? "Loading..." : "Login",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _doLogin(BuildContext context) async {
    var auth = AppState().authState!;
    try {
      await auth.login();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const RootWidget(),
        ),
      );
    } on ErrorResponse catch (e) {
      auth.setLoading(false);
      showError(context, title: 'Login gagal', message: e.message);
      // ignore: empty_catches
    } catch (e) {}
  }
}
