import 'package:sultanpos/model/pricegroup.dart';
import 'package:sultanpos/repository/repository.dart';
import 'package:sultanpos/repository/rest/restrepository.dart';

class RestPriceGroupRepo extends BaseRestCRUDRepository<PriceGroupModel> implements PriceGroupRepository {
  PriceGroupModel? _defaultPriceGroup;
  RestPriceGroupRepo({required super.httpApi}) : super(path: '/pricegroup', creator: PriceGroupModel.fromJson);

  @override
  Future<PriceGroupModel?> defaultPriceGroup() async {
    if (_defaultPriceGroup != null) return _defaultPriceGroup;
    final list = await httpApi.query(path,
        fromJsonFunc: PriceGroupModel.fromJson, limit: 1, offset: 0, queryParameters: {'is_default': 'true'});
    if (list.data.isNotEmpty) {
      _defaultPriceGroup = list.data.first;
    }
    return _defaultPriceGroup;
  }
}
