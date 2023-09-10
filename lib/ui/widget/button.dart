import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sultanpos/extension/rawkeyevent.dart';
import 'package:sultanpos/ui/theme.dart';
import 'package:sultanpos/ui/widget/keyshortcut.dart';
import 'package:sultanpos/util/keyname.dart';

class SButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? label;
  final double? height;
  final double? width;
  final bool positive;
  final Widget? child;
  final Icon? icon;
  final Color? color;
  final bool? autofocus;
  final List<LogicalKeyboardKey>? shortCut;
  const SButton({
    super.key,
    this.onPressed,
    this.child,
    this.label,
    this.height,
    this.width,
    this.positive = true,
    this.icon,
    this.color,
    this.autofocus,
    this.shortCut,
  });

  @override
  Widget build(BuildContext context) {
    return shortCut != null
        ? KeyboardShortcut(
            keyEvent: (event) {
              if (shortCut == null) {
                return KeyEventResult.ignored;
              }
              for (final logicalKey in shortCut!) {
                if (event.isPressed(logicalKey)) {
                  if (onPressed != null) onPressed!();
                  return KeyEventResult.handled;
                }
              }
              return KeyEventResult.ignored;
            },
            child: _SButton(
              autofocus: autofocus,
              onPressed: onPressed,
              label: label,
              height: height,
              width: width,
              positive: positive,
              icon: icon,
              color: color,
              shortCutLabel: KeyName.getFirstName(shortCut),
              child: child,
            ),
          )
        : _SButton(
            autofocus: autofocus,
            onPressed: onPressed,
            label: label,
            height: height,
            width: width,
            positive: positive,
            icon: icon,
            color: color,
            child: child,
          );
  }
}

class _SButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? label;
  final double? height;
  final double? width;
  final bool positive;
  final Widget? child;
  final Icon? icon;
  final Color? color;
  final bool? autofocus;
  final String? shortCutLabel;

  const _SButton({
    this.onPressed,
    this.child,
    this.label,
    this.height,
    this.width,
    this.positive = true,
    this.icon,
    this.color,
    this.autofocus,
    this.shortCutLabel,
  });

  @override
  Widget build(BuildContext context) {
    final style = color != null
        ? ElevatedButton.styleFrom(
            side: BorderSide(width: 2, color: color!),
            backgroundColor: color,
            elevation: 0,
          )
        : positive
            ? null
            : ElevatedButton.styleFrom(
                side: BorderSide(width: 2, color: Theme.of(context).primaryColor),
                backgroundColor: Colors.transparent,
                elevation: 0,
              );
    return SizedBox(
      height: height ?? STheme().buttonHeight,
      width: width,
      child: icon != null
          ? ElevatedButton.icon(
              onPressed: onPressed,
              autofocus: autofocus,
              icon: icon!,
              label: shortCutLabel != null
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(shortCutLabel!),
                        const VerticalDivider(),
                        Text(label ?? ''),
                      ],
                    )
                  : Text(label ?? ''),
              style: style,
            )
          : ElevatedButton(
              onPressed: onPressed,
              autofocus: autofocus ?? false,
              style: style,
              child: label != null
                  ? shortCutLabel != null
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(shortCutLabel!),
                            const VerticalDivider(),
                            Text(label!),
                          ],
                        )
                      : Text(label!)
                  : shortCutLabel != null
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(shortCutLabel!),
                            const VerticalDivider(),
                            child ?? const SizedBox.shrink(),
                          ],
                        )
                      : child ?? const SizedBox.shrink(),
            ),
    );
  }
}
