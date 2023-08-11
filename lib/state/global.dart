import 'package:flutter/material.dart';
import 'package:sultanpos/model/branch.dart';
import 'package:sultanpos/model/claim.dart';
import 'package:sultanpos/preference.dart';
import 'package:sultanpos/repository/repository.dart';
import 'package:sultanpos/repository/rest/restrepository.dart';

class GlobalState extends ChangeNotifier {
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
      final result = await branchRepo.query(RestFilterModel(limit: -1, offset: 0));
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
}
