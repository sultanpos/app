import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/purchase.dart';
import 'package:sultanpos/ui/theme.dart';
import 'package:sultanpos/ui/widget/basewindow.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/dropdown.dart';
import 'package:sultanpos/ui/widget/form/datepicker.dart';
import 'package:sultanpos/ui/widget/labelfield.dart';
import 'package:sultanpos/ui/widget/showerror.dart';

class PurchaseAddWidget extends StatefulWidget {
  final String title;
  const PurchaseAddWidget({super.key, required this.title});

  @override
  State<PurchaseAddWidget> createState() => _PurchaseAddWidgetState();
}

class _PurchaseAddWidgetState extends State<PurchaseAddWidget> {
  late FocusNode _focusNode;
  late FocusNode _focusNode2;

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode2 = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWindowWidget(
      title: widget.title,
      height: 500,
      width: 400,
      icon: Icons.shopping_cart,
      child: ChangeNotifierProvider.value(
        value: AppState().purchaseState,
        child: Builder(
          builder: (ctx) {
            final loading = ctx.select<PurchaseState, bool>((value) => value.loading);
            return ReactiveForm(
              formGroup: AppState().purchaseState.form,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const LabelField('Tanggal pembelian'),
                          SReactiveDatePicker(
                            autoFocus: true,
                            formControlName: 'date',
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            hint: "Pilih tanggal pembelian",
                            //builder: reactiveDatePickerBuilder("date", "Pilih tanggal", autoFocus: true),
                          ),
                          SizedBox(
                            height: STheme().widgetSpace,
                          ),
                          const LabelField('Nomor referensi'),
                          ReactiveTextField(
                            formControlName: 'ref_number',
                            decoration: const InputDecoration(
                              hintText: "Masukan nomor referensi",
                            ),
                            //onSubmitted: (c) => save(ctx),
                          ),
                          SizedBox(
                            height: STheme().widgetSpace,
                          ),
                          const LabelField('Supplier'),
                          DropdownRepoPartnerSupplier(
                            formControlName: 'partner_id',
                            decoration: const InputDecoration(hintText: "Pilih supplier"),
                          ),
                          SizedBox(
                            height: STheme().widgetSpace,
                          ),
                          const LabelField('Tenggat waktu pembayaran'),
                          SReactiveDatePicker(
                            formControlName: 'deadline',
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            hint: "Pilih tanggal tenggat",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: STheme().widgetSpace,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SButton(
                          positive: false,
                          label: "Batal",
                          onPressed: loading
                              ? null
                              : () {
                                  Navigator.of(ctx).pop();
                                },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: SButton(
                          label: "Simpan",
                          onPressed: loading
                              ? null
                              : () async {
                                  save(ctx);
                                },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  save(BuildContext context) async {
    try {
      final nav = Navigator.of(context);
      await AppState().purchaseState.save();
      nav.pop();
      // ignore: use_build_context_synchronously
      showSuccess(context, title: 'Berhasil', message: 'Pembelian telah disimpan');
    } catch (e) {
      showError(context, title: 'Error menyimpan', message: e.toString());
    }
  }
}
