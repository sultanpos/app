import 'package:sultanpos/model/base.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel extends BaseModel {
  @JsonKey(name: 'public_id')
  final String publicID;
  final String username;
  final String name;
  final String email;
  final String pin;
  final String address;
  final String phone;
  final String photo;
  UserModel(this.publicID, this.username, this.name, this.email, this.pin, this.address, this.phone, this.photo);

  @override
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  @override
  String? path() => "/user";

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String getPublicId() => publicID;
}
