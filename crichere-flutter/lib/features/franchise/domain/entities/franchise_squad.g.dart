// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'franchise_squad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FranchiseSquad _$FranchiseSquadFromJson(Map<String, dynamic> json) =>
    _FranchiseSquad(
      franchiseId: json['franchiseId'] as String,
      franchiseName: json['franchiseName'] as String,
      purseRemaining: (json['purseRemaining'] as num).toInt(),
      players: (json['players'] as List<dynamic>)
          .map((e) => FranchisePlayer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FranchiseSquadToJson(_FranchiseSquad instance) =>
    <String, dynamic>{
      'franchiseId': instance.franchiseId,
      'franchiseName': instance.franchiseName,
      'purseRemaining': instance.purseRemaining,
      'players': instance.players,
    };
