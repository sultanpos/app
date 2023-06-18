import 'package:sultanpos/model/purchase.dart';
import 'package:sultanpos/repository/repository.dart';
import 'package:sultanpos/repository/rest/restrepository.dart';

class RestPurchaseItemRepo extends BaseRestCRUDRepository<PurchaseItemModel> {
  final int purchaseId;
  RestPurchaseItemRepo({required this.purchaseId, required super.httpApi})
      : super(path: '/purchase/$purchaseId/item', creator: PurchaseItemModel.fromJson);
}

class RestPurchaseRepo extends BaseRestCRUDRepository<PurchaseModel> implements PurchaseRepository {
  RestPurchaseRepo({required super.httpApi}) : super(path: '/purchase', creator: PurchaseModel.fromJson);

  @override
  BaseCRUDRepository<PurchaseItemModel> createItemRepository(int purchaseId) {
    return RestPurchaseItemRepo(purchaseId: purchaseId, httpApi: httpApi);
  }

  @override
  updateStockStatus(int purchaseId, PurchaseUpdateStockStatusModel newStatus) async {
    return httpApi.put(newStatus, '/purchase/$purchaseId/stockstatus');
  }

  @override
  updateStatus(int purchaseId, PurchaseUpdateStatusModel newStatus) async {
    return httpApi.put(newStatus, '/purchase/$purchaseId/status');
  }
}
