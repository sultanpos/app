import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/purchase.dart';
import 'package:sultanpos/ui/theme.dart';
import 'package:sultanpos/ui/util/textformatter.dart';
import 'package:sultanpos/ui/widget/basewindow.dart';
import 'package:sultanpos/ui/widget/dropdown.dart';
import 'package:sultanpos/ui/widget/showerror.dart';
import 'package:sultanpos/util/format.dart';

class AddPurchaseWidget extends StatelessWidget {
  final String title;
  const AddPurchaseWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWindowWidget(
      height: 300,
      width: 350,
      title: title,
      child: ChangeNotifierProvider.value(
        value: AppState().purchaseState,
        child: Builder(
          builder: (ctx) {
            final loading = ctx.select<PurchaseState, bool>((value) => value.loading);
            return ReactiveForm(
              formGroup: AppState().purchaseState.form,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ReactiveTextField(
                            formControlName: 'number',
                            autofocus: true,
                            inputFormatters: [UpperCaseTextFormatter()],
                            decoration: const InputDecoration(
                              hintText: "Masukkan nomor pembelian",
                              labelText: "Nomor",
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: STheme().widgetSpace,
                          ),
                          ReactiveDropdownField(
                            items: const [
                              DropdownMenuItem(
                                value: 'direct',
                                child: Text('Langsung'),
                              ),
                              DropdownMenuItem(
                                value: 'deadline',
                                child: Text('Deadline'),
                              ),
                            ],
                            formControlName: 'type',
                            decoration: const InputDecoration(
                              hintText: "Pilih tipe pembelian",
                              labelText: "Tipe",
                            ),
                          ),
                          ReactiveFormConsumer(
                            builder: ((context, formGroup, child) {
                              return formGroup.control('type').value == 'deadline'
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          height: STheme().widgetSpace,
                                        ),
                                        ReactiveDatePicker(
                                          formControlName: "deadline",
                                          builder: (context, picker, child) {
                                            final value = formGroup.control('deadline').value;
                                            return GestureDetector(
                                              onTap: () {
                                                picker.showPicker();
                                              },
                                              child: InputDecorator(
                                                decoration: const InputDecoration(
                                                  labelText: "Deadline",
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(top: 4),
                                                  child: Text(formatDate(value)),
                                                ),
                                              ),
                                            );
                                          },
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(DateTime.now().year + 10),
                                        ),
                                      ],
                                    )
                                  : const SizedBox.shrink();
                            }),
                          ),
                          SizedBox(
                            height: STheme().widgetSpace,
                          ),
                          DropdownRepoPartnerSupplier(
                            formControlName: 'partnerPublicId',
                            decoration: const InputDecoration(labelText: "Supplier", hintText: "Pilih supplier"),
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
      await AppState().purchaseState.save();
      nav.pop();
    } catch (e) {
      showError(context, title: 'Error menyimpan', message: e.toString());
    }
  }
}
