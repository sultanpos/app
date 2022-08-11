import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/ui/widget/datatable.dart';

class ProductRootWidget extends StatelessWidget {
  const ProductRootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AppState().productState,
      child: Builder(builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Daftar Barang',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Expanded(child: SizedBox()),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Tambah Barang'),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: SDataTable<ProductModel>(columns: [], name: 'product', state: AppState().productState.listData),
              ),
            ],
          ),
        );
      }),
    );
  }
}
