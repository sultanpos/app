import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/error.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/auth.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/ui/root.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/form/reactivecheckbox.dart';
import 'package:sultanpos/ui/widget/labelfield.dart';
import 'package:sultanpos/ui/widget/showerror.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<AuthState, bool>((value) => value.isLoading);
    return Center(
      child: ReactiveForm(
        formGroup: AppState().authState.loginForm,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Sultan POS 2",
                    style: TextStyle(fontSize: 32),
                  ),
                ),
                /*const Center(
                    child: SizedBox(
                        height: 80, width: 200, child: Image(image: AssetImage("resources/images/icon_1024.png")))),*/
                const SizedBox(
                  height: 48,
                ),
                Text("Masuk ke Akun", style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(
                  height: 32,
                ),
                const LabelField('Username'),
                ReactiveTextField(
                  formControlName: 'username',
                  decoration: const InputDecoration(
                    hintText: "Username / email",
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 16,
                ),
                const LabelField('Password'),
                ReactiveTextField(
                  formControlName: 'password',
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                    hintText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(!passwordVisible ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                  textInputAction: TextInputAction.go,
                  onSubmitted: (c) => _doLogin(context),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    SReactiveCheckbox(
                      title: 'Remember me',
                      formControlName: 'remember',
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                SButton(
                  width: double.infinity,
                  onPressed: isLoading ? null : () => _doLogin(context),
                  label: isLoading ? "Loading..." : "Masuk",
                ),
                const SizedBox(
                  height: 32,
                ),
                const LabelField('Belum punya akun?'),
                SButton(
                  label: 'Daftar',
                  width: double.infinity,
                  positive: false,
                  onPressed: () async {
                    // TODO: please check this test
                    final result = await Process.start("K:\\free_windows\\sultanpos.exe", ["server"],
                        environment: {"SERVER_PORT": "6789"},
                        workingDirectory: "K:\\free_windows\\",
                        runInShell: false,
                        mode: ProcessStartMode.detachedWithStdio);
                    print(result.pid);
                    result.stdout.transform(utf8.decoder).listen(
                      (event) {
                        print(event);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _doLogin(BuildContext context) async {
    var auth = AppState().authState;
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
