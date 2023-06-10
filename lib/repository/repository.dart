import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/listresult.dart';

abstract class BaseCRUDRepository<T extends BaseModel> {
  final T Function(Map<String, dynamic> json) creator;
  BaseCRUDRepository(this.creator);

  Future insert(BaseModel data);
  Future update(int id, BaseModel data);
  Future delete(int id);
  Future<T> get(int id);
  Future<ListResult<T>> query(BaseFilterModel filter);
}
