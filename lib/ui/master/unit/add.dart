import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/state/app.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/state/unit.dart';
import 'package:sultanpos/ui/theme.dart';
import 'package:sultanpos/ui/util/textformatter.dart';
import 'package:sultanpos/ui/widget/basewindow.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/labelfield.dart';
import 'package:sultanpos/ui/widget/showerror.dart';

class UnitAddWidget extends StatelessWidget {
  final String title;
  const UnitAddWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWindowWidget(
      title: title,
      height: 400,
      width: 300,
      icon: Icons.scale,
      child: ChangeNotifierProvider.value(
        value: AppState().unitState,
        child: Builder(
          builder: (ctx) {
            final loading = ctx.select<UnitState, bool>((value) => value.loading);
            return ReactiveForm(
              formGroup: AppState().unitState.form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LabelField('Nama'),
                  ReactiveTextField(
                    formControlName: 'name',
                    autofocus: true,
                    inputFormatters: [UpperCaseTextFormatter()],
                    decoration: const InputDecoration(
                      hintText: "Masukkan nama unit",
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: STheme().widgetSpace,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text("Keterangan"),
                  ),
                  ReactiveTextField(
                    formControlName: 'description',
                    decoration: const InputDecoration(
                      hintText: "Masukkan keterangan unit",
                    ),
                    onSubmitted: (c) => save(ctx),
                    maxLines: 3,
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

  save(BuildContext context) async {
    try {
      final nav = Navigator.of(context);
      await AppState().unitState.save();
      nav.pop();
    } catch (e) {
      showError(context, title: 'Error menyimpan', message: e.toString());
    }
  }
}
