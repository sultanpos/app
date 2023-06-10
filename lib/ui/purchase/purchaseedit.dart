import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/state/purchaseitem.dart';
import 'package:sultanpos/ui/purchase/additem.dart';
import 'package:sultanpos/ui/theme.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/dialogutil.dart';
import 'package:sultanpos/ui/widget/space.dart';
import 'package:sultanpos/ui/widget/tilewidget.dart';
import 'package:sultanpos/util/format.dart';

class PurchaseEditWidget extends StatelessWidget {
  const PurchaseEditWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PurchaseItemState>();
    return Padding(
      padding: EdgeInsets.all(STheme().padding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "${state.purchase.number} / ${state.purchase.partner?.name}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              SButton(
                label: 'Tambah item',
                onPressed: () {
                  state.resetForm();
                  sShowDialog(
                    context: context,
                    builder: (c) {
                      return ChangeNotifierProvider.value(
                        value: state,
                        child: const PurchaseItemAddWidget(
                          "Tambah Item Baru",
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          const SVSpace(),
          TileWidget(title: 'Total: ', value: 'Rp. ${formatMoney(state.purchase.total)}'),
          const Expanded(
            child: Text("hola"),
          ),
        ],
      ),
    );
    /*final state = context.watch<PurchaseEditState>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Tambah pembelian baru',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Expanded(child: SizedBox()),
              ElevatedButton(onPressed: () {}, child: const Text('Simpan')),
              const SizedBox(
                width: 4,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  onPressed: () {
                    AppState().purchaseState.closeTab(state.id);
                  },
                  child: const Text('Tutup')),
            ],
          ),
          const Divider(),
          ReactiveForm(
            formGroup: state.form,
            child: Row(
              children: [
                SizedBox(
                  width: 300,
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
                          formControlName: 'partnerId',
                          decoration: const InputDecoration(labelText: "Supplier", hintText: "Pilih supplier"),
                        ),
                      ],
                    ),
                  ),
                ),
                const VerticalDivider(),
                const Expanded(
                  child: Text('asd'),
                ),
              ],
            ),
          )
        ],
      ),
    );*/
  }
}
