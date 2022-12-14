import 'package:sultanpos/model/base.dart';

part 'branch.g.dart';

@JsonSerializable()
class BranchModel extends BaseModel {
  @JsonKey(name: 'public_id')
  final String publicId;
  final String name;
  final String code;
  final String fullname;
  final String address;
  final String phone;
  final String npwp;
  final String image;
  @JsonKey(name: 'is_default')
  final bool isDefault;
  BranchModel(this.publicId, this.name, this.code, this.fullname, this.address, this.phone, this.npwp, this.image, this.isDefault);

  @override
  factory BranchModel.fromJson(Map<String, dynamic> json) => _$BranchModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BranchModelToJson(this);

  @override
  String getPublicId() => publicId;
}
