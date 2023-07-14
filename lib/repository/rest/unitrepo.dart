import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/unit.dart';
import 'package:sultanpos/repository/repository.dart';
import 'package:sultanpos/repository/rest/restrepository.dart';

class RestUnitRepo extends BaseRestCRUDRepository<UnitModel> implements UnitRepository {
  List<UnitModel?> cachedUnits = [];
  RestUnitRepo({required super.httpApi}) : super(creator: UnitModel.fromJson, path: '/unit');

  @override
  Future delete(int id) {
    //cachedUnits = cachedUnits.where((element) => element!.id != id).toList();
    return httpApi.delete('${getPath()}/$id');
  }

  @override
  get(int id) async {
    if (cachedUnits.isNotEmpty) {
      final item = cachedUnits.firstWhere((element) => element!.id == id);
      if (item != null) return item;
    }
    return httpApi.get('${getPath()}/$id', fromJsonFunc: creator);
  }

  @override
  Future insert(BaseModel data) async {
    await httpApi.insert(data, path: getPath());
  }

  @override
  query(covariant RestFilterModel filter) async {
    final result = await httpApi.query(
      getPath(),
      fromJsonFunc: creator,
      limit: filter.limit,
      offset: filter.offset,
      queryParameters: filter.queryParameters,
    );
    cachedUnits = result.data;
    return result;
  }

  @override
  Future update(int id, BaseModel data) {
    return httpApi.update(data, id, path: getPath());
  }
}
