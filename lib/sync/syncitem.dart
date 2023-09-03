import 'package:flutter/material.dart';
import 'package:sultanpos/http/httpapi.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/state/global.dart';
import 'package:sultanpos/sync/local/database.dart';

class SyncItem<T extends LocalSqlBase> {
  final int limit = 500;
  IHttpAPI httpAPI;
  ISqliteDatabase db;
  T base;
  int? lastId;
  DateTime? lastDate;
  bool _running = false;
  T? lastData;
  ICurrentApp? currentApp;
  final T Function(Map<String, dynamic> json) jsonCreator;
  final T Function(Map<String, dynamic> json) sqliteCreator;
  SyncItem(this.httpAPI, this.base, this.db, {required this.jsonCreator, required this.sqliteCreator, this.currentApp});

  String name() {
    return base.getTableName();
  }

  Future start() async {
    if (_running) return;
    _running = true;
    lastData = await getLastData();
    _doRun();
  }

  Future<T?> getLastData() async {
    if (base.syncUseBranch()) {
      if (currentApp == null) {
        debugPrint('error current app is null');
        throw 'current app is null';
      }
      return db.first(
        base.getTableName(),
        creator: sqliteCreator,
        orderBy: "updated_at DESC, id DESC",
        where: "branch_id = ?",
        whereArgs: [currentApp!.currentBranchId()],
      );
    }
    return db.first(
      base.getTableName(),
      creator: sqliteCreator,
      orderBy: "updated_at DESC, id DESC",
    );
  }

  _doRun() async {
    if (!_running) return;
    try {
      final params = <String, dynamic>{'limit': limit};
      if (base.syncUseBranch() && currentApp != null) params['branch_id'] = currentApp!.currentBranchId();
      final resp = await httpAPI.querySync(
        base.getTableName(),
        lastData?.getUpdatedAt() ?? DateTime(2020),
        params,
      );
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
      debugPrint("############## ERROR SYNC: ${name()}");
      debugPrint(e.toString());
    }
  }

  void stop() {}
}
