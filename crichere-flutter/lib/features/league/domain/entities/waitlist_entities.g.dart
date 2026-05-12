// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waitlist_entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WaitlistEntry _$WaitlistEntryFromJson(Map<String, dynamic> json) =>
    _WaitlistEntry(
      id: json['id'] as String,
      leagueId: json['leagueId'] as String,
      playerId: json['playerId'] as String,
      playerName: json['playerName'] as String,
      position: (json['position'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$WaitlistEntryToJson(_WaitlistEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'leagueId': instance.leagueId,
      'playerId': instance.playerId,
      'playerName': instance.playerName,
      'position': instance.position,
      'createdAt': instance.createdAt.toIso8601String(),
    };
