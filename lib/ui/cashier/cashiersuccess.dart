import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/cart.dart';
import 'package:sultanpos/ui/widget/basewindow.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/labelfield.dart';
import 'package:sultanpos/ui/widget/showerror.dart';
import 'package:sultanpos/ui/widget/space.dart';
import 'package:sultanpos/util/format.dart';

class CashierSuccessWidget extends StatelessWidget {
  const CashierSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<CartState>();
    return BaseWindowWidget(
      height: 400,
      icon: FontAwesomeIcons.checkDouble,
      title: 'Sukses',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LabelField("Total belanja"),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              formatMoney(state.cartModel.getTotal()),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
            ),
          ),
          const LabelField("Pembayaran"),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              formatMoney(state.cartModel.getPayment()),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
            ),
          ),
          const LabelField("Kembalian"),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              formatMoney(state.cartModel.getChange()),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 32),
            ),
          ),
          const Spacer(),
          SButton(
            width: double.infinity,
            positive: false,
            autofocus: true,
            shortCut: const [LogicalKeyboardKey.enter],
            onPressed: () {
              Navigator.pop(context, false);
            },
            label: 'Tutup',
          ),
          const SVSpaceSmall(),
          SButton(
            width: double.infinity,
            shortCut: const [LogicalKeyboardKey.f5],
            onPressed: () async {
              try {
                await AppState().printer.printSale(state.lastSale);
              } catch (e) {
                // ignore: use_build_context_synchronously
                showError(context, message: e.toString());
              }
            },
            label: 'Print',
          ),
        ],
      ),
    );
  }
}
