import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/model/partner.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/ui/partner/add.dart';
import 'package:sultanpos/ui/widget/chip.dart';
import 'package:sultanpos/ui/widget/columnaction.dart';
import 'package:sultanpos/ui/widget/confirmation.dart';
import 'package:sultanpos/ui/widget/datatable.dart';
import 'package:sultanpos/ui/widget/dialogutil.dart';
import 'package:sultanpos/ui/widget/showerror.dart';

class PartnerWidget extends StatelessWidget {
  const PartnerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AppState().partnerState,
      child: Builder(
        builder: (ctx) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Daftar Mitra',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Expanded(child: SizedBox()),
                    ElevatedButton(
                      onPressed: () {
                        AppState().partnerState.resetForm();
                        sShowDialog(
                          context: ctx,
                          builder: (c) {
                            return const AddPartnerWidget(
                              title: "Tambah Mitra Baru",
                            );
                          },
                        );
                      },
                      child: const Text('Tambah Mitra'),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    SizedBox(
                      width: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          AppState().partnerState.listData.load(refresh: true);
                        },
                        style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(0)),
                        child: const Icon(
                          Icons.refresh,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: SDataTable<PartnerModel>(
                    columns: [
                      SDataColumn(
                        width: 100,
                        id: 'action',
                        title: 'Action',
                        getWidget: (v) => SColumnAction(
                          [
                            SColumActionItem('edit', Icons.edit, () {
                              AppState().partnerState.editForm(v);
                              sShowDialog(
                                context: ctx,
                                builder: (c) {
                                  return const AddPartnerWidget(title: "Edit mitra");
                                },
                              );
                            }),
                            SColumActionItem('hapus', Icons.delete_forever, () async {
                              final result = await showConfirmation(ctx,
                                  title: 'Yakin hapus', message: 'Yakin untuk menghapus "${v.name}"');
                              if (result) {
                                try {
                                  await AppState().partnerState.remove(v.id);
                                } catch (e) {
                                  // ignore: use_build_context_synchronously
                                  showError(ctx, title: 'Error menghapus', message: e.toString());
                                }
                              }
                            }, iconColor: Colors.red),
                          ],
                        ),
                      ),
                      SDataColumn(
                        id: 'isCustomer',
                        title: 'Konsumen/Supplier',
                        getWidget: (v) => Row(children: [
                          if (v.isCustomer)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: SChip(color: Colors.green, label: 'KONSUMEN'),
                            ),
                          if (v.isSupplier)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: SChip(color: Colors.blue, label: 'SUPPLIER'),
                            ),
                        ]),
                      ),
                      SDataColumn(
                        id: 'number',
                        title: 'Nomor',
                        get: (v) => v.number,
                      ),
                      SDataColumn(
                        id: 'name',
                        title: 'Nama',
                        get: (v) => v.name,
                      ),
                      SDataColumn(
                        id: 'phone',
                        title: 'Telepon',
                        get: (v) => v.phone,
                      ),
                    ],
                    name: 'partner',
                    state: AppState().partnerState.listData,
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
