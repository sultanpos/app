import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/purchase.dart';

class LocalFileDb {
  static final LocalFileDb _singleton = LocalFileDb._internal();
  factory LocalFileDb() {
    return _singleton;
  }
  LocalFileDb._internal();

  late LocalFileDbSimpleOperation<PurchaseModel> purchase;
  init({String? path}) async {
    final dir = await getApplicationSupportDirectory();
    purchase = LocalFileDbSimpleOperation('${dir.path}/purchase.json', PurchaseModel.fromJson);
  }
}

class LocalFileDbSimpleOperation<T extends BaseModel?> {
  final String path;
  Map<String, T> allDatas = {};
  final T Function(Map<String, dynamic> json) creator;
  bool _loaded = false;
  LocalFileDbSimpleOperation(this.path, this.creator);

  _storeToFile() async {
    final file = File(path);
    final jsonString = jsonEncode(allDatas);
    file.writeAsString(jsonString);
  }

  _loadAll() async {
    if (_loaded) return;
    _loaded = true;
    final file = File(path);
    if (await file.exists()) {
      final stringValue = await file.readAsString();
      final jsonValue = Map<String, dynamic>.from(jsonDecode(stringValue) as Map);
      jsonValue.forEach((key, value) {
        allDatas[key] = creator(value as Map<String, dynamic>);
      });
    }
  }

  Future<void> save(T model) {
    allDatas['${model!.getId()}'] = model;
    return _storeToFile();
  }

  Future<void> deleteById(int id) async {
    if (allDatas.containsKey('$id')) {
      allDatas.remove('$id');
      await _storeToFile();
    }
  }

  Future<List<T>> getAll() async {
    await _loadAll();
    final List<T> retVal = [];
    allDatas.forEach((key, value) {
      retVal.add(value);
    });
    return retVal;
  }

  Future<T?> getById(String id) async {
    await _loadAll();
    if (allDatas.containsKey(id)) {
      return allDatas[id];
    }
    return null;
  }
}
