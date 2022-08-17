import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/model/partner.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/ui/partner/add.dart';
import 'package:sultanpos/ui/widget/datatable.dart';

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
                        showDialog(
                          context: ctx,
                          useRootNavigator: false,
                          builder: (c) {
                            return const AddPartnerWidget(
                              title: "Tambah Mitra Baru",
                            );
                          },
                        );
                      },
                      child: const Text('Tambah Mitra'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: SDataTable<PartnerModel>(columns: [], name: 'partner', state: AppState().partnerState.listData),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
