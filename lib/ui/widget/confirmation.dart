import 'package:flutter/material.dart';
import 'package:sultanpos/ui/theme.dart';
import 'package:sultanpos/ui/widget/basewindow.dart';
import 'package:sultanpos/ui/widget/button.dart';

showConfirmation(BuildContext ctx, {required String title, required String message}) {
  return showDialog<bool>(
    context: ctx,
    builder: (context) {
      return BaseWindowWidget(
        title: title,
        icon: Icons.report_problem,
        height: 250,
        width: 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: SButton(
                    positive: false,
                    label: "Batal",
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: SizedBox(
                    height: STheme().buttonHeight,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(context, true);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text("Lanjutkan"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        /*actions: [
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
        ],*/
      );
    },
  );
}
