import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/state/purchaseitem.dart';
import 'package:sultanpos/ui/util/textformatter.dart';
import 'package:sultanpos/ui/widget/basewindow.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/labelfield.dart';
import 'package:sultanpos/ui/widget/showerror.dart';
import 'package:sultanpos/ui/widget/space.dart';
import 'package:sultanpos/util/format.dart';

class PurchaseItemAddWidget extends StatelessWidget {
  final String title;
  const PurchaseItemAddWidget({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PurchaseItemState>();
    return BaseWindowWidget(
      title: title,
      height: 520,
      width: 480,
      icon: Icons.scale,
      child: ReactiveForm(
        formGroup: state.form,
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LabelField('Scan barcode'),
                  ReactiveTextField(
                    autofocus: true,
                    formControlName: 'barcode',
                    decoration: const InputDecoration(hintText: "Masukkan barcode barang"),
                    textInputAction: TextInputAction.next,
                  ),
                  if (state.error != null) ...[
                    const SVSpaceSmall(),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        color: Colors.red,
                      ),
                      child: Text(state.error!),
                    )
                  ],
                  if (state.product != null) ...[
                    const SVSpaceSmall(),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        color: Colors.blue,
                      ),
                      child: Text(state.product!.name),
                    )
                  ],
                  const SVSpace(),
                  const LabelField('Jumlah'),
                  ReactiveTextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [MoneyTextFormatter()],
                    formControlName: 'count',
                    decoration: const InputDecoration(hintText: "Masukkan jumlah pembelian"),
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.right,
                  ),
                  const SVSpace(),
                  const LabelField('Harga satuan'),
                  ReactiveTextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [MoneyTextFormatter()],
                    formControlName: 'price',
                    decoration: const InputDecoration(hintText: "Masukkan harga satuan"),
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.right,
                  ),
                  const SVSpace(),
                  const LabelField('Diskon formula'),
                  ReactiveTextField(
                    formControlName: 'discountFormula',
                    decoration: const InputDecoration(hintText: "Contoh: 10%+5%+1000"),
                    textInputAction: TextInputAction.send,
                  ),
                  const SVSpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          color: Colors.deepOrange,
                        ),
                        child: Text('Diskon: ${formatMoney(state.discount)}'),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          color: Colors.green,
                        ),
                        child: Text('Total: ${formatMoney(state.total)}'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: SButton(
                    positive: false,
                    label: "Batal",
                    onPressed: state.saving
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
                    label: "Simpan & Lagi",
                    onPressed: state.saving
                        ? null
                        : () async {
                            save(context, state, true);
                          },
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: SButton(
                    label: "Simpan & Tutup",
                    onPressed: state.saving
                        ? null
                        : () async {
                            save(context, state, false);
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

  save(BuildContext context, PurchaseItemState state, bool again) async {
    try {
      await state.save();
      state.refreshPurchase();
      if (!again) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      } else {
        state.resetForm();
      }
      // ignore: use_build_context_synchronously
      showSuccess(context, message: 'Item berhasil disimpan');
    } catch (e) {
      showError(context, message: e.toString());
    }
  }
}
