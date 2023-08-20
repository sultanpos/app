import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/listresult.dart';
import 'package:sultanpos/model/price.dart';
import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/model/unit.dart';
import 'package:sultanpos/repository/local/sqliterepository.dart';
import 'package:sultanpos/repository/repository.dart';
import 'package:sultanpos/sync/local/database.dart';

class SqliteProductRepository extends BaseSqliteRepository<ProductModel> implements ProductRepository {
  SqliteProductRepository({required ISqliteDatabase db})
      : super(tableName: "product", sqliteDb: db, creator: ProductModel.fromSqlite);

  @override
  Future<ListResult<ProductModel>> query(BaseFilterModel filter) async {
    final where = buildWhere(filter);
    var result = await sqliteDb.query(tableName,
        creator: creator, limit: filter.limit, offset: filter.offset, where: where.where, whereArgs: where.whereArgs);
    final productIds = result.map((e) => e.id).toList();
    final prices = await sqliteDb.query("price",
        creator: PriceModel.fromSqlite,
        where: "product_id IN (${productIds.map((_) => '?').join(', ')})",
        whereArgs: productIds);
    final unitIds = result.map((e) => e.unitId).toList();
    final units = await sqliteDb.query(
      "unit",
      creator: UnitModel.fromSqlite,
      where: "id IN (${unitIds.map((_) => '?').join(', ')})",
      whereArgs: unitIds,
    );
    return ListResult(
        result
            .map<ProductModel>(
              (e) => e.copyWith(
                prices: prices.where((element) => element.productId == e.id).toList(),
                unit: units.firstWhere((element) => element.id == e.unitId),
              ),
            )
            .toList(),
        result.length);
  }
}
