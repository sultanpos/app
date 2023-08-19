import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

showError(BuildContext ctx, {required String message}) {
  showToastWidget(
    Container(
      width: 300,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.red.withAlpha(200),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Row(children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Icon(
            Icons.warning,
            color: Colors.white,
          ),
        ),
        Expanded(child: Text(message)),
      ]),
    ),
    position: ToastPosition.top,
    dismissOtherToast: true,
  );
}

showSuccess(BuildContext ctx, {required String message}) {
  showToastWidget(
    Container(
      width: 300,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.green.withAlpha(200),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Row(children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
        Expanded(child: Text(message)),
      ]),
    ),
    position: ToastPosition.top,
    dismissOtherToast: true,
  );
}
