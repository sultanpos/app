import 'package:sultanpos/model/base.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel implements BaseModel {
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
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  String? path() => "/user";

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) => null;

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
