import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool _isProcess = false;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 300,
      height: 500,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            const SizedBox(height: 200, width: 200, child: Image(image: AssetImage("resources/images/icon_1024.png"))),
            TextFormField(decoration: const InputDecoration(hintText: "Username / email", labelText: "Username / email")),
            TextFormField(decoration: const InputDecoration(hintText: "Password", labelText: "Password")),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
                height: 35,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      _isProcess = !_isProcess;
                      setState(() {});
                    },
                    child: Text(_isProcess ? "Loading..." : "Login"))),
          ],
        ),
      ),
    ));
  }
}
