import 'package:sultanpos/model/base.dart';

part 'claim.g.dart';

@JsonSerializable()
class JWTClaim implements BaseModel {
  @JsonKey(name: 'UserID')
  final int userId;

  @JsonKey(name: 'UserPublicID')
  final String userPublicId;

  @JsonKey(name: 'CompanyID')
  final String companyId;

  @JsonKey(name: 'BranchIDs')
  final List<String> branchIds;

  @JsonKey(name: 'Permission')
  final Map<int, int> permission;

  JWTClaim(this.userId, this.userPublicId, this.companyId, this.branchIds, this.permission);

  @override
  factory JWTClaim.fromJson(Map<String, dynamic> json) => _$JWTClaimFromJson(json);

  @override
  String? path() {
    return null;
  }

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) {
    return null;
  }

  @override
  Map<String, dynamic> toJson() => _$JWTClaimToJson(this);
}
