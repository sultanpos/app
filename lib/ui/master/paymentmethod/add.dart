import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/paymentmethod.dart';
import 'package:sultanpos/ui/util/textformatter.dart';
import 'package:sultanpos/ui/widget/basewindow.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/dropdown.dart';
import 'package:sultanpos/ui/widget/labelfield.dart';
import 'package:sultanpos/ui/widget/showerror.dart';
import 'package:sultanpos/ui/widget/space.dart';

class AddPaymentMethodWidget extends StatelessWidget {
  final String title;
  const AddPaymentMethodWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PaymentMethodState>();
    return BaseWindowWidget(
      title: title,
      height: 500,
      width: 300,
      icon: Icons.payment,
      child: ReactiveForm(
        formGroup: state.form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LabelField('Metode'),
            const DropdownPaymentMethodType(
              formControlName: 'method',
              autoFocus: true,
            ),
            const SVSpace(),
            const LabelField('Nama'),
            ReactiveTextField(
              formControlName: 'name',
              inputFormatters: [UpperCaseTextFormatter()],
              decoration: const InputDecoration(
                hintText: "Masukkan nama metode",
              ),
              textInputAction: TextInputAction.next,
            ),
            const SVSpace(),
            const LabelField('Deskripsi'),
            ReactiveTextField(
              formControlName: 'description',
              inputFormatters: [UpperCaseTextFormatter()],
              decoration: const InputDecoration(
                hintText: "Masukkan deskripsi",
              ),
              textInputAction: TextInputAction.next,
            ),
            const SVSpace(),
            const LabelField('Biaya tambahan'),
            ReactiveTextField(
              formControlName: 'additional',
              inputFormatters: [StockTextFormatter()],
              decoration: const InputDecoration(
                hintText: "Masukkan biaya tambahan",
              ),
              textInputAction: TextInputAction.next,
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: SButton(
                    positive: false,
                    label: "Batal",
                    onPressed: state.loading
                        ? null
                        : () {
                            Navigator.of(context).pop();
                          },
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: SButton(
                    label: "Simpan",
                    onPressed: state.loading
                        ? null
                        : () async {
                            save(context);
                          },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  save(BuildContext context) async {
    try {
      final nav = Navigator.of(context);
      await AppState().paymentMethodState.save();
      nav.pop();
    } catch (e) {
      showError(context, message: e.toString());
    }
  }
}
