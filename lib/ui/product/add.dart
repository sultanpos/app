import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/format.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/product.dart';
import 'package:sultanpos/ui/theme.dart';
import 'package:sultanpos/ui/util/textformatter.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/chip.dart';
import 'package:sultanpos/ui/widget/dropdown.dart';
import 'package:sultanpos/ui/widget/form/reactivecheckbox.dart';
import 'package:sultanpos/ui/widget/labelfield.dart';
import 'package:sultanpos/ui/widget/showerror.dart';
import 'package:sultanpos/ui/widget/space.dart';

class AddProductWidget extends StatelessWidget {
  final String title;
  const AddProductWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductState>();
    final loading = state.loading;
    final count = state.priceCounter;
    final discMargin = state.discountMargins;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                state.current == null ? title : 'Ubah ${state.current!.name}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              SButton(
                  positive: false,
                  onPressed: () {
                    AppState().productRootState.closeTab(state.getId());
                  },
                  label: "Batal"),
              const SHSpace(),
              SButton(
                onPressed: loading
                    ? null
                    : () async {
                        save(context, state);
                      },
                label: loading ? "Menyimpan..." : "Simpan",
              ),
              const SHSpace(),
              SButton(
                onPressed: loading
                    ? null
                    : () async {
                        save(context, state);
                      },
                label: loading ? "Menyimpan..." : "Simpan & Lagi",
              ),
            ],
          ),
          const SVSpace(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).secondaryHeaderColor,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: SingleChildScrollView(
                child: ReactiveForm(
                  formGroup: state.form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Informasi barang",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SVSpaceDouble(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const LabelField('Barcode'),
                                ReactiveTextField(
                                  formControlName: 'barcode',
                                  autofocus: true,
                                  inputFormatters: [UpperCaseTextFormatter()],
                                  decoration: const InputDecoration(hintText: "Masukkan barcode"),
                                  textInputAction: TextInputAction.next,
                                ),
                              ],
                            ),
                          ),
                          const SHSpace(),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const LabelField('Nama barang'),
                                ReactiveTextField(
                                  formControlName: 'name',
                                  inputFormatters: [UpperCaseTextFormatter()],
                                  decoration: const InputDecoration(hintText: "Masukkan nama barang"),
                                  textInputAction: TextInputAction.next,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SVSpace(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LabelField('Tipe barang'),
                                DropdownProductType(
                                  formControlName: 'productType',
                                  inputDecoration: InputDecoration(hintText: 'Pilih tipe barang'),
                                ),
                              ],
                            ),
                          ),
                          const SHSpace(),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const LabelField('Satuan'),
                                DropdownRepoUnit(
                                  formControlName: 'unitId',
                                  decoration: const InputDecoration(hintText: "Pilih unit"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SVSpace(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const LabelField('Kategori'),
                                DropdownRepoCategory(
                                  formControlName: 'categoryId',
                                  decoration: const InputDecoration(hintText: "Pilih kategori"),
                                ),
                              ],
                            ),
                          ),
                          const SHSpace(),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const LabelField('Supplier utama'),
                                DropdownRepoPartnerSupplier(
                                  formControlName: 'partnerId',
                                  decoration: const InputDecoration(hintText: "Pilih supplier utama"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SVSpace(),
                      Row(
                        children: [
                          SReactiveCheckbox(formControlName: 'sellable', title: 'Dijual'),
                          const SHSpace(),
                          SReactiveCheckbox(formControlName: 'buyable', title: 'Dibeli'),
                          const SHSpace(),
                          SReactiveCheckbox(formControlName: 'calculateStock', title: 'Hitung persediaan'),
                          const SHSpace(),
                          SReactiveCheckbox(formControlName: 'editablePrice', title: 'Harga bisa diedit kasir'),
                          const Spacer(),
                        ],
                      ),
                      /*SizedBox(
                        child: FocusTraversalGroup(
                          policy: OrderedTraversalPolicy(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [],
                          ),
                        ),
                      ),*/
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: STheme().widgetSpace),
                        child: const Divider(
                          height: 0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 16),
                        child: Text(
                          "Informasi harga dan persediaan awal",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const LabelField('Persediaan awal'),
                                ReactiveTextField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [StockTextFormatter()],
                                  formControlName: 'stock',
                                  decoration: const InputDecoration(hintText: "Masukkan persediaan awal"),
                                  textInputAction: TextInputAction.next,
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ),
                          const SHSpace(),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const LabelField('Harga beli awal'),
                                ReactiveTextField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [MoneyTextFormatter()],
                                  formControlName: 'buyPrice',
                                  decoration: const InputDecoration(hintText: "Masukkan harga beli awal"),
                                  textInputAction: TextInputAction.next,
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ),
                          const SHSpace(),
                          const Spacer(),
                        ],
                      ),
                      const SVSpace(),
                      for (int i = 0; i < count; i++) ...[
                        Container(
                          padding: EdgeInsets.all(STheme().padding * 2),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Harga ${i + 1}', style: Theme.of(context).textTheme.titleMedium),
                                  const Spacer(),
                                  if (i > 0)
                                    TextButton(
                                      child: const Text(
                                        "Hapus harga",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onPressed: () {
                                        state.removePrice(i);
                                      },
                                    ),
                                ],
                              ),
                              const SVSpace(),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const LabelField('Minimal pembelian'),
                                        ReactiveTextField(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [MoneyTextFormatter()],
                                          formControlName: 'count$i',
                                          decoration: const InputDecoration(hintText: "Masukkan min pembelian"),
                                          textInputAction: TextInputAction.next,
                                          textAlign: TextAlign.right,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SHSpace(),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const LabelField('Harga jual'),
                                        ReactiveTextField(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [MoneyTextFormatter()],
                                          formControlName: 'sell$i',
                                          decoration: const InputDecoration(hintText: "Masukkan harga"),
                                          textInputAction: TextInputAction.next,
                                          textAlign: TextAlign.right,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SHSpace(),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const LabelField('Diskon formula'),
                                        ReactiveTextField(
                                          formControlName: 'disc$i',
                                          decoration: const InputDecoration(hintText: "Masukkan discount formula"),
                                          textInputAction: TextInputAction.next,
                                          textAlign: TextAlign.right,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SVSpace(),
                              Row(
                                children: [
                                  const Expanded(child: SizedBox()),
                                  SChip(
                                      fontSize: 14,
                                      color: Colors.red,
                                      label: 'diskon: ${Format().formatMoney(discMargin[i].discount)}'),
                                  const SizedBox(width: 4),
                                  SChip(
                                      fontSize: 14,
                                      color: Colors.blue,
                                      label: 'harga akhir: ${Format().formatMoney(discMargin[i].finalPrice)}'),
                                  const SizedBox(width: 4),
                                  SChip(
                                      fontSize: 14,
                                      color: discMargin[i].margin > 0 ? Colors.green : Colors.green,
                                      label: 'margin: ${Format().formatPerc(discMargin[i].margin)}%')
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SVSpace(),
                      ],
                      Row(
                        children: [
                          const Spacer(),
                          if (count < 5)
                            SButton(
                              positive: false,
                              label: "Tambah Harga",
                              onPressed: () {
                                state.addPrice();
                              },
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  save(BuildContext context, ProductState state) async {
    try {
      await state.save();
      if (state.current == null) {
        state.resetAddAgain();
        // ignore: use_build_context_synchronously
        showSuccess(context, title: "Berhasil menyimpan", message: "Barang telah ditambahkan");
      } else {
        // ignore: use_build_context_synchronously
        showSuccess(context, title: "Berhasil menyimpan", message: "Barang telah diubah");
      }
    } catch (e) {
      showError(context, title: 'Error menyimpan', message: e.toString());
    }
  }
}
