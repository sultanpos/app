import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/partner.dart';
import 'package:sultanpos/ui/util/uppercaseformatter.dart';
import 'package:sultanpos/ui/widget/showerror.dart';

class AddPartnerWidget extends StatelessWidget {
  final String title;
  const AddPartnerWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AppState().partnerState,
      child: Dialog(
        child: Builder(
          builder: (ctx) {
            final loading = ctx.select<PartnerState, bool>((value) => value.loading);
            return SizedBox(
              height: 350,
              width: 350,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ReactiveForm(
                  formGroup: AppState().partnerState.form,
                  child: Column(
                    children: [
                      Text(title),
                      const Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                ReactiveCheckbox(
                                  formControlName: "isCustomer",
                                ),
                                const Text('Customer')
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                ReactiveCheckbox(
                                  formControlName: "isSupplier",
                                ),
                                const Text('Supplier')
                              ],
                            ),
                          ),
                        ],
                      ),
                      ReactiveTextField(
                        formControlName: 'name',
                        autofocus: true,
                        inputFormatters: [UpperCaseTextFormatter()],
                        decoration: const InputDecoration(
                          hintText: "Masukkan nama mitra",
                          labelText: "Nama",
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      ReactiveTextField(
                        formControlName: 'npwp',
                        decoration: const InputDecoration(
                          hintText: "Masukkan nomor NPWP",
                          labelText: "Nomor NPWP",
                        ),
                        onSubmitted: () => save(ctx),
                      ),
                      ReactiveTextField(
                        formControlName: 'address',
                        decoration: const InputDecoration(
                          hintText: "Masukkan alamat mitra",
                          labelText: "Alamat",
                        ),
                        onSubmitted: () => save(ctx),
                        maxLines: null,
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
      await AppState().partnerState.save();
      nav.pop();
    } catch (e) {
      showError(context, title: 'Error menyimpan', message: e.toString());
    }
  }
}
