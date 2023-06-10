import 'package:sultanpos/model/branch.dart';
import 'package:sultanpos/repository/rest/restrepository.dart';

class RestBranchRepo extends BaseRestCRUDRepository<BranchModel> {
  RestBranchRepo({required super.httpApi}) : super(path: '/branch', creator: BranchModel.fromJson);
}
