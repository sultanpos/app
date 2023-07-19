// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineModel _$MachineModelFromJson(Map<String, dynamic> json) => MachineModel(
      json['id'] as int,
    );

Map<String, dynamic> _$MachineModelToJson(MachineModel instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

MachineInsertModel _$MachineInsertModelFromJson(Map<String, dynamic> json) =>
    MachineInsertModel(
      json['branch_id'] as int,
      json['name'] as String,
    );

Map<String, dynamic> _$MachineInsertModelToJson(MachineInsertModel instance) =>
    <String, dynamic>{
      'branch_id': instance.branchId,
      'name': instance.name,
    };

MachineUpdateModel _$MachineUpdateModelFromJson(Map<String, dynamic> json) =>
    MachineUpdateModel(
      json['name'] as String,
    );

Map<String, dynamic> _$MachineUpdateModelToJson(MachineUpdateModel instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
