import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/pricegroup.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/partner.dart';
import 'package:sultanpos/ui/theme.dart';
import 'package:sultanpos/ui/util/textformatter.dart';
import 'package:sultanpos/ui/widget/basewindow.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/dropdown.dart';
import 'package:sultanpos/ui/widget/form/reactivecheckbox.dart';
import 'package:sultanpos/ui/widget/labelfield.dart';
import 'package:sultanpos/ui/widget/showerror.dart';

class AddPartnerWidget extends StatelessWidget {
  final String title;
  const AddPartnerWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWindowWidget(
      icon: Icons.people,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const LabelField('Tipe Mitra'),
                          Row(
                            children: [
                              SReactiveCheckbox(
                                title: "Customer",
                                formControlName: "isCustomer",
                              ),
                              SizedBox(
                                width: STheme().widgetSpace,
                              ),
                              SReactiveCheckbox(
                                title: "Supplier",
                                formControlName: "isSupplier",
                              ),
                            ],
                          ),
                          SizedBox(
                            height: STheme().widgetSpace,
                          ),
                          const LabelField('Nama'),
                          ReactiveTextField(
                            formControlName: 'name',
                            autofocus: true,
                            inputFormatters: [UpperCaseTextFormatter()],
                            decoration: const InputDecoration(
                              hintText: "Masukkan nama mitra",
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: STheme().widgetSpace,
                          ),
                          const LabelField('Telepon'),
                          ReactiveTextField(
                            formControlName: 'phone',
                            autofocus: true,
                            decoration: const InputDecoration(
                              hintText: "Masukkan nomor telepon",
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: STheme().widgetSpace,
                          ),
                          const LabelField('Email'),
                          ReactiveTextField(
                            formControlName: 'email',
                            autofocus: true,
                            decoration: const InputDecoration(
                              hintText: "Masukkan alamat email",
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: STheme().widgetSpace,
                          ),
                          const LabelField('Nomor NPWP'),
                          ReactiveTextField(
                            formControlName: 'npwp',
                            decoration: const InputDecoration(
                              hintText: "Masukkan nomor NPWP",
                            ),
                          ),
                          SizedBox(
                            height: STheme().widgetSpace,
                          ),
                          const LabelField('Alamat'),
                          ReactiveTextField(
                            formControlName: 'address',
                            decoration: const InputDecoration(
                              hintText: "Masukkan alamat mitra",
                            ),
                            onSubmitted: (c) => save(ctx),
                            maxLines: null,
                          ),
                          SizedBox(
                            height: STheme().widgetSpace,
                          ),
                          const LabelField('Group Harga'),
                          DropdownRepo<PriceGroupModel, int>(
                            creator: PriceGroupModel.fromJson,
                            path: "/pricegroup",
                            formControlName: 'priceGroupId',
                            autoFocus: true,
                            textFn: (value) => value.name,
                            valueFn: (value) => value.id,
                            decoration: const InputDecoration(
                              hintText: "Pilih group harga",
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
      await AppState().partnerState.save();
      nav.pop();
    } catch (e) {
      showError(context, title: 'Error menyimpan', message: e.toString());
    }
  }
}
