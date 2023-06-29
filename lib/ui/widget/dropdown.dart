import 'package:flutter/material.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/category.dart';
import 'package:sultanpos/model/listresult.dart';
import 'package:sultanpos/model/partner.dart';
import 'package:sultanpos/model/paymentmethod.dart';
import 'package:sultanpos/model/unit.dart';
import 'package:sultanpos/state/app.dart';

import 'form/reactivecustomdropdown.dart';

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
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SReactiveCustomDropdown(
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

class DropdownRepoCategory extends DropdownRepo<CategoryModel, int> {
  DropdownRepoCategory({super.key, required super.formControlName, super.decoration})
      : super(
          path: '/category',
          creator: CategoryModel.fromJson,
          valueFn: (data) => data.id,
          textFn: (data) => data.name,
        );
}

class DropdownRepoUnit extends DropdownRepo<UnitModel, int> {
  DropdownRepoUnit({super.key, required super.formControlName, super.decoration})
      : super(
          path: '/unit',
          creator: UnitModel.fromJson,
          valueFn: (data) => data.id,
          textFn: (data) => data.name,
        );
}

class DropdownRepoPartnerCustomer extends DropdownRepo<PartnerModel, int> {
  DropdownRepoPartnerCustomer({super.key, required super.formControlName, super.decoration})
      : super(
          path: '/partner?is_customer=true',
          creator: PartnerModel.fromJson,
          valueFn: (data) => data.id,
          textFn: (data) => data.name,
        );
}

class DropdownRepoPartnerSupplier extends DropdownRepo<PartnerModel, int> {
  DropdownRepoPartnerSupplier({super.key, required super.formControlName, super.decoration})
      : super(
          path: '/partner?is_supplier=true',
          creator: PartnerModel.fromJson,
          valueFn: (data) => data.id,
          textFn: (data) => data.name,
        );
}

class DropdownProductType extends StatelessWidget {
  final bool? autoFocus;
  final String formControlName;
  final InputDecoration? inputDecoration;
  const DropdownProductType({required this.formControlName, this.autoFocus, this.inputDecoration, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SReactiveCustomDropdown<String>(
      autofocus: autoFocus ?? false,
      formControlName: formControlName,
      decoration: inputDecoration ?? const InputDecoration(),
      items: const [
        DropdownMenuItem(
          value: 'product',
          child: Text('Barang'),
        ),
        DropdownMenuItem(
          value: 'service',
          child: Text('Jasa'),
        )
      ],
    );
  }
}

class DropdownPaymentMethodType extends StatelessWidget {
  final bool? autoFocus;
  final String formControlName;
  final InputDecoration? inputDecoration;
  const DropdownPaymentMethodType({required this.formControlName, this.autoFocus, this.inputDecoration, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SReactiveCustomDropdown<PaymentMethodType>(
      autofocus: autoFocus ?? false,
      formControlName: formControlName,
      decoration: inputDecoration ?? const InputDecoration(),
      items: const [
        DropdownMenuItem(
          value: PaymentMethodType.cash,
          child: Text('Cash'),
        ),
        DropdownMenuItem(
          value: PaymentMethodType.edc,
          child: Text('EDC'),
        ),
        DropdownMenuItem(
          value: PaymentMethodType.transfer,
          child: Text('Transfer'),
        ),
        DropdownMenuItem(
          value: PaymentMethodType.online,
          child: Text('Online'),
        )
      ],
    );
  }
}
