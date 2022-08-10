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
              height: 300,
              width: 350,
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
                        autofocus: true,
                        inputFormatters: [UpperCaseTextFormatter()],
                        decoration: const InputDecoration(
                          hintText: "Masukkan nama group harga",
                          labelText: "Nama Group Harga",
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      ReactiveTextField(
                        formControlName: 'description',
                        decoration: const InputDecoration(
                          hintText: "Masukkan keterangan",
                          labelText: "Keterangan",
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      ReactiveTextField(
                        formControlName: 'publicDescription',
                        decoration: const InputDecoration(
                          hintText: "Masukkan keterangan public",
                          labelText: "Keterangan public",
                        ),
                        onSubmitted: () => save(ctx),
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
                                      save(ctx);
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

  save(BuildContext ctx) async {
    try {
      final nav = Navigator.of(ctx);
      await AppState().priceGroupState!.save();
      nav.pop();
    } catch (e) {
      showError(ctx, title: 'Error menyimpan', message: e.toString());
    }
  }
}
