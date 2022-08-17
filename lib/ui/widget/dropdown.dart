import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/listresult.dart';
import 'package:sultanpos/state/app.dart';

class DropdownRepo<T extends BaseModel, R> extends StatefulWidget {
  final String formControlName;
  final bool? autoFocus;
  final String path;
  final T Function(Map<String, dynamic> json) creator;
  final String Function(T value) textFn;
  final R Function(T value) valueFn;
  final InputDecoration decoration;
  const DropdownRepo({
    required this.formControlName,
    required this.path,
    this.autoFocus,
    required this.creator,
    required this.valueFn,
    required this.textFn,
    this.decoration = const InputDecoration(),
    Key? key,
  }) : super(key: key);

  @override
  State<DropdownRepo<T, R>> createState() => _DropdownRepoState<T, R>();
}

class _DropdownRepoState<T extends BaseModel, R> extends State<DropdownRepo<T, R>> {
  ListResult<T>? list;

  @override
  void initState() {
    super.initState();
    AppState().httpAPI.query<T>(widget.path, fromJsonFunc: widget.creator, limit: 1000, offset: 0).then((value) {
      list = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveDropdownField(
      autofocus: widget.autoFocus ?? false,
      formControlName: widget.formControlName,
      decoration: widget.decoration,
      items: list == null
          ? []
          : list!.data
              .map(
                (e) => DropdownMenuItem(
                  value: widget.valueFn(e),
                  child: Text(widget.textFn(e)),
                ),
              )
              .toList(),
    );
  }
}
