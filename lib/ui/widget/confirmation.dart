import 'package:flutter/material.dart';
import 'package:sultanpos/ui/theme.dart';
import 'package:sultanpos/ui/widget/basewindow.dart';
import 'package:sultanpos/ui/widget/button.dart';

showBaseConfirmation(
  BuildContext ctx, {
  required String title,
  required String message,
  IconData? icon,
  String? negativeLabel,
  String? positiveLabel,
  Color? positiveColor,
}) {
  return showDialog<bool>(
    context: ctx,
    builder: (context) {
      return BaseWindowWidget(
        title: title,
        icon: icon ?? Icons.report_problem,
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
                    label: negativeLabel ?? "Batal",
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
                      style: ElevatedButton.styleFrom(backgroundColor: positiveColor),
                      child: Text(positiveLabel ?? "Lanjutkan"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

showConfirmation(BuildContext ctx, {required String title, required String message}) {
  return showBaseConfirmation(ctx, title: title, message: message, positiveColor: Colors.red);
}

showAddProductSuccessConfirmation(BuildContext ctx, {required String title, required String message}) {
  return showBaseConfirmation(
    ctx,
    title: title,
    message: message,
    icon: Icons.info,
    negativeLabel: "Selesai",
    positiveLabel: 'Tambah lagi',
  );
}
