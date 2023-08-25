import 'dart:async';

import 'package:sultanpos/http/httpapi.dart';
import 'package:sultanpos/http/websocket/message.pbserver.dart';
import 'package:sultanpos/http/websocket/websocket.dart';
import 'package:sultanpos/model/cashier.dart';
import 'package:sultanpos/model/category.dart';
import 'package:sultanpos/model/partner.dart';
import 'package:sultanpos/model/paymentmethod.dart';
import 'package:sultanpos/model/price.dart';
import 'package:sultanpos/model/pricegroup.dart';
import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/model/unit.dart';
import 'package:sultanpos/sync/local/database.dart';

import 'package:sultanpos/sync/syncitem.dart';
import 'package:sultanpos/sync/syncupitem.dart';

class Sync {
  late IHttpAPI httpAPI;
  late ISqliteDatabase db;
  bool _running = false;
  late List<SyncItem> syncItems;
  late List<SyncUpItem> syncUpItems;
  StreamSubscription? _subscription;

  static final Sync _singleton = Sync._internal();

  factory Sync() {
    return _singleton;
  }

  Sync._internal();

  init(IHttpAPI httpAPI, ISqliteDatabase db, IWebSocketTransport wsTransport) {
    this.httpAPI = httpAPI;
    this.db = db;
    syncItems = [
      SyncItem(httpAPI, UnitModel.empty(), db, sqliteCreator: UnitModel.fromSqlite, jsonCreator: UnitModel.fromJson),
      SyncItem(httpAPI, CategoryModel.empty(), db,
          sqliteCreator: CategoryModel.fromSqlite, jsonCreator: CategoryModel.fromJson),
      SyncItem(httpAPI, PartnerModel.empty(), db,
          sqliteCreator: PartnerModel.fromSqlite, jsonCreator: PartnerModel.fromJson),
      SyncItem(httpAPI, PriceGroupModel.empty(), db,
          sqliteCreator: PriceGroupModel.fromSqlite, jsonCreator: PriceGroupModel.fromJson),
      SyncItem(httpAPI, PriceModel.empty(), db, sqliteCreator: PriceModel.fromSqlite, jsonCreator: PriceModel.fromJson),
      SyncItem(httpAPI, ProductModel.empty(), db,
          sqliteCreator: ProductModel.fromSqlite, jsonCreator: ProductModel.fromJson),
      SyncItem(httpAPI, PaymentMethodModel.empty(), db,
          sqliteCreator: PaymentMethodModel.fromSqlite, jsonCreator: PaymentMethodModel.fromJson),
    ];
    syncUpItems = [
      SyncUpItem(httpAPI, db, CashierSessionModel.empty(), CashierSessionModel.fromSqlite),
    ];
    _subscription = wsTransport.listen((Message message) {
      if (message.hasRecordUpdated()) {
        notifySync(message.recordUpdated.name);
      }
    });
  }

  start() {
    if (_running) return;
    _running = true;
    for (final item in syncItems) {
      item.start();
    }
  }

  stop() async {
    await _subscription?.cancel();
    for (final item in syncItems) {
      item.stop();
    }
  }

  notifySync(String name) {
    for (final item in syncItems) {
      if (item.name() == name) {
        item.start();
        break;
      }
    }
  }

  syncUp(String name) {
    for (final item in syncUpItems) {
      if (item.name() == name) {
        item.start();
        break;
      }
    }
  }
}
