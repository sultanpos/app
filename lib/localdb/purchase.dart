import 'package:isar/isar.dart';
import 'package:sultanpos/model/purchase.dart';

abstract class PurchaseLocalInterface {
  save(PurchaseModel data);
  delete(Id id);
  PurchaseModel? getByPublicId(String publicId);
  Future<List<PurchaseModel>> getAll();
}

class PurchaseIsarImpl extends PurchaseLocalInterface {
  final Isar db;
  PurchaseIsarImpl(this.db);

  @override
  save(PurchaseModel data) {
    return db.writeTxn(() async => await db.purchaseModels.put(data));
  }

  @override
  delete(Id id) {
    db.writeTxn(() async => await db.purchaseModels.delete(id));
  }

  @override
  Future<List<PurchaseModel>> getAll() {
    return db.purchaseModels.filter().idGreaterThan(0).findAll();
  }

  @override
  PurchaseModel? getByPublicId(String publicId) {
    return db.purchaseModels.filter().publicIdEqualTo(publicId).findFirstSync();
  }
}
