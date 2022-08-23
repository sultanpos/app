import 'package:sultanpos/model/branch.dart';
import 'package:sultanpos/model/pricegroup.dart';
import 'package:sultanpos/state/base.dart';

class ShareState extends BaseState {
  ShareState(super.httpAPI);

  PriceGroupModel? defaultPriceGroup;
  List<BranchModel>? branches;

  initAll() async {
    await getBranches();
    await getDefaultPriceGroup();
  }

  reset() {
    defaultPriceGroup = null;
    branches = null;
  }

  getBranches() async {
    final list = await httpAPI.query('/branch', fromJsonFunc: BranchModel.fromJson, limit: 100, offset: 0);
    branches = list.data;
  }

  getDefaultPriceGroup() async {
    final list =
        await httpAPI.query('/pricegroup', fromJsonFunc: PriceGroupModel.fromJson, limit: 100, offset: 0, queryParameters: {'is_default': 'true'});
    if (list.data.isNotEmpty) {
      defaultPriceGroup = list.data[0];
    }
  }

  BranchModel? defaultBranch() {
    return branches?.firstWhere((element) => element.isDefault);
  }
}
