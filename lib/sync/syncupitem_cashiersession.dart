import 'package:sultanpos/model/cashier.dart';
import 'package:sultanpos/sync/syncupitem.dart';

class SyncUpItemCashierSession extends SyncUpItem<CashierSessionModel> {
  SyncUpItemCashierSession(
    super.httpAPI,
    super.db,
    super.base,
    super.sqliteCreator,
    super.listener,
  );

  @override
  afterSync(CashierSessionModel item, Map<String, dynamic> data) async {
    await db.updateById(item.getTableName(), item.getId(), {
      "sync_at": DateTime.now().toIso8601String(),
      "server_id": data['id'],
    });
  }
}

class SyncUpItemCashierSessionClose extends SyncUpItem<CashierSessionCloseModel> {
  SyncUpItemCashierSessionClose(
    super.httpAPI,
    super.db,
    super.base,
    super.sqliteCreator,
    super.listener,
  );

  @override
  Future<Map<String, dynamic>?> buildData(CashierSessionCloseModel item) async {
    //check if the cashier session model already synced to master
    final cashierSession = await db.getById('cashiersession', item.cashierSessionId, CashierSessionModel.fromSqlite);
    if (cashierSession == null) return null;
    if (cashierSession.serverId == 0) return null;
    final json = item.toJson();
    json['cashier_session_id'] = cashierSession.serverId;
    return json;
  }
}
