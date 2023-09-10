import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/cashier.dart';
import 'package:sultanpos/ui/util/textformatter.dart';
import 'package:sultanpos/ui/widget/basewindow.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/info.dart';
import 'package:sultanpos/ui/widget/labelfield.dart';
import 'package:sultanpos/ui/widget/showerror.dart';
import 'package:sultanpos/ui/widget/space.dart';

class CashierSessionAddWidget extends StatelessWidget {
  const CashierSessionAddWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CashierRootState>();
    return BaseWindowWidget(
      title: 'Tambah sesi kasir',
      width: 300,
      height: 300,
      icon: Icons.login,
      child: ReactiveForm(
        formGroup: AppState().cashierState.formGroup,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LabelField("Modal awal"),
            ReactiveTextField(
              formControlName: "openValue",
              autofocus: true,
              inputFormatters: [MoneyTextFormatter()],
              textAlign: TextAlign.right,
              onSubmitted: (control) async {
                save(context, state);
              },
              decoration: const InputDecoration(
                hintText: "Masukan modal awal",
              ),
              onChanged: (v) {},
            ),
            const SVSpaceSmall(),
            const InfoWidget(child: Text("Modal awal ketika membuka kasir, biasanya berupa modal untuk kembalian.")),
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
                    shortCut: const [LogicalKeyboardKey.f5],
                    label: "Simpan",
                    onPressed: state.saving
                        ? null
                        : () async {
                            save(context, state);
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

  save(BuildContext context, CashierRootState state) async {
    try {
      await state.saveCashierSession();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(true);
    } catch (e) {
      // ignore: use_build_context_synchronously
      showError(context, message: e.toString());
    }
  }
}
