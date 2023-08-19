import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/auth.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/labelfield.dart';
import 'package:sultanpos/ui/widget/showerror.dart';
import 'package:sultanpos/ui/widget/space.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    bool isRegistering = context.select<AuthState, bool>(
      (value) => value.isRegistering,
    );
    return Column(
      children: [
        const Spacer(),
        Container(
          width: 400,
          decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: ReactiveForm(
            formGroup: AppState().authState.registerForm,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Register new user",
                        style: TextStyle(fontSize: 32),
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    const LabelField('Nama perusahaan / usaha'),
                    ReactiveTextField(
                      autofocus: true,
                      formControlName: 'name',
                      decoration: const InputDecoration(
                        hintText: "Nama perusahaan / usaha",
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    const SVSpace(),
                    const LabelField('Email'),
                    ReactiveTextField(
                      formControlName: 'email',
                      decoration: const InputDecoration(
                        hintText: "Masukkan email",
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    const SVSpace(),
                    const LabelField('Password'),
                    ReactiveTextField(
                      formControlName: 'password',
                      obscureText: !passwordVisible,
                      decoration: InputDecoration(
                        hintText: "Masukkan password",
                        suffixIcon: IconButton(
                          icon: Icon(!passwordVisible ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                      ),
                      textInputAction: TextInputAction.send,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SButton(
                            label: 'Batal',
                            positive: false,
                            onPressed: isRegistering
                                ? null
                                : () {
                                    Navigator.of(context, rootNavigator: false).pop();
                                  },
                          ),
                        ),
                        const SHSpace(),
                        Expanded(
                          child: SButton(
                            label: isRegistering ? 'Loading...' : 'Daftar',
                            onPressed: isRegistering
                                ? null
                                : () async {
                                    return doRegister(context);
                                  },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }

  doRegister(BuildContext context) async {
    try {
      await AppState().authState.processRegister();
      // ignore: use_build_context_synchronously
      Navigator.of(context, rootNavigator: false).pop();
      // ignore: use_build_context_synchronously
      showSuccess(context, message: "Berhasil daftar user baru. Silakan login!");
    } catch (e) {
      showError(context, message: e.toString());
    }
  }
}
