import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/pricegroup.dart';
import 'package:sultanpos/ui/theme.dart';
import 'package:sultanpos/ui/util/textformatter.dart';
import 'package:sultanpos/ui/widget/basewindow.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/labelfield.dart';
import 'package:sultanpos/ui/widget/showerror.dart';

class PriceGroupAddWidget extends StatelessWidget {
  final String title;
  const PriceGroupAddWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWindowWidget(
      title: title,
      icon: Icons.attach_money,
      height: 450,
      width: 350,
      child: ChangeNotifierProvider.value(
        value: AppState().priceGroupState,
        child: Builder(
          builder: (ctx) {
            final loading = ctx.select<PriceGroupState, bool>((value) => value.loading);
            return ReactiveForm(
              formGroup: AppState().priceGroupState.form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LabelField('Nama Group Harga'),
                  ReactiveTextField(
                    formControlName: 'name',
                    autofocus: true,
                    inputFormatters: [UpperCaseTextFormatter()],
                    decoration: const InputDecoration(
                      hintText: "Masukkan nama group harga",
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: STheme().widgetSpace,
                  ),
                  const LabelField('Keterangan'),
                  ReactiveTextField(
                    formControlName: 'description',
                    decoration: const InputDecoration(
                      hintText: "Masukkan keterangan",
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: STheme().widgetSpace,
                  ),
                  const LabelField('Keterangan public'),
                  ReactiveTextField(
                    formControlName: 'publicDescription',
                    decoration: const InputDecoration(
                      hintText: "Masukkan keterangan public",
                    ),
                    onSubmitted: (c) => save(ctx),
                  ),
                  const Spacer(),
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

  save(BuildContext ctx) async {
    try {
      final nav = Navigator.of(ctx);
      await AppState().priceGroupState.save();
      nav.pop();
    } catch (e) {
      showError(ctx, message: e.toString());
    }
  }
}
