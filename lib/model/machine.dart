import 'package:sultanpos/model/base.dart';

part 'machine.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MachineModel extends BaseModel {
  final int id;
  MachineModel(this.id);
  @override
  factory MachineModel.fromJson(Map<String, dynamic> json) => _$MachineModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MachineModelToJson(this);

  @override
  int getId() => id;
}

@JsonSerializable()
class MachineInsertModel extends BaseModel {
  @JsonKey(name: 'branch_id')
  final int branchId;
  final String name;
  MachineInsertModel(this.branchId, this.name);
  @override
  factory MachineInsertModel.fromJson(Map<String, dynamic> json) => _$MachineInsertModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MachineInsertModelToJson(this);
}

@JsonSerializable()
class MachineUpdateModel extends BaseModel {
  final String name;
  MachineUpdateModel(this.name);
  @override
  factory MachineUpdateModel.fromJson(Map<String, dynamic> json) => _$MachineUpdateModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MachineUpdateModelToJson(this);
}
