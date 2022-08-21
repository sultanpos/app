import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/product.dart';
import 'package:sultanpos/ui/theme.dart';
import 'package:sultanpos/ui/util/textformatter.dart';
import 'package:sultanpos/ui/widget/basewindow.dart';
import 'package:sultanpos/ui/widget/dropdown.dart';
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
                          child: SizedBox(
                            height: double.infinity,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ReactiveTextField(
                                    formControlName: 'barcode',
                                    autofocus: true,
                                    inputFormatters: [UpperCaseTextFormatter()],
                                    decoration: const InputDecoration(labelText: "Barcode", hintText: "Masukkan barcode"),
                                    textInputAction: TextInputAction.next,
                                  ),
                                  const SizedBox(height: 8),
                                  ReactiveTextField(
                                    formControlName: 'name',
                                    inputFormatters: [UpperCaseTextFormatter()],
                                    decoration: const InputDecoration(labelText: "Nama", hintText: "Masukkan name"),
                                    textInputAction: TextInputAction.next,
                                  ),
                                  const SizedBox(height: 8),
                                  const DropdownProductType(
                                    formControlName: 'productType',
                                    inputDecoration: InputDecoration(labelText: 'Tipe'),
                                  ),
                                  const SizedBox(height: 8),
                                  DropdownRepoUnit(
                                    formControlName: 'unitPublicId',
                                    decoration: const InputDecoration(labelText: "Unit", hintText: "Pilih unit"),
                                  ),
                                  const SizedBox(height: 8),
                                  DropdownRepoCategory(
                                    formControlName: 'categoryPublicId',
                                    decoration: const InputDecoration(labelText: "Kategori", hintText: "Pilih kategori"),
                                  ),
                                  const SizedBox(height: 8),
                                  DropdownRepoPartnerSupplier(
                                    formControlName: 'partnerPublicId',
                                    decoration: const InputDecoration(labelText: "Supplier", hintText: "Pilih supplier utama"),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            ReactiveCheckbox(
                                              formControlName: 'sellable',
                                            ),
                                            const Text('Dijual'),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            ReactiveCheckbox(
                                              formControlName: 'buyable',
                                            ),
                                            const Text('Dibeli'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      ReactiveCheckbox(
                                        formControlName: 'calculateStock',
                                      ),
                                      const Text('Hitung stock'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      ReactiveCheckbox(
                                        formControlName: 'editablePrice',
                                      ),
                                      const Text('Harga bisa diedit di kasir'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const VerticalDivider(),
                        Expanded(
                          child: SizedBox(
                            height: double.infinity,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ReactiveTextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [MoneyTextFormatter()],
                                    formControlName: 'buyPrice',
                                    decoration: const InputDecoration(labelText: "Harga Beli", hintText: "Masukkan harga beli"),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
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
                        child: Text(loading ? "Menyimpan..." : "Simpan"),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        onPressed: loading
                            ? null
                            : () async {
                                save(ctx, again: true);
                              },
                        child: Text(loading ? "Menyimpan..." : "Simpan & Lagi"),
                      ),
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

  save(BuildContext context, {bool again = false}) async {
    try {
      final nav = Navigator.of(context);
      await AppState().productState.save();
      if (again) {
        AppState().productState.resetAddAgain();
      } else {
        nav.pop();
      }
    } catch (e) {
      showError(context, title: 'Error menyimpan', message: e.toString());
    }
  }
}
