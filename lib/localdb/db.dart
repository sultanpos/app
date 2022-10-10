import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class LocalDb {
  static final LocalDb _singleton = LocalDb._internal();
  factory LocalDb() {
    return _singleton;
  }
  LocalDb._internal();

  init({String name = "sultanpos"}) async {
    /*final dir = await getApplicationSupportDirectory();
    final db = await Isar.open([], directory: dir.path, name: name);*/
  }
}
