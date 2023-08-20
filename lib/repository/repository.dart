import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/cashier.dart';
import 'package:sultanpos/model/listresult.dart';
import 'package:sultanpos/model/payment.dart';
import 'package:sultanpos/model/paymentmethod.dart';
import 'package:sultanpos/model/pricegroup.dart';
import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/model/purchase.dart';
import 'package:sultanpos/model/request.dart';
import 'package:sultanpos/model/sale.dart';
import 'package:sultanpos/model/unit.dart';

abstract mixin class BaseCRUDRepository<T extends BaseModel> {
  Future insert(BaseModel data);
  Future update(int id, BaseModel data);
  Future delete(int id);
  Future<T?> get(int id);
  Future<ListResult<T>> query(BaseFilterModel filter);
}

abstract class PurchaseRepository extends BaseCRUDRepository<PurchaseModel> {
  BaseCRUDRepository<PurchaseItemModel> createItemRepository(int purchaseId);
  Future updateStockStatus(int purchaseId, PurchaseUpdateStockStatusModel newStatus);
  Future updateStatus(int purchaseId, PurchaseUpdateStatusModel newStatus);
}

abstract class UnitRepository extends BaseCRUDRepository<UnitModel> {}

abstract class ProductRepository extends BaseCRUDRepository<ProductModel> {}

abstract class CashierSessionRepository extends BaseCRUDRepository<CashierSessionModel> {
  Future<CashierSessionModel> getActive();
  Future<CashierSessionReportModel> getReport(int id);
  Future close(int id, CashierSessionCloseModel data);
}

abstract class PaymentMethodRepository extends BaseCRUDRepository<PaymentMethodModel> {
  Future<PaymentMethodModel> getDefaultCashMethod();
}

abstract class SaleRepository extends BaseCRUDRepository<SaleModel> {
  Future<InsertSuccessModel> insertCashier(SaleCashierInsertModel data);
  Future<ListResult<SaleItemModel>> items(int saleId);
  Future<ListResult<PaymentModel>> payments(int saleId);
}

abstract class PriceGroupRepository extends BaseCRUDRepository<PriceGroupModel> {
  Future<PriceGroupModel?> defaultPriceGroup();
}
