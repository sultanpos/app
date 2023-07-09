import 'package:flutter/material.dart';

sShowDialog<T>({required BuildContext context, required WidgetBuilder builder}) {
  return showDialog<T>(context: context, useRootNavigator: true, barrierDismissible: false, builder: builder);
}
