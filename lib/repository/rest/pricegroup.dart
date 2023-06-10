import 'package:sultanpos/model/pricegroup.dart';
import 'package:sultanpos/repository/rest/restrepository.dart';

class RestPriceGroupRepo extends BaseRestCRUDRepository<PriceGroupModel> {
  RestPriceGroupRepo({required super.httpApi}) : super(path: '/pricegroup', creator: PriceGroupModel.fromJson);

  Future<PriceGroupModel?> defaultPriceGroup() async {
    final list = await httpApi.query(path,
        fromJsonFunc: PriceGroupModel.fromJson, limit: 1, offset: 0, queryParameters: {'is_default': 'true'});
    if (list.data.isNotEmpty) {
      return list.data[0];
    }
    return null;
  }
}
