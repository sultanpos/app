import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

showError(BuildContext ctx, {required String title, required String message}) async {
  return MotionToast.error(
    title: Text(title),
    description: Text(message),
    position: MotionToastPosition.top,
    animationType: AnimationType.fromTop,
    animationCurve: Curves.ease,
    animationDuration: const Duration(milliseconds: 200),
  ).show(ctx);
}
