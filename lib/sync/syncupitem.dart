import 'package:flutter/material.dart';
import 'package:sultanpos/http/httpapi.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/sync/local/database.dart';

class SyncUpItem<T extends LocalSqlBase> {
  IHttpAPI httpAPI;
  ISqliteDatabase db;
  T base;
  int? lastId;
  DateTime? lastDate;
  bool _running = false;
  T? lastData;
  final T Function(Map<String, dynamic> json) sqliteCreator;
  SyncUpItem(this.httpAPI, this.db, this.base, this.sqliteCreator);

  String name() {
    return base.getTableName();
  }

  start() {
    if (_running) return;
    _running = true;
    _doRun();
  }

  _doRun() async {
    final data = await db.query<T>(
      base.getTableName(),
      creator: sqliteCreator,
      where: "sync_at IS NULL",
      orderBy: "id ASC",
    );
    if (data.isEmpty) {
      _running = false;
      return;
    }
    for (final item in data) {
      try {
        final jsonData = await buildData(item);
        await httpAPI.syncUp(item.getTableName(), jsonData);
        await db.updateById(item.getTableName(), item.getId(), {"sync_at": DateTime.now().toIso8601String()});
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  Future<Map<String, dynamic>> buildData(T item) async {
    return item.toJson();
  }
}
