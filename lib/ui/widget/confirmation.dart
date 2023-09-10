import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sultanpos/extension/rawkeyevent.dart';
import 'package:sultanpos/ui/theme.dart';
import 'package:sultanpos/ui/widget/basewindow.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/keyshortcut.dart';

Future<bool?> showBaseConfirmation(
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
        child: KeyboardShortcut(
          keyEvent: (event) {
            if (event.isPressed(LogicalKeyboardKey.enter)) {
              Navigator.pop(context, true);
              return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          },
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
                      child: SButton(
                        autofocus: true,
                        onPressed: () async {
                          Navigator.pop(context, true);
                        },
                        //style: ElevatedButton.styleFrom(backgroundColor: positiveColor),
                        child: Text(positiveLabel ?? "Lanjutkan"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<bool> showConfirmation(BuildContext ctx, {required String title, required String message}) async {
  final result = await showBaseConfirmation(ctx, title: title, message: message, positiveColor: Colors.red);
  return result ?? false;
}

Future<bool> showAddProductSuccessConfirmation(BuildContext ctx,
    {required String title, required String message}) async {
  final result = await showBaseConfirmation(
    ctx,
    title: title,
    message: message,
    icon: Icons.info,
    negativeLabel: "Selesai",
    positiveLabel: 'Tambah lagi',
  );
  return result ?? false;
}
