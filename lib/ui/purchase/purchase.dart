import 'package:flutter/material.dart';

class PurchaseWidget extends StatelessWidget {
  const PurchaseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotatedBox(quarterTurns: 3, child: Text('PEMBELIAN PAGE')),
    );
  }
}
