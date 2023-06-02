import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SReactiveCustomDropdown<T> extends ReactiveFocusableFormField<T, T> {
  SReactiveCustomDropdown({
    Key? key,
    String? formControlName,
    FormControl<T>? formControl,
    FocusNode? focusNode,
    required List<DropdownMenuItem<T>> items,
    Map<String, ValidationMessageFunction>? validationMessages,
    ShowErrorsFunction<T>? showErrors,
    DropdownButtonBuilder? selectedItemBuilder,
    Widget? hint,
    InputDecoration decoration = const InputDecoration(),
    Widget? disabledHint,
    int elevation = 8,
    TextStyle? style,
    Widget? icon,
    Color? iconDisabledColor,
    Color? iconEnabledColor,
    double iconSize = 24.0,
    bool isDense = true,
    bool isExpanded = false,
    bool readOnly = false,
    double? itemHeight,
    Color? dropdownColor,
    Color? focusColor,
    bool autofocus = false,
    double? menuMaxHeight,
    bool? enableFeedback,
    AlignmentGeometry alignment = AlignmentDirectional.centerStart,
    BorderRadius? borderRadius,
    ReactiveFormFieldCallback<T>? onTap,
    ReactiveFormFieldCallback<T>? onChanged,
  })  : assert(itemHeight == null || itemHeight > 0),
        super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          validationMessages: validationMessages,
          showErrors: showErrors,
          focusNode: focusNode,
          builder: (ReactiveFormFieldState<T, T> field) {
            final effectiveDecoration = decoration.applyDefaults(
              Theme.of(field.context).inputDecorationTheme,
            );

            var effectiveValue = field.value;
            if (effectiveValue != null && !items.any((item) => item.value == effectiveValue)) {
              effectiveValue = null;
            }

            final isDisabled = readOnly || field.control.disabled;
            var effectiveDisabledHint = disabledHint;
            if (isDisabled && disabledHint == null) {
              final selectedItemIndex = items.indexWhere((item) => item.value == effectiveValue);
              if (selectedItemIndex > -1) {
                effectiveDisabledHint = selectedItemBuilder != null
                    ? selectedItemBuilder(field.context).elementAt(selectedItemIndex)
                    : items.elementAt(selectedItemIndex).child;
              }
            }

            return DropdownButtonFormField2<T>(
              value: effectiveValue,
              decoration: effectiveDecoration.copyWith(
                errorText: field.errorText,
                enabled: !isDisabled,
              ),
              items: items,
              selectedItemBuilder: selectedItemBuilder,
              hint: hint,
              disabledHint: effectiveDisabledHint,
              //elevation: elevation,
              style: style,
              /*icon: icon,
              iconDisabledColor: iconDisabledColor,
              iconEnabledColor: iconEnabledColor,
              iconSize: iconSize,*/
              isDense: isDense,
              isExpanded: isExpanded,
              //itemHeight: itemHeight,
              focusNode: field.focusNode,
              /*dropdownColor: dropdownColor,
              focusColor: focusColor,*/
              autofocus: autofocus,
              //menuMaxHeight: menuMaxHeight,
              enableFeedback: enableFeedback,
              alignment: alignment,
              /*borderRadius: borderRadius,
              onTap: onTap != null ? () => onTap(field.control) : null,*/
              onChanged: isDisabled
                  ? null
                  : (value) {
                      field.didChange(value);
                      onChanged?.call(field.control);
                    },
            );
          },
        );
}
