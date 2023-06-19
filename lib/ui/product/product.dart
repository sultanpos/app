import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/product.dart';
import 'package:sultanpos/state/productroot.dart';
import 'package:sultanpos/ui/product/add.dart';
import 'package:sultanpos/ui/product/productlist.dart';
import 'package:sultanpos/ui/widget/verticalmenu.dart';

class ProductRootWidget extends StatelessWidget {
  const ProductRootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductRootState>();
    return VerticalMenu(
      currentId: state.currentId ?? "list",
      onChanged: (value) => AppState().productRootState.setCurrentId(value),
      width: 60,
      menus: [
        VerticalMenuItem(
          title: 'Daftar',
          id: 'list',
          icon: Icons.list_alt,
          widget: () => const ProductListWidget(),
        ),
        ...state.items
            .map(
              (e) => VerticalMenuItem<String>(
                  title: e.current == null ? "BARU" : "UBAH",
                  id: e.getId(),
                  widget: () => ChangeNotifierProvider<ProductState>.value(
                        value: state.productWidgetWithId(e.getId()),
                        child: const AddProductWidget(title: "Tambah barang baru"),
                      ),
                  vertical: true,
                  closable: true,
                  onCloseClicked: () {
                    state.closeTab(e.getId());
                  }),
            )
            .toList(),
      ],
    );
  }
}
