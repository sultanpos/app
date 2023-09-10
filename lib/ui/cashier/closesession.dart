import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/cashier.dart';
import 'package:sultanpos/ui/util/textformatter.dart';
import 'package:sultanpos/ui/widget/basewindow.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/labelfield.dart';
import 'package:sultanpos/ui/widget/showerror.dart';
import 'package:sultanpos/util/format.dart';

class CashierSessionCloseWidget extends StatefulWidget {
  const CashierSessionCloseWidget({super.key});

  @override
  State<CashierSessionCloseWidget> createState() => _CashierSessionCloseWidgetState();
}

class _CashierSessionCloseWidgetState extends State<CashierSessionCloseWidget> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CashierRootState>();
    return BaseWindowWidget(
      title: 'Tutup sesi kasir',
      width: 300,
      height: 450,
      icon: Icons.logout,
      child: state.reportLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ReactiveForm(
              formGroup: AppState().cashierState.formGroupClose,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LabelField(
                    "Modal awal",
                    skipPadding: true,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      formatMoney(state.currentSession!.openValue),
                    ),
                  ),
                  const Divider(),
                  const LabelField(
                    "Total uang masuk",
                    skipPadding: true,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      formatMoney(state.report!.paymentInTotal),
                    ),
                  ),
                  const LabelField(
                    "Total uang keluar",
                    skipPadding: true,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      formatMoney(state.report!.paymentOutTotal),
                    ),
                  ),
                  const Divider(),
                  const LabelField(
                    "Uang akhir terhitung",
                    skipPadding: true,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      formatMoney(state.currentSession!.openValue + state.report!.calculated()),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const LabelField("Uang akhir fisik"),
                  ReactiveTextField(
                    autofocus: true,
                    focusNode: _focusNode,
                    formControlName: "closeValue",
                    inputFormatters: [MoneyTextFormatter()],
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(
                        hintText: "Jumlah uang", helperText: "Total semua uang termasuk modal awal"),
                    onSubmitted: (control) async {
                      await closeSession(context, state);
                    },
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: SButton(
                          positive: false,
                          label: "Batal",
                          onPressed: state.saving
                              ? null
                              : () {
                                  Navigator.of(context).pop(false);
                                },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: SButton(
                          label: "Simpan",
                          onPressed: state.saving
                              ? null
                              : () async {
                                  await closeSession(context, state);
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

  closeSession(BuildContext context, CashierRootState state) async {
    try {
      await state.closeSession();
      // ignore: use_build_context_synchronously
      Navigator.pop(context, true);
    } catch (e) {
      // ignore: use_build_context_synchronously
      showError(context, message: e.toString());
      _focusNode.requestFocus();
    }
  }
}
