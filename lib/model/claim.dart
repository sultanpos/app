import 'package:sultanpos/model/base.dart';

part 'claim.g.dart';

@JsonSerializable()
class JWTClaim extends BaseModel {
  @JsonKey(name: 'UserID')
  final int userId;

  @JsonKey(name: 'CompanyID')
  final int companyId;

  @JsonKey(name: 'BranchIDs')
  final List<int> branchIds;

  @JsonKey(name: 'Permission')
  final Map<int, int> permission;

  JWTClaim(this.userId, this.companyId, this.branchIds, this.permission);

  @override
  factory JWTClaim.fromJson(Map<String, dynamic> json) => _$JWTClaimFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$JWTClaimToJson(this);
}
