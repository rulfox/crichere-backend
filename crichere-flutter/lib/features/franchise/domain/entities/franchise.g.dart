// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'franchise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Franchise _$FranchiseFromJson(Map<String, dynamic> json) => _Franchise(
  id: json['id'] as String,
  leagueId: json['leagueId'] as String,
  name: json['name'] as String,
  logoUrl: json['logoUrl'] as String?,
  ownerId: json['ownerId'] as String?,
  startingPurse: (json['totalPurse'] as num).toInt(),
  currentPurse: (json['remainingPurse'] as num).toInt(),
);

Map<String, dynamic> _$FranchiseToJson(_Franchise instance) =>
    <String, dynamic>{
      'id': instance.id,
      'leagueId': instance.leagueId,
      'name': instance.name,
      'logoUrl': instance.logoUrl,
      'ownerId': instance.ownerId,
      'totalPurse': instance.startingPurse,
      'remainingPurse': instance.currentPurse,
    };
