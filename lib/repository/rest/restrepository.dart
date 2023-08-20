import 'package:sultanpos/http/httpapi.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/repository/repository.dart';

class BaseRestCRUDRepository<T extends BaseModel> implements BaseCRUDRepository<T> {
  final T Function(Map<String, dynamic> json) creator;
  final IHttpAPI httpApi;
  final String path;
  BaseRestCRUDRepository({required this.httpApi, required this.path, required this.creator});

  @override
  Future delete(int id) {
    return httpApi.delete('${getPath()}/$id');
  }

  @override
  get(int id) {
    return httpApi.get('${getPath()}/$id', fromJsonFunc: creator);
  }

  @override
  Future insert(BaseModel data) {
    return httpApi.insert(data, path: getPath());
  }

  @override
  query(BaseFilterModel filter) {
    return httpApi.query(
      getPath(),
      fromJsonFunc: creator,
      limit: filter.limit,
      offset: filter.offset,
      queryParameters: filter.where,
    );
  }

  @override
  Future update(int id, BaseModel data) {
    return httpApi.update(data, id, path: getPath());
  }

  String getPath() {
    return path;
  }
}
