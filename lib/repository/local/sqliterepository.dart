import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/listresult.dart';
import 'package:sultanpos/repository/repository.dart';
import 'package:sultanpos/sync/local/database.dart';

class SqliteWhere {
  final String? where;
  final List<Object?>? whereArgs;
  SqliteWhere(this.where, this.whereArgs);
}

class BaseSqliteRepository<T extends LocalSqlBase> implements BaseCRUDRepository<T> {
  final T Function(Map<String, dynamic> json) creator;
  final String tableName;
  final ISqliteDatabase sqliteDb;
  BaseSqliteRepository({required this.tableName, required this.creator, required this.sqliteDb});

  @override
  Future delete(int id) async {
    throw UnimplementedError();
  }

  @override
  get(int id) async {
    return sqliteDb.getById<T>(tableName, id, creator);
  }

  @override
  Future insert(BaseModel data) async {
    throw UnimplementedError();
  }

  @override
  Future<ListResult<T>> query(BaseFilterModel filter) async {
    final where = buildWhere(filter);
    final result = await sqliteDb.query(tableName,
        creator: creator, limit: filter.limit, offset: filter.offset, where: where.where, whereArgs: where.whereArgs);
    return ListResult(result, result.length);
  }

  @override
  Future update(int id, BaseModel data) async {
    throw UnimplementedError();
  }

  SqliteWhere buildWhere(BaseFilterModel filter) {
    if (filter.where == null) return SqliteWhere(null, null);
    String? where;
    List<dynamic>? whereArgs;
    filter.where!.forEach((key, value) {
      if (where == null) {
        where = '$key = ?';
        whereArgs = [value];
      } else {
        where = '$where and $key = ?';
        whereArgs!.add(value);
      }
    });
    return SqliteWhere(where, whereArgs);
  }
}
