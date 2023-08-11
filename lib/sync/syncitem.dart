import 'package:flutter/material.dart';
import 'package:sultanpos/http/httpapi.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/sync/local/database.dart';

class SyncItem<T extends LocalSqlBase> {
  final int limit = 500;
  HttpAPI httpAPI;
  SqliteDatabase db;
  T base;
  int? lastId;
  DateTime? lastDate;
  bool _running = false;
  T? lastData;
  final T Function(Map<String, dynamic> json) jsonCreator;
  final T Function(Map<String, dynamic> json) sqliteCreator;
  SyncItem(this.httpAPI, this.base, this.db, {required this.jsonCreator, required this.sqliteCreator});

  String name() {
    return base.getTableName();
  }

  Future start() async {
    if (_running) return;
    _running = true;
    lastData = await db.getLastData(base, sqliteCreator);
    _doRun();
  }

  _doRun() async {
    if (!_running) return;
    try {
      final resp = await httpAPI.querySync(base.getTableName(), lastData?.getUpdatedAt() ?? DateTime(2020), limit);
      final arr = (resp.data as Map)["data"] as List;
      for (final item in arr) {
        lastData = jsonCreator(item as Map<String, dynamic>);
        await db.insertOrUpdate(lastData!);
      }
      if (arr.isEmpty || arr.length < limit) {
        _running = false;
        return;
      }
      Future.delayed(const Duration(milliseconds: 1), _doRun);
    } catch (e) {
      debugPrint("############## ERROR");
      debugPrint(e.toString());
    }
  }

  void stop() {}
}
