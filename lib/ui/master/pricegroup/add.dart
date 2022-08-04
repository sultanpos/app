import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/pricegroup.dart';
import 'package:sultanpos/ui/util/uppercaseformatter.dart';
import 'package:sultanpos/ui/widget/showerror.dart';

class PriceGroupAddWidget extends StatelessWidget {
  final String title;
  const PriceGroupAddWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AppState().priceGroupState!,
      child: Dialog(
        child: Builder(
          builder: (ctx) {
            final loading = ctx.select<PriceGroupState, bool>((value) => value.loading);
            return SizedBox(
              height: 200,
              width: 300,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ReactiveForm(
                  formGroup: AppState().priceGroupState!.form,
                  child: Column(
                    children: [
                      Text(title),
                      const Divider(),
                      ReactiveTextField(
                        formControlName: 'name',
                        inputFormatters: [UpperCaseTextFormatter()],
                        decoration: const InputDecoration(
                          hintText: "Masukkan nama group harga",
                          labelText: "Nama Group Harga",
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: loading
                                  ? null
                                  : () {
                                      Navigator.of(ctx).pop();
                                    },
                              child: const Text("Batal")),
                          const SizedBox(
                            width: 8,
                          ),
                          ElevatedButton(
                              onPressed: loading
                                  ? null
                                  : () async {
                                      try {
                                        final nav = Navigator.of(ctx);
                                        await AppState().priceGroupState!.save();
                                        nav.pop();
                                      } catch (e) {
                                        showError(context, title: 'Error menyimpan', message: e.toString());
                                      }
                                    },
                              child: Text(loading ? "Menyimpan..." : "Simpan")),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
