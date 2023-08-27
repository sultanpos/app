import 'package:flutter/material.dart';
import 'package:sultanpos/http/httpapi.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/sync/local/database.dart';

abstract class SyncUpItemDoneListener {
  void syncDone(String tableName);
}

class SyncUpItem<T extends LocalSqlBase> {
  IHttpAPI httpAPI;
  ISqliteDatabase db;
  T base;
  int? lastId;
  DateTime? lastDate;
  bool _running = false;
  T? lastData;
  final T Function(Map<String, dynamic> json) sqliteCreator;
  final SyncUpItemDoneListener? listener;
  SyncUpItem(this.httpAPI, this.db, this.base, this.sqliteCreator, this.listener);

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
        if (jsonData == null) continue;
        final data = await httpAPI.syncUp(item.getTableName(), jsonData);
        afterSync(item, data);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    listener?.syncDone(name());
  }

  Future<Map<String, dynamic>?> buildData(T item) async {
    return item.toJson();
  }

  afterSync(T item, Map<String, dynamic> data) async {
    await db.updateById(item.getTableName(), item.getId(), {"sync_at": DateTime.now().toIso8601String()});
  }
}
