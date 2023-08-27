import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sultanpos/http/httpapi.dart';
import 'package:sultanpos/http/websocket/message.pb.dart';
import 'package:sultanpos/http/websocket/websocket.dart';
import 'package:sultanpos/model/cashier.dart';
import 'package:sultanpos/model/category.dart';
import 'package:sultanpos/model/payment.dart';
import 'package:sultanpos/model/sale.dart';
import 'package:sultanpos/sync/local/database.dart';
import 'package:sultanpos/sync/sync.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

import 'sync_test.mocks.dart';

@GenerateMocks([IHttpAPI, IWebSocketTransport])
void main() async {
  sqfliteFfiInit();

  test(
    'sync_category',
    () async {
      final sync = Sync();
      final httpApi = MockIHttpAPI();
      final wsTransport = MockIWebSocketTransport();
      final db = SqliteDatabase(123, inMemory: true);
      final Map<String, List<CategoryModel>> datas = {};
      StreamController<Message> streamController = StreamController<Message>.broadcast();

      when(wsTransport.listen(any,
              onDone: anyNamed('onDone'), onError: anyNamed('onError'), cancelOnError: anyNamed('cancelOnError')))
          .thenAnswer(
        (invoke) {
          return streamController.stream.listen(invoke.positionalArguments[0], onDone: invoke.namedArguments["onDone"]);
        },
      );

      when(httpApi.querySync(any, any, any)).thenAnswer((invoke) async {
        final table = invoke.positionalArguments[0];
        if (datas.containsKey(table)) {
          return Response(
              requestOptions: RequestOptions(), data: {"data": datas[table]!.map((e) => e.toJson()).toList()});
        }
        return Response(requestOptions: RequestOptions(), data: {"data": []});
      });
      //await expectLater(await db.open(), returnsNormally);
      await db.open();
      sync.init(httpApi, db, wsTransport);
      final dt = DateTime(2020);
      datas["category"] = [];
      for (int i = 0; i < 100; i++) {
        datas["category"]!.add(
            CategoryModel(i + 1, dt.add(Duration(days: i)), null, 'name $i', 'code $i', 'description $i', 0, i == 0));
      }
      sync.start();
      await Future.delayed(const Duration(seconds: 1));
      final last = await db.getLastData<CategoryModel>(CategoryModel.empty(), CategoryModel.fromSqlite);
      expect(last != null, true);
      expect(last!.id, 100);
      expect(last.isDefault, false);
      final id0 = await db.getById<CategoryModel>("category", 1, CategoryModel.fromSqlite);
      expect(id0 != null, true);
      expect(id0!.isDefault, true);

      datas["category"]!.clear();
      final updated50 = CategoryModel(50, dt.add(const Duration(days: 200)), dt.add(const Duration(days: 200)),
          'update name', 'update code', 'update description', 0, false);
      datas["category"]!.add(updated50);
      final recordUpdated = RecordUpdated()..name = "category";
      streamController.add(Message()..recordUpdated = recordUpdated);
      await Future.delayed(const Duration(seconds: 1));
      final id50 = await db.getLastData<CategoryModel>(CategoryModel.empty(), CategoryModel.fromSqlite);
      expect(id50 != null, true);
      expect(id50!.id, 50);
      expect(id50.isDefault, false);
      expect(id50.deletedAt, dt.add(const Duration(days: 200)));
      expect(id50.updatedAt, dt.add(const Duration(days: 200)));
      expect(id50.name, updated50.name);
    },
  );

  test('sync up', () async {
    final sync = Sync();
    final httpApi = MockIHttpAPI();
    final wsTransport = MockIWebSocketTransport();
    final db = SqliteDatabase(456, inMemory: true);
    Map<String, dynamic>? data;
    StreamController<Message> streamController = StreamController<Message>.broadcast();

    when(wsTransport.listen(any,
            onDone: anyNamed('onDone'), onError: anyNamed('onError'), cancelOnError: anyNamed('cancelOnError')))
        .thenAnswer(
      (invoke) {
        return streamController.stream.listen(invoke.positionalArguments[0], onDone: invoke.namedArguments["onDone"]);
      },
    );

    when(httpApi.querySync(any, any, any)).thenAnswer((invoke) async {
      return Response(requestOptions: RequestOptions(), data: {"data": []});
    });

    when(httpApi.syncUp(any, any)).thenAnswer((invoke) async {
      final tableName = invoke.positionalArguments[0];
      if (tableName == "cashiersession" || tableName == "payment" || tableName == "sale") {
        data = invoke.positionalArguments[1];
        return {'status': true};
      }
      throw 'error happens';
    });

    expect(await db.open(), null);
    sync.init(httpApi, db, wsTransport);
    sync.start();

    final cashierSess = CashierSessionModel(0, DateTime.now(), null, 1, const Uuid().v4().toString(), DateTime.now(),
        null, 1, 150000, 0, 0, 0, '', null, null);
    expect(await db.insert(cashierSess), greaterThan(0));
    sync.syncUp("cashiersession");
    await Future.delayed(const Duration(milliseconds: 100));
    expect(data, isNotNull);
    expect(data?.length, greaterThan(0));
    final res = await db.getById('cashiersession', 1, CashierSessionModel.fromSqlite);
    expect(res?.syncAt, isNotNull);

    // payment test
    data = null;
    final payment = PaymentModel(0, DateTime.now(), 'payment001', const Uuid().v4().toString(), 1, PaymentType.typeIn,
        PaymentRefer.other, 0, 10000, 10000, 'note', 0, 1, null, null);
    expect(await db.insert(payment), greaterThan(0));
    sync.syncUp("payment");
    await Future.delayed(const Duration(milliseconds: 100));
    expect(data, isNotNull);
    expect(data?.length, greaterThan(0));
    final resPayment = await db.getById('payment', 1, PaymentModel.fromSqlite);
    expect(resPayment?.syncAt, isNotNull);

    // sale test
    final sale = SaleModel(
        0,
        const Uuid().v4().toString(),
        DateTime.now(),
        1,
        1,
        const Uuid().v4().toString(),
        SaleType.cashier,
        SaleStatus.done,
        SaleStockStatus.received,
        1,
        10000,
        '',
        0,
        10000,
        0,
        10000,
        null,
        1,
        1,
        null,
        null,
        null);
    expect(await db.insert(sale), greaterThan(0));
    final payment2 = PaymentModel(0, DateTime.now(), const Uuid().v4().toString(), const Uuid().v4().toString(), 1,
        PaymentType.typeIn, PaymentRefer.sale, 1, 10000, 10000, 'note', 0, 1, null, DateTime.now());
    expect(await db.insert(payment2), greaterThan(0));
    final items = [
      SaleItemModel(0, 1, 1, 1, 5, 500, 1000, 5000, '', 0, 5000, '', null),
      SaleItemModel(0, 1, 2, 1, 5, 500, 1000, 5000, '', 0, 5000, '', null),
      // this is another items
      SaleItemModel(0, 100, 1, 1, 5, 500, 1000, 5000, '', 0, 5000, '', null),
      SaleItemModel(0, 100, 2, 1, 5, 500, 1000, 5000, '', 0, 5000, '', null),
    ];
    for (final item in items) {
      expect(await db.insert(item), greaterThan(0));
    }
    data = null;
    sync.syncUp("sale");
    await Future.delayed(const Duration(milliseconds: 100));
    final resSale = await db.getById('sale', 1, SaleModel.fromSqlite);
    expect(resSale?.syncAt, isNotNull);
    expect(data, isNotNull);
    final paymentArr = data!['payments'] as List;
    expect(paymentArr.length, equals(1));
    final itemArr = data!['items'] as List;
    expect(itemArr.length, equals(2));
  });
}
