// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JWTClaim _$JWTClaimFromJson(Map<String, dynamic> json) => JWTClaim(
      json['UserID'] as int,
      json['UserPublicID'] as String,
      json['CompanyID'] as String,
      (json['BranchIDs'] as List<dynamic>).map((e) => e as String).toList(),
      (json['Permission'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k), e as int),
      ),
    );

Map<String, dynamic> _$JWTClaimToJson(JWTClaim instance) => <String, dynamic>{
      'UserID': instance.userId,
      'UserPublicID': instance.userPublicId,
      'CompanyID': instance.companyId,
      'BranchIDs': instance.branchIds,
      'Permission':
          instance.permission.map((k, e) => MapEntry(k.toString(), e)),
    };
