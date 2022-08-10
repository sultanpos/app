import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/state/app.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/state/unit.dart';
import 'package:sultanpos/ui/util/uppercaseformatter.dart';
import 'package:sultanpos/ui/widget/showerror.dart';

class UnitAddWidget extends StatelessWidget {
  final String title;
  const UnitAddWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AppState().unitState!,
      child: Dialog(
        child: Builder(
          builder: (ctx) {
            final loading = ctx.select<UnitState, bool>((value) => value.loading);
            return SizedBox(
              height: 300,
              width: 350,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ReactiveForm(
                  formGroup: AppState().unitState!.form,
                  child: Column(
                    children: [
                      Text(title),
                      const Divider(),
                      ReactiveTextField(
                        formControlName: 'name',
                        autofocus: true,
                        inputFormatters: [UpperCaseTextFormatter()],
                        decoration: const InputDecoration(
                          hintText: "Masukkan nama unit",
                          labelText: "Nama",
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      ReactiveTextField(
                        formControlName: 'description',
                        decoration: const InputDecoration(
                          hintText: "Masukkan keterangan unit",
                          labelText: "Keterangan",
                        ),
                        onSubmitted: () => save(ctx),
                        maxLines: 3,
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

  save(BuildContext context) async {
    try {
      final nav = Navigator.of(context);
      await AppState().unitState!.save();
      nav.pop();
    } catch (e) {
      showError(context, title: 'Error menyimpan', message: e.toString());
    }
  }
}
