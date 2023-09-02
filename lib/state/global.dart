import 'package:flutter/material.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/branch.dart';
import 'package:sultanpos/model/claim.dart';
import 'package:sultanpos/preference.dart';
import 'package:sultanpos/repository/repository.dart';

abstract class ICurrentApp {
  int currentBranchId();
}

class GlobalState extends ChangeNotifier implements ICurrentApp {
  final Preference preference;
  final BaseCRUDRepository<BranchModel> branchRepo;
  BranchModel? currentBranch;
  List<BranchModel> branches = [];
  late int companyId;

  GlobalState(this.branchRepo, this.preference);

  setupBranch(JWTClaim claim) async {
    companyId = claim.companyId;
    final branch = preference.getBranch();
    if (branch != null && claim.hasBranch(branch.id)) {
      currentBranch = branch;
      return;
    }
    try {
      final result = await branchRepo.query(BaseFilterModel(limit: -1, offset: 0));
      if (result.data.isNotEmpty) {
        currentBranch = result.data.first;
      }
    } catch (e) {
      rethrow;
    }
  }

  selectBranch(int index) {
    currentBranch = branches[index];
    notifyListeners();
  }

  @override
  int currentBranchId() {
    return currentBranch?.id ?? 0;
  }
}
