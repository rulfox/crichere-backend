// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league_player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeaguePlayer _$LeaguePlayerFromJson(Map<String, dynamic> json) =>
    _LeaguePlayer(
      id: json['id'] as String,
      leagueId: json['leagueId'] as String,
      playerId: json['playerId'] as String,
      playerName: json['playerName'] as String,
      playerPhotoUrl: json['playerPhotoUrl'] as String?,
      status: json['status'] as String,
      basePriceOverride: (json['basePriceOverride'] as num?)?.toInt(),
      finalPrice: (json['finalPrice'] as num?)?.toInt(),
      franchiseId: json['franchiseId'] as String?,
      franchiseName: json['franchiseName'] as String?,
    );

Map<String, dynamic> _$LeaguePlayerToJson(_LeaguePlayer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'leagueId': instance.leagueId,
      'playerId': instance.playerId,
      'playerName': instance.playerName,
      'playerPhotoUrl': instance.playerPhotoUrl,
      'status': instance.status,
      'basePriceOverride': instance.basePriceOverride,
      'finalPrice': instance.finalPrice,
      'franchiseId': instance.franchiseId,
      'franchiseName': instance.franchiseName,
    };
