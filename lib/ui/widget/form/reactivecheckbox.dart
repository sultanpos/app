import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SReactiveCheckbox extends ReactiveFocusableFormField<bool, bool> {
  SReactiveCheckbox({
    Key? key,
    required String title,
    String? formControlName,
    FormControl<bool>? formControl,
    FocusNode? focusNode,
    ReactiveFormFieldCallback<bool>? onChanged,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          focusNode: focusNode,
          builder: (field) {
            return Container(
              decoration: const BoxDecoration(
                color: Color(0xff374151),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: InkWell(
                onTap: () {
                  field.didChange(!(field.value ?? false));
                  onChanged?.call(field.control);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Checkbox(
                        value: field.value ?? false,
                        onChanged: field.control.enabled
                            ? (value) {
                                field.didChange(value);
                                onChanged?.call(field.control);
                              }
                            : null,
                      ),
                      Text(title),
                    ],
                  ),
                ),
              ),
            );
          },
        );
}
