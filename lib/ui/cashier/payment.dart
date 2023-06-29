import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/state/cart.dart';
import 'package:sultanpos/ui/util/textformatter.dart';
import 'package:sultanpos/ui/widget/basewindow.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/labelfield.dart';
import 'package:sultanpos/ui/widget/space.dart';
import 'package:sultanpos/util/format.dart';

class AddPaymentWidget extends StatefulWidget {
  const AddPaymentWidget({super.key});

  @override
  State<AddPaymentWidget> createState() => _AddPaymentWidgetState();
}

class _AddPaymentWidgetState extends State<AddPaymentWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _saveEnabled = true;

  @override
  void initState() {
    final state = context.read<CartState>();
    _controller.text = formatMoney(state.cartModel.total());
    _controller.selection = TextSelection(baseOffset: 0, extentOffset: _controller.text.length);
    _controller.addListener(() {
      final money = moneyValue(_controller.text);
      setState(() {
        _saveEnabled = money >= state.cartModel.total();
      });
    });
    super.initState();
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
              formatMoney(state.cartModel.total()),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
            ),
          ),
          const SVSpace(),
          const LabelField("Pembayaran"),
          TextField(
            autofocus: true,
            inputFormatters: [MoneyTextFormatter()],
            controller: _controller,
            textAlign: TextAlign.right,
          ),
          const Spacer(),
          SButton(
            width: double.infinity,
            onPressed: _saveEnabled ? () {} : null,
            label: 'Simpan dan Print',
          ),
          const SVSpaceSmall(),
          SButton(
            width: double.infinity,
            onPressed: _saveEnabled ? () {} : null,
            label: 'Simpan',
          ),
          const SVSpaceSmall(),
          SButton(
            width: double.infinity,
            positive: false,
            onPressed: () {},
            label: 'Batal',
          ),
        ],
      ),
    );
  }
}
