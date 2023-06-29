import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/cashier.dart';
import 'package:sultanpos/state/cart.dart';
import 'package:sultanpos/ui/cashier/addsession.dart';
import 'package:sultanpos/ui/cashier/cart.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/confirmation.dart';
import 'package:sultanpos/ui/widget/dialogutil.dart';
import 'package:sultanpos/ui/widget/keyshortcut.dart';
import 'package:sultanpos/ui/widget/space.dart';
import 'package:sultanpos/ui/widget/verticalmenu.dart';

class CashierWidget extends StatelessWidget {
  const CashierWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loadingInit = context.select<CashierRootState, bool>(
      (value) => value.loadingInit,
    );
    final cashierOpened = context.select<CashierRootState, bool>(
      (value) => value.cashierOpened,
    );
    return Center(
      child: loadingInit
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : !cashierOpened
              ? const CashierNoSessionWidget()
              : const CashierRootWidget(),
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

class CashierRootWidget extends StatelessWidget {
  const CashierRootWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CashierRootState>();
    return KeyboardShortcut(
      keyEvent: (event) {
        if (event.isControlPressed && event.logicalKey == LogicalKeyboardKey.keyN) {
          AppState().cashierState.newTabCashier();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: VerticalMenu<int>(
        menus: state.cashierItems
            .map((e) => VerticalMenuItem(
                  title: '#${e.id}',
                  id: e.id,
                  closable: true,
                  vertical: true,
                  onCloseClicked: () {
                    if (state.cashierItems.length > 1) {
                      state.closeTab(e.id);
                    }
                  },
                  widget: (ctx) {
                    return ChangeNotifierProvider<CartState>.value(
                      value: e,
                      child: const CartWidget(),
                    );
                  },
                ))
            .toList(),
        currentId: state.currentCashierTabId,
        onChanged: (p0) {
          state.setCurrentTab(p0);
        },
      ),
    );
  }
}
