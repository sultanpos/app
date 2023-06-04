import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

reactiveDatePickerBuilder(String controlName, String hint, FocusNode focusNode) {
  return (BuildContext context, ReactiveDatePickerDelegate<Object?> picker, Widget? child) {
    Widget suffix = InkWell(
      onTap: () {
        focusNode.unfocus();
        focusNode.canRequestFocus = false;
        picker.control.value = null;
        Future.delayed(const Duration(milliseconds: 100), () {
          focusNode.canRequestFocus = true;
        });
      },
      child: const Icon(Icons.clear),
    );

    if (picker.value == null) {
      suffix = const Icon(Icons.calendar_today);
    }

    return ReactiveTextField(
      onTap: (_) {
        if (focusNode.canRequestFocus) {
          focusNode.unfocus();
          picker.showPicker();
        }
      },
      valueAccessor: DateTimeValueAccessor(
        dateTimeFormat: DateFormat('dd MMM yyyy'),
      ),
      focusNode: focusNode,
      formControlName: controlName,
      readOnly: true,
      decoration: InputDecoration(
        suffixIcon: suffix,
        hintText: hint,
      ),
    );
  };
}
