import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sultanpos/localdb/purchase.dart';
import 'package:sultanpos/model/purchase.dart';

class LocalDb {
  static final LocalDb _singleton = LocalDb._internal();
  factory LocalDb() {
    return _singleton;
  }
  LocalDb._internal();

  late PurchaseLocalInterface purchase;

  init({String name = "sultanpos"}) async {
    final dir = await getApplicationSupportDirectory();
    final db = await Isar.open([PurchaseModelSchema], directory: dir.path, name: name);
    purchase = PurchaseIsarImpl(db);
  }
}
