import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/state/cashier.dart';
import 'package:sultanpos/ui/cashier/addsession.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/confirmation.dart';
import 'package:sultanpos/ui/widget/dialogutil.dart';
import 'package:sultanpos/ui/widget/space.dart';

class CashierWidget extends StatelessWidget {
  const CashierWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CashierRootState>();
    return Center(
      child: state.loadingInit
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : !state.cashierOpened
              ? const CashierNoSessionWidget()
              : const Text('Root here'),
    );
  }
}

class CashierNoSessionWidget extends StatelessWidget {
  const CashierNoSessionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 500,
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.nearby_error,
              color: Colors.red,
              size: 64,
            ),
            const SVSpace(),
            const Text('Tidak ditemukan sesi kasir!'),
            const SVSpace(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SButton(
                  child: const Text('Buat sesi kasir baru'),
                  onPressed: () {
                    sShowDialog(
                      context: context,
                      builder: (c) {
                        return const CashierAddSessionWidget();
                      },
                    );
                  },
                ),
                const SHSpace(),
                SButton(
                  positive: false,
                  child: const Text('Mulai kasir tanpa sesi'),
                  onPressed: () async {
                    final value = await showConfirmation(context,
                        title: 'Konfirmasi', message: 'Yakin untuk membuka kasir tanpa sesi?');
                    if (value) {
                      // ignore: use_build_context_synchronously
                      context.read<CashierRootState>().openCashierWithoutSession();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
