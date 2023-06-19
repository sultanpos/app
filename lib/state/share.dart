import 'package:flutter/material.dart';
import 'package:sultanpos/model/branch.dart';
import 'package:sultanpos/model/pricegroup.dart';
import 'package:sultanpos/repository/rest/branchrepo.dart';
import 'package:sultanpos/repository/rest/pricegroup.dart';
import 'package:sultanpos/repository/rest/restrepository.dart';

class ShareState extends ChangeNotifier {
  final RestPriceGroupRepo priceGroupRepo;
  final RestBranchRepo branchRepo;
  ShareState({required this.priceGroupRepo, required this.branchRepo});

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
    final list = await branchRepo.query(RestFilterModel(limit: 100, offset: 0));
    branches = list.data;
  }

  getDefaultPriceGroup() async {
    defaultPriceGroup = await priceGroupRepo.defaultPriceGroup();
  }

  BranchModel? defaultBranch() {
    return branches?.firstWhere((element) => element.isDefault);
  }
}
