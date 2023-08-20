import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/model/paymentmethod.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/paymentmethod.dart';
import 'package:sultanpos/ui/master/paymentmethod/add.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/columnaction.dart';
import 'package:sultanpos/ui/widget/confirmation.dart';
import 'package:sultanpos/ui/widget/datatable.dart';
import 'package:sultanpos/ui/widget/dialogutil.dart';
import 'package:sultanpos/ui/widget/showerror.dart';

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PaymentMethodState>.value(
      value: AppState().paymentMethodState,
      child: Builder(
        builder: (ctx) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Daftar Metode Pembayaran',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Expanded(child: SizedBox()),
                    SButton(
                      onPressed: () {
                        AppState().paymentMethodState.resetForm();
                        sShowDialog(
                          context: ctx,
                          builder: (c) {
                            return ChangeNotifierProvider.value(
                              value: AppState().paymentMethodState,
                              child: const AddPaymentMethodWidget(
                                title: "Tambah Metode",
                              ),
                            );
                          },
                        );
                      },
                      child: const Text('Tambah Metode'),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    SButton(
                      positive: false,
                      onPressed: () {
                        AppState().paymentMethodState.listData.load(refresh: true);
                      },
                      child: const Icon(
                        Icons.refresh,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: SDataTable<PaymentMethodModel>(
                    name: "paymentmethod",
                    state: AppState().paymentMethodState.listData,
                    columns: [
                      SDataColumn(
                        width: 100,
                        id: 'action',
                        title: 'Action',
                        getWidget: (v) => v.isDefault
                            ? const SizedBox.shrink()
                            : SColumnAction(
                                [
                                  SColumActionItem('edit', Icons.edit, () {
                                    AppState().paymentMethodState.editForm(v);
                                    sShowDialog(
                                      context: ctx,
                                      builder: (c) {
                                        return ChangeNotifierProvider.value(
                                          value: AppState().paymentMethodState,
                                          child: const AddPaymentMethodWidget(
                                            title: "Edit Metode",
                                          ),
                                        );
                                      },
                                    );
                                  }),
                                  SColumActionItem('hapus', Icons.delete_forever, () async {
                                    final result = await showConfirmation(ctx,
                                        title: 'Yakin hapus', message: 'Yakin untuk menghapus "${v.name}"');
                                    if (result) {
                                      try {
                                        await AppState().paymentMethodState.remove(v.id);
                                      } catch (e) {
                                        // ignore: use_build_context_synchronously
                                        showError(ctx, message: e.toString());
                                      }
                                    }
                                  }, iconColor: Colors.red),
                                ],
                              ),
                      ),
                      SDataColumn(
                        id: 'method',
                        title: 'Metode',
                        get: (v) => v.method.text,
                      ),
                      SDataColumn(
                        id: 'name',
                        title: 'Nama',
                        get: (v) => v.name,
                      ),
                      SDataColumn(
                        id: 'additional',
                        title: 'Biaya tambahan',
                        get: (v) => v.additional,
                      ),
                      SDataColumn(
                        id: 'description',
                        title: 'Keterangan',
                        get: (v) => v.description,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
