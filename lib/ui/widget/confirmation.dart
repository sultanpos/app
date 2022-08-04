import 'package:flutter/material.dart';

showConfirmation(BuildContext ctx, {required String title, required String message}) {
  return showDialog<bool>(
    context: ctx,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Batal')),
          TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Lanjutkan')),
        ],
      );
    },
  );
}
