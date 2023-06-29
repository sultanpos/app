import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/model/cart.dart';
import 'package:sultanpos/state/cart.dart';
import 'package:sultanpos/ui/cashier/payment.dart';
import 'package:sultanpos/ui/theme.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/dialogutil.dart';
import 'package:sultanpos/ui/widget/keyshortcut.dart';
import 'package:sultanpos/ui/widget/space.dart';
import 'package:sultanpos/util/format.dart';
import 'package:tinycolor2/tinycolor2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final FocusNode _barcodeFN = FocusNode();
  final TextEditingController _barcodeCtrl = TextEditingController();

  @override
  void dispose() {
    _barcodeFN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CartState>();
    return KeyboardShortcut(
      keyEvent: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.f1)) {
          _barcodeFN.requestFocus();
        } else if (event.isKeyPressed(LogicalKeyboardKey.f5)) {
          pay(state);
        }
        return KeyEventResult.ignored;
      },
      child: Padding(
        padding: EdgeInsets.all(STheme().padding * 2),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: double.infinity,
                padding: EdgeInsets.all(STheme().padding),
                decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      focusNode: _barcodeFN,
                      controller: _barcodeCtrl,
                      autofocus: true,
                      decoration: const InputDecoration(hintText: "Scan barcode"),
                      onFieldSubmitted: (value) {
                        if (!state.loadingProduct) {
                          try {
                            state.scanBarcode(value);
                            _barcodeCtrl.text = "";
                            _barcodeFN.requestFocus();
                          } catch (e) {}
                        }
                      },
                    ),
                    // const Divider(),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        /*decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          //color: Theme.of(context).secondaryHeaderColor,
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                        ),*/
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return CartItem(
                                item: state.cartModel.itemAt(index),
                                selected: index == 0,
                              );
                            },
                            separatorBuilder: (context, index) => const Divider(
                                  height: 0,
                                ),
                            itemCount: state.cartModel.itemLength()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SHSpace(),
            Container(
              width: 350,
              height: double.infinity,
              padding: EdgeInsets.all(STheme().padding),
              decoration: BoxDecoration(
                color: Theme.of(context).secondaryHeaderColor,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Total"),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      formatMoney(state.cartModel.total()),
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  const Divider(),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: SButton(
                      icon: const Icon(FontAwesomeIcons.moneyBill1),
                      label: "Bayar",
                      onPressed: () {
                        pay(state);
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  pay(CartState state) async {
    sShowDialog(
      context: context,
      builder: (c) {
        return ChangeNotifierProvider.value(value: state, child: const AddPaymentWidget());
      },
    );
  }
}

class CartItem extends StatefulWidget {
  final ICartItem item;
  final bool selected;
  const CartItem({super.key, required this.item, required this.selected});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    final multiplier = widget.selected ? 1.5 : 1.0;
    final TextStyle medium = Theme.of(context).textTheme.bodyMedium!;
    final TextStyle titleMed = Theme.of(context).textTheme.titleMedium!;
    final Color initialColor = Theme.of(context).secondaryHeaderColor;
    return InkWell(
      onHover: (value) {
        setState(() {
          hovered = value;
        });
      },
      onTap: () {},
      child: Container(
        color: hovered || widget.selected ? TinyColor.fromColor(initialColor).brighten(4).color : initialColor,
        padding: const EdgeInsets.all(8),
        child: Stack(
          children: [
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.name(),
                    style: titleMed.copyWith(fontSize: (titleMed.fontSize ?? 16) * multiplier),
                  ),
                  const SVSpaceSmall(),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.barcode,
                        size: 14.0 * multiplier,
                      ),
                      const SHSpaceSmall(),
                      Text(
                        widget.item.barcode(),
                        style: medium.copyWith(fontSize: (medium.fontSize ?? 14) * multiplier),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            '${formatStock(widget.item.amount())} ${widget.item.unit()} x ${formatMoney(widget.item.price())}'),
                      ],
                    ),
                    const SVSpaceSmall(),
                    Text(
                      formatMoney(widget.item.total()),
                      style: titleMed.copyWith(fontSize: (titleMed.fontSize ?? 16) * multiplier),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
