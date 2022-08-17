import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/partner.dart';
import 'package:sultanpos/model/pricegroup.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/partner.dart';
import 'package:sultanpos/ui/util/uppercaseformatter.dart';
import 'package:sultanpos/ui/widget/basewindow.dart';
import 'package:sultanpos/ui/widget/dropdown.dart';
import 'package:sultanpos/ui/widget/showerror.dart';

class AddPartnerWidget extends StatelessWidget {
  final String title;
  const AddPartnerWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWindowWidget(
      height: 500,
      width: 350,
      title: title,
      child: ChangeNotifierProvider.value(
        value: AppState().partnerState,
        child: Builder(
          builder: (ctx) {
            final loading = ctx.select<PartnerState, bool>((value) => value.loading);
            return ReactiveForm(
              formGroup: AppState().partnerState.form,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
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
                            formControlName: 'phone',
                            autofocus: true,
                            decoration: const InputDecoration(
                              hintText: "Masukkan nomor telepon",
                              labelText: "Telepon",
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                          ReactiveTextField(
                            formControlName: 'email',
                            autofocus: true,
                            decoration: const InputDecoration(
                              hintText: "Masukkan alamat email",
                              labelText: "Email",
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
                          DropdownRepo<PriceGroupModel, String>(
                            creator: PriceGroupModel.fromJson,
                            path: "/pricegroup",
                            formControlName: 'priceGroupPublicId',
                            autoFocus: true,
                            textFn: (value) => value.name,
                            valueFn: (value) => value.publicId,
                            decoration: const InputDecoration(
                              hintText: "Pilih group harga",
                              labelText: "Group Harga",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
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
