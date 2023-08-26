import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/sync/local/migration.dart';

abstract class ISqliteDatabase {
  Future open();
  Future insertOrUpdate<T extends LocalSqlBase>(T data);
  Future insert<T extends LocalSqlBase>(T data);
  Future<T?> getLastData<T extends LocalSqlBase>(T data, T Function(Map<String, dynamic> json) creator);
  Future<T?> getById<T extends LocalSqlBase>(String table, int id, T Function(Map<String, dynamic> json) creator);
  Future<List<T>> query<T extends LocalSqlBase>(String table,
      {String? where,
      List<Object?>? whereArgs,
      int offset = 0,
      int limit = 100,
      String? orderBy,
      required T Function(Map<String, dynamic> json) creator});
  Future updateById(String table, int id, Map<String, Object?> data);
}

class SqliteDatabase implements ISqliteDatabase {
  final int companyId;
  late Database db;
  final bool _inMemory;

  SqliteDatabase(this.companyId, {bool inMemory = false}) : _inMemory = inMemory;

  @override
  Future open() async {
    final dbOptions = OpenDatabaseOptions(
      version: 1, //adding this make sure to add SqliteMigration.migrationScripts
      onCreate: (localDB, version) async {
        await _migrate(localDB, 0);
      },
      onUpgrade: (localDB, oldVersion, newVersion) async {
        await _migrate(localDB, oldVersion);
      },
    );
    if (_inMemory) {
      db = await databaseFactoryFfi.openDatabase(
        inMemoryDatabasePath,
        options: dbOptions,
      );
    } else {
      final path = await _getPath();
      final databasePath = '$path/sultanpos_$companyId.db';
      debugPrint('database path: $databasePath');
      db = await databaseFactoryFfi.openDatabase(
        databasePath,
        options: dbOptions,
      );
    }
  }

  _migrate(Database localDB, int version) async {
    final lists = SqliteMigration.migrationScripts;
    for (var i = version; i < lists.length; i++) {
      for (final sql in lists[i]) {
        await localDB.execute(sql);
      }
    }
  }

  @override
  insertOrUpdate<T extends LocalSqlBase>(T data) {
    return db.insert(data.getTableName(), data.toSqlite(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future insert<T extends LocalSqlBase>(T data) {
    return db.insert(data.getTableName(), data.toSqlite(), conflictAlgorithm: ConflictAlgorithm.fail);
  }

  @override
  Future<T?> getLastData<T extends LocalSqlBase>(T data, T Function(Map<String, dynamic> json) creator) async {
    final result = await db.query(data.getTableName(), orderBy: "updated_at DESC, id DESC", limit: 1);
    if (result.length == 1) {
      return creator(result.first);
    }
    return null;
  }

  Future<String> _getPath() async {
    if (Platform.isWindows || Platform.isLinux) {
      return dirname(Platform.resolvedExecutable);
    }
    return getDatabasesPath();
  }

  @override
  Future<T?> getById<T extends LocalSqlBase>(
      String table, int id, T Function(Map<String, dynamic> json) creator) async {
    final result = await db.query(table, where: "id = ?", whereArgs: [id]);
    if (result.isNotEmpty) return creator(result.first);
    return null;
  }

  @override
  Future<List<T>> query<T extends LocalSqlBase>(String table,
      {String? where,
      List<Object?>? whereArgs,
      int offset = 0,
      int limit = 100,
      String? orderBy,
      required T Function(Map<String, dynamic> json) creator}) async {
    final items = await db.query(
      table,
      where: where,
      whereArgs: whereArgs,
      offset: offset,
      limit: limit,
      orderBy: orderBy,
    );
    List<T> lists = [];
    for (final item in items) {
      lists.add(creator(item));
    }
    return lists;
  }

  @override
  Future updateById(String table, int id, Map<String, Object?> data) {
    return db.update(
      table,
      data,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
