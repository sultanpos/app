import 'package:sultanpos/model/pricegroup.dart';
import 'package:sultanpos/state/base.dart';

class ShareState extends BaseState {
  ShareState(super.httpAPI);

  PriceGroupModel? defaultPriceGroup;

  getDefaultPriceGroup() async {
    final list =
        await httpAPI.query('/pricegroup', fromJsonFunc: PriceGroupModel.fromJson, limit: 100, offset: 0, queryParameters: {'is_default': 'true'});
    if (list.data.isNotEmpty) {
      defaultPriceGroup = list.data[0];
    }
  }

  reset() {
    defaultPriceGroup = null;
  }
}
