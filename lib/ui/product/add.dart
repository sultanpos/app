import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/format.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/product.dart';
import 'package:sultanpos/ui/util/textformatter.dart';
import 'package:sultanpos/ui/widget/basewindow.dart';
import 'package:sultanpos/ui/widget/chip.dart';
import 'package:sultanpos/ui/widget/dropdown.dart';
import 'package:sultanpos/ui/widget/showerror.dart';

class AddProductWidget extends StatelessWidget {
  final String title;
  const AddProductWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWindowWidget(
      height: 500,
      width: 650,
      title: title,
      child: ChangeNotifierProvider.value(
        value: AppState().productState,
        child: Builder(
          builder: (ctx) {
            final state = ctx.watch<ProductState>();
            final loading = state.loading;
            final count = state.priceCounter;
            final discMargin = state.discountMargins;
            return ReactiveForm(
              formGroup: AppState().productState.form,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 280,
                          child: SizedBox(
                            height: double.infinity,
                            child: SizedBox(
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
                        const VerticalDivider(
                          color: Colors.white,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: double.infinity,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ReactiveTextField(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [MoneyTextFormatter()],
                                          formControlName: 'stock',
                                          decoration: const InputDecoration(labelText: "Stock Awal", hintText: "Masukkan stock"),
                                          textInputAction: TextInputAction.next,
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: ReactiveTextField(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [MoneyTextFormatter()],
                                          formControlName: 'buyPrice',
                                          decoration: const InputDecoration(labelText: "Harga Beli", hintText: "Masukkan harga beli"),
                                          textInputAction: TextInputAction.next,
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ],
                                  ),
                                  for (int i = 0; i < count; i++) ...[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      child: Container(
                                        height: 1,
                                        width: double.infinity,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(child: Text('Harga ${i + 1}')),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: ReactiveTextField(
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [MoneyTextFormatter()],
                                            formControlName: 'count$i',
                                            decoration: const InputDecoration(labelText: "Min Pembelian", hintText: "Masukkan min pembelian"),
                                            textInputAction: TextInputAction.next,
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ReactiveTextField(
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [MoneyTextFormatter()],
                                            formControlName: 'sell$i',
                                            decoration: const InputDecoration(labelText: "Harga Jual", hintText: "Masukkan harga"),
                                            textInputAction: TextInputAction.next,
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: ReactiveTextField(
                                            formControlName: 'disc$i',
                                            decoration: const InputDecoration(labelText: "Discount Formula", hintText: "Masukkan discount formula"),
                                            textInputAction: TextInputAction.next,
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        const Expanded(child: SizedBox()),
                                        SChip(color: Colors.brown, label: 'dis: ${Format().formatMoney(discMargin[i].discount)}'),
                                        const SizedBox(width: 4),
                                        SChip(color: Colors.blue, label: 'akhir: ${Format().formatMoney(discMargin[i].finalPrice)}'),
                                        const SizedBox(width: 4),
                                        SChip(
                                            color: discMargin[i].margin > 0 ? Colors.green : Colors.red,
                                            label: 'mar: ${Format().formatPerc(discMargin[i].margin)}%')
                                      ],
                                    ),
                                  ],
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      if (count > 1)
                                        TextButton(
                                          child: const Text(
                                            "Hapus harga",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          onPressed: () {
                                            ctx.read<ProductState>().removePrice();
                                          },
                                        ),
                                      const Expanded(child: SizedBox()),
                                      if (count < 5)
                                        TextButton(
                                          child: const Text("Tambah harga"),
                                          onPressed: () {
                                            ctx.read<ProductState>().addPrice();
                                          },
                                        ),
                                    ],
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
                                save(context);
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
                                save(context, again: true);
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
