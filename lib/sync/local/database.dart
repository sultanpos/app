import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/sync/local/migration.dart';

class SqliteDatabase {
  final int companyId;
  late Database db;

  SqliteDatabase(this.companyId);

  open() async {
    final path = await getPath();
    final databasePath = '$path/sultanpos_$companyId.db';
    debugPrint('database path: $databasePath');
    db = await databaseFactoryFfi.openDatabase(
      databasePath,
      options: OpenDatabaseOptions(
        version: 1, //adding this make sure to add SqliteMigration.migrationScripts
        onCreate: (localDB, version) async {
          await migrate(localDB, 0);
        },
        onUpgrade: (localDB, oldVersion, newVersion) async {
          await migrate(localDB, oldVersion);
        },
      ),
    );
  }

  migrate(Database localDB, int version) async {
    final lists = SqliteMigration.migrationScripts;
    for (var i = version; i < lists.length; i++) {
      for (final sql in lists[i]) {
        await localDB.execute(sql);
      }
    }
  }

  insertOrUpdate<T extends LocalSqlBase>(T data) async {
    return db.insert(data.getTableName(), data.toSqlite(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  getLastData<T extends LocalSqlBase>(T data, T Function(Map<String, dynamic> json) creator) async {
    final result = await db.query(data.getTableName(), orderBy: "updated_at DESC, id DESC", limit: 1);
    if (result.length == 1) {
      return creator(result.first);
    }
  }

  Future<String> getPath() async {
    if (Platform.isWindows || Platform.isLinux) {
      return dirname(Platform.resolvedExecutable);
    }
    return getDatabasesPath();
  }
}
