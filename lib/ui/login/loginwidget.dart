import 'package:flutter/material.dart';

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
                      : () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          _formKey.currentState!.save();
                          _isProcess = true;
                          setState(() {});
                          //do request
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
