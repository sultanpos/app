import 'package:flutter/material.dart';

sShowDialog({required BuildContext context, required WidgetBuilder builder}) {
  return showDialog(context: context, useRootNavigator: true, barrierDismissible: false, builder: builder);
}
