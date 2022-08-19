import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/product.dart';
import 'package:sultanpos/ui/theme.dart';
import 'package:sultanpos/ui/util/uppercaseformatter.dart';
import 'package:sultanpos/ui/widget/basewindow.dart';
import 'package:sultanpos/ui/widget/showerror.dart';

class AddProductWidget extends StatelessWidget {
  final String title;
  const AddProductWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWindowWidget(
      height: 500,
      width: 600,
      title: title,
      child: ChangeNotifierProvider.value(
        value: AppState().productState,
        child: Builder(
          builder: (ctx) {
            final loading = ctx.select<ProductState, bool>((value) => value.loading);
            return ReactiveForm(
              formGroup: AppState().productState.form,
              child: Column(
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          ReactiveTextField(
                            formControlName: 'barcode',
                            autofocus: true,
                            inputFormatters: [UpperCaseTextFormatter()],
                            decoration: STheme().defInputDecoration.copyWith(labelText: "Barcode", hintText: "Masukkan barcode"),
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ReactiveTextField(
                            formControlName: 'name',
                            autofocus: true,
                            inputFormatters: [UpperCaseTextFormatter()],
                            decoration: STheme().defInputDecoration.copyWith(labelText: "Nama", hintText: "Masukkan name"),
                            textInputAction: TextInputAction.next,
                          ),
                        ],
                      )),
                      SizedBox(width: 16),
                      Expanded(child: Text('DUA')),
                    ],
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                          ),
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
            );
          },
        ),
      ),
    );
  }

  save(BuildContext context) async {
    try {
      final nav = Navigator.of(context);
      await AppState().partnerState.save();
      nav.pop();
    } catch (e) {
      showError(context, title: 'Error menyimpan', message: e.toString());
    }
  }
}
