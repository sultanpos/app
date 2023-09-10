import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/cart.dart';
import 'package:sultanpos/ui/util/textformatter.dart';
import 'package:sultanpos/ui/widget/basewindow.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/labelfield.dart';
import 'package:sultanpos/ui/widget/showerror.dart';
import 'package:sultanpos/ui/widget/space.dart';
import 'package:sultanpos/util/format.dart';

class AddPaymentWidget extends StatefulWidget {
  const AddPaymentWidget({super.key});

  @override
  State<AddPaymentWidget> createState() => _AddPaymentWidgetState();
}

class _AddPaymentWidgetState extends State<AddPaymentWidget> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _saveEnabled = true;

  @override
  void initState() {
    final state = context.read<CartState>();
    _controller.text = formatMoney(state.cartModel.getTotal());
    _controller.selection = TextSelection(baseOffset: 0, extentOffset: _controller.text.length);
    _controller.addListener(() {
      final money = moneyValue(_controller.text);
      setState(() {
        _saveEnabled = money >= state.cartModel.getTotal();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<CartState>();
    return BaseWindowWidget(
      height: 400,
      icon: FontAwesomeIcons.moneyBill1,
      title: 'Pembayaran',
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
          const SVSpace(),
          const LabelField("Pembayaran"),
          TextField(
            autofocus: true,
            focusNode: _focusNode,
            inputFormatters: [MoneyTextFormatter()],
            controller: _controller,
            textAlign: TextAlign.right,
            onSubmitted: (value) {
              save(state, true);
            },
          ),
          const Spacer(),
          SButton(
            width: double.infinity,
            shortCut: const [LogicalKeyboardKey.f5],
            onPressed: _saveEnabled
                ? () {
                    save(state, true);
                  }
                : null,
            label: 'Simpan dan Print',
          ),
          const SVSpaceSmall(),
          SButton(
            shortCut: const [LogicalKeyboardKey.f6],
            width: double.infinity,
            onPressed: _saveEnabled
                ? () {
                    save(state, false);
                  }
                : null,
            label: 'Simpan',
          ),
          const SVSpaceSmall(),
          SButton(
            width: double.infinity,
            positive: false,
            shortCut: const [LogicalKeyboardKey.escape],
            onPressed: () {
              Navigator.pop(context, false);
            },
            label: 'Batal',
          ),
        ],
      ),
    );
  }

  save(CartState state, bool print) async {
    int saleId = 0;
    if (!_saveEnabled) {
      _focusNode.requestFocus();
      return;
    }
    try {
      final result = await state.paySimple(moneyValue(_controller.text));
      saleId = result.id;
      // ignore: use_build_context_synchronously
      Navigator.pop(context, true);
    } catch (e) {
      // ignore: use_build_context_synchronously
      showError(context, message: e.toString());
    }
    if (print && saleId > 0) {
      try {
        await AppState().printer.printSale(saleId);
      } catch (e) {
        // ignore: use_build_context_synchronously
        showError(context, message: e.toString());
      }
    }
  }
}
