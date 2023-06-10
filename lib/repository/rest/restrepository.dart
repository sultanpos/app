import 'package:sultanpos/http/httpapi.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/repository/repository.dart';

class BaseRestCRUDRepository<T extends BaseModel> extends BaseCRUDRepository<T> {
  final HttpAPI httpApi;
  final String path;
  BaseRestCRUDRepository({required this.httpApi, required this.path, required super.creator});

  @override
  Future delete(int id) {
    return httpApi.delete('$path/$id');
  }

  @override
  get(int id) {
    return httpApi.get('$path/$id', fromJsonFunc: creator);
  }

  @override
  Future insert(BaseModel data) {
    return httpApi.insert(data, path: path);
  }

  @override
  query(covariant RestFilterModel filter) {
    return httpApi.query(path, fromJsonFunc: creator, limit: filter.limit, offset: filter.offset);
  }

  @override
  Future update(int id, BaseModel data) {
    return httpApi.update(data, id);
  }
}

class RestFilterModel extends BaseFilterModel {
  final int limit;
  final int offset;
  RestFilterModel({required this.limit, required this.offset});
}
