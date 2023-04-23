// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JWTClaim _$JWTClaimFromJson(Map<String, dynamic> json) => JWTClaim(
      json['UserID'] as int,
      json['CompanyID'] as int,
      (json['BranchIDs'] as List<dynamic>).map((e) => e as int).toList(),
      (json['Permission'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k), e as int),
      ),
    );

Map<String, dynamic> _$JWTClaimToJson(JWTClaim instance) => <String, dynamic>{
      'UserID': instance.userId,
      'CompanyID': instance.companyId,
      'BranchIDs': instance.branchIds,
      'Permission':
          instance.permission.map((k, e) => MapEntry(k.toString(), e)),
    };
