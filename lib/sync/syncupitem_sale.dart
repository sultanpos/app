import 'package:sultanpos/model/payment.dart';
import 'package:sultanpos/model/sale.dart';
import 'package:sultanpos/sync/syncupitem.dart';

class SyncUpItemSale extends SyncUpItem<SaleModel> {
  SyncUpItemSale(
    super.httpAPI,
    super.db,
    super.base,
    super.sqliteCreator,
  );

  @override
  Future<Map<String, dynamic>> buildData(SaleModel item) async {
    final items = await db.query<SaleItemModel>('saleitem',
        creator: SaleItemModel.fromSqlite, where: "sale_id = ?", whereArgs: [item.id]);
    final payments = await db.query<PaymentModel>('payment',
        creator: PaymentModel.fromSqlite,
        where: "type = 'in' AND refer = 'sale' AND refer_id = ?",
        whereArgs: [item.id]);
    final jsonData = item.toJson();
    jsonData["items"] = items.map((e) => e.toJson()).toList();
    jsonData["payments"] = payments.map((e) => e.toJson()).toList();
    return jsonData;
  }
}
