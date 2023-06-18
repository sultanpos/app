import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/listresult.dart';
import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/model/purchase.dart';

abstract mixin class BaseCRUDRepository<T extends BaseModel> {
  Future insert(BaseModel data);
  Future update(int id, BaseModel data);
  Future delete(int id);
  Future<T> get(int id);
  Future<ListResult<T>> query(BaseFilterModel filter);
}

abstract class PurchaseRepository extends BaseCRUDRepository<PurchaseModel> {
  BaseCRUDRepository<PurchaseItemModel> createItemRepository(int purchaseId);
  Future updateStockStatus(int purchaseId, PurchaseUpdateStockStatusModel newStatus);
  Future updateStatus(int purchaseId, PurchaseUpdateStatusModel newStatus);
}

abstract class ProductRepository extends BaseCRUDRepository<ProductModel> {}
