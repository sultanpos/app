import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SReactiveDatePicker extends StatelessWidget {
  final String formControlName;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool autoFocus;
  final String? hint;
  const SReactiveDatePicker({
    super.key,
    required this.formControlName,
    this.firstDate,
    this.lastDate,
    this.autoFocus = false,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveDatePicker(
        formControlName: formControlName,
        firstDate: firstDate ?? DateTime(2000),
        lastDate: lastDate ?? DateTime(2100),
        builder: (BuildContext context, ReactiveDatePickerDelegate<Object?> picker, Widget? child) {
          Widget suffix = InkWell(
            onTap: () {
              picker.control.value = null;
            },
            child: const Icon(Icons.clear),
          );

          if (picker.value == null) {
            suffix = const Icon(Icons.calendar_today);
          }

          return CallbackShortcuts(
            bindings: <ShortcutActivator, VoidCallback>{
              const SingleActivator(LogicalKeyboardKey.space): () {
                picker.showPicker();
              },
              const SingleActivator(LogicalKeyboardKey.enter): () {
                picker.showPicker();
              },
            },
            child: ReactiveTextField(
              autofocus: autoFocus,
              onTap: (_) {
                picker.showPicker();
              },
              valueAccessor: DateTimeValueAccessor(
                dateTimeFormat: DateFormat('dd MMM yyyy'),
              ),
              formControlName: formControlName,
              readOnly: true,
              decoration: InputDecoration(
                suffixIcon: suffix,
                hintText: hint ?? "Pilih tanggal",
              ),
            ),
          );
        });
  }
}
