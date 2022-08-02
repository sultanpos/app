import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/state/app.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/state/unit.dart';

class UnitAddWidget extends StatelessWidget {
  const UnitAddWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AppState().unitState!,
      child: Dialog(
        child: Builder(builder: (ctx) {
          final loading = ctx.select<UnitState, bool>((value) => value.loading);
          return SizedBox(
            height: 200,
            width: 300,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ReactiveForm(
                formGroup: AppState().unitState!.form,
                child: Column(
                  children: [
                    const Text('Tambah Unit'),
                    const Divider(),
                    ReactiveTextField(
                      formControlName: 'name',
                      decoration: const InputDecoration(
                        hintText: "Masukkan nama unit",
                        labelText: "Nama",
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
                                      await AppState().unitState!.add();
                                      nav.pop();
                                    } catch (e) {
                                      MotionToast.error(
                                        title: const Text('Login failed'),
                                        description: Text(e.toString()),
                                        position: MotionToastPosition.top,
                                        animationType: AnimationType.fromTop,
                                        animationCurve: Curves.ease,
                                        animationDuration: const Duration(milliseconds: 200),
                                      ).show(context);
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
        }),
      ),
    );
  }
}
