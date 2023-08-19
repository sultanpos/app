import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/model/cart.dart';
import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/cart.dart';
import 'package:sultanpos/ui/cashier/cashiersuccess.dart';
import 'package:sultanpos/ui/cashier/closesession.dart';
import 'package:sultanpos/ui/cashier/payment.dart';
import 'package:sultanpos/ui/cashier/sessionclosed.dart';
import 'package:sultanpos/ui/theme.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/confirmation.dart';
import 'package:sultanpos/ui/widget/dialogutil.dart';
import 'package:sultanpos/ui/widget/keyshortcut.dart';
import 'package:sultanpos/ui/widget/showerror.dart';
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
  final FocusNode _cartFN = FocusNode();
  final TextEditingController _barcodeCtrl = TextEditingController();

  @override
  void dispose() {
    _barcodeFN.dispose();
    _cartFN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CartState>();
    return KeyboardShortcut(
      keyEvent: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.f1)) {
          _barcodeFN.requestFocus();
          return KeyEventResult.handled;
        } else if (event.isKeyPressed(LogicalKeyboardKey.f4)) {
          _cartFN.requestFocus();
          return KeyEventResult.handled;
        } else if (event.isKeyPressed(LogicalKeyboardKey.f5)) {
          pay(state);
          return KeyEventResult.handled;
        } else if (event.isKeyPressed(LogicalKeyboardKey.delete) && event.isControlPressed) {
          resetCart();
          return KeyEventResult.handled;
        } else {
          if (_cartFN.hasFocus) {
            if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
              state.nextItem();
              return KeyEventResult.handled;
            } else if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
              state.prevItem();
              return KeyEventResult.handled;
            } else if (event.isKeyPressed(LogicalKeyboardKey.delete)) {
              removeItem();
              return KeyEventResult.handled;
            }
          }
        }
        return KeyEventResult.ignored;
      },
      child: Padding(
        padding: EdgeInsets.all(STheme().padding * 2),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
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
                          onFieldSubmitted: (value) async {
                            if (!state.loadingProduct) {
                              final result = await state.scanBarcode(value);
                              if (!result.found) {
                                if (result.error != null) {
                                  // ignore: use_build_context_synchronously
                                  showError(context, message: result.error!);
                                } else {
                                  // ignore: use_build_context_synchronously
                                  showError(context, message: "Barang tidak diketemukan");
                                }
                              }
                              _barcodeCtrl.selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: _barcodeCtrl.text.length,
                              );
                              _barcodeFN.requestFocus();
                            }
                          },
                        ),
                        if (state.currentProduct != null)
                          ProductScanWidget(
                            product: state.currentProduct!,
                          ),
                      ],
                    ),
                  ),
                  const SVSpace(),
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
                          // const Divider(),

                          Expanded(
                            child: Focus(
                              focusNode: _cartFN,
                              canRequestFocus: true,
                              child: Container(
                                //padding: const EdgeInsets.all(8),
                                decoration: _cartFN.hasFocus
                                    ? BoxDecoration(
                                        border: Border.all(color: Colors.blue),
                                        //color: Theme.of(context).secondaryHeaderColor,
                                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                                      )
                                    : null,
                                child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      return CartItem(
                                        item: state.cartModel.itemAt(index),
                                        selected: index == state.curIndex,
                                      );
                                    },
                                    separatorBuilder: (context, index) => const Divider(
                                          height: 0,
                                        ),
                                    itemCount: state.cartModel.itemLength()),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SHSpace(),
            SizedBox(
              width: 350,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
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
                              formatMoney(state.cartModel.getTotal()),
                              style: const TextStyle(fontSize: 42),
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
                  ),
                  const SVSpace(),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(STheme().padding),
                    decoration: BoxDecoration(
                      color: Theme.of(context).secondaryHeaderColor,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: SButton(
                      icon: const Icon(Icons.logout),
                      color: Colors.red,
                      label: "Tutup kasir",
                      onPressed: () async {
                        AppState().cashierState.loadReport();
                        final result = await sShowDialog(
                          context: context,
                          builder: (c) {
                            return ChangeNotifierProvider.value(
                              value: AppState().cashierState,
                              child: const CashierSessionCloseWidget(),
                            );
                          },
                        );
                        if (result != null && result) {
                          // ignore: use_build_context_synchronously
                          await sShowDialog(
                            context: context,
                            builder: (c) {
                              return ChangeNotifierProvider.value(
                                value: AppState().cashierState,
                                child: const CashierSessionClosedWidget(),
                              );
                            },
                          );
                          AppState().cashierState.reset();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  pay(CartState state) async {
    if (state.cartModel.isEmpty()) return;
    final result = await sShowDialog<bool>(
      context: context,
      builder: (c) {
        return ChangeNotifierProvider.value(value: state, child: const AddPaymentWidget());
      },
    );
    if (result != null && result) {
      // ignore: use_build_context_synchronously
      await sShowDialog<bool>(
        context: context,
        builder: (c) {
          return ChangeNotifierProvider.value(value: state, child: const CashierSuccessWidget());
        },
      );
      state.reset();
    }
  }

  resetCart() async {
    bool value = await showConfirmation(context, title: 'Konfirmasi', message: 'Yakin untuk mereset belanja?');
    if (value) {
      // ignore: use_build_context_synchronously
      final state = context.read<CartState>();
      state.reset();
    }
  }

  removeItem() async {
    bool value = await showConfirmation(context, title: "Konfirmasi", message: "Yakin menghapus item?");
    if (value) {
      // ignore: use_build_context_synchronously
      final state = context.read<CartState>();
      state.removeItem();
    }
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
    const multiplier = 1.0;
    //widget.selected ? 1.5 : 1.0;
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
                      const Icon(
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

class ProductScanWidget extends StatelessWidget {
  final ProductModel product;
  const ProductScanWidget({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final priceList = product.priceList();
    return Padding(
      padding: EdgeInsets.only(top: STheme().padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: const TextStyle(fontSize: 16),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: priceList
                .map((e) => Text('${formatStock(e.$1)} ${product.unit?.name ?? ''} @${formatMoney(e.$2)}'))
                .toList(),
          )
        ],
      ),
    );
  }
}
