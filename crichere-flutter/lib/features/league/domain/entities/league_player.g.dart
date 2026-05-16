// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league_player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeaguePlayer _$LeaguePlayerFromJson(Map<String, dynamic> json) =>
    _LeaguePlayer(
      id: json['id'] as String,
      leagueId: json['leagueId'] as String,
      playerId: json['userId'] as String,
      playerName: json['playerName'] as String?,
      playerPhotoUrl: json['playerPhotoUrl'] as String?,
      status: json['status'] as String,
      basePriceOverride: (json['basePriceOverride'] as num?)?.toInt(),
      basePrice: (json['basePrice'] as num?)?.toInt(),
      finalPrice: (json['finalPrice'] as num?)?.toInt(),
      franchiseId: json['franchiseId'] as String?,
      franchiseName: json['franchiseName'] as String?,
      category: json['category'] as String?,
      tag: json['tag'] as String?,
    );

Map<String, dynamic> _$LeaguePlayerToJson(_LeaguePlayer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'leagueId': instance.leagueId,
      'userId': instance.playerId,
      'playerName': instance.playerName,
      'playerPhotoUrl': instance.playerPhotoUrl,
      'status': instance.status,
      'basePriceOverride': instance.basePriceOverride,
      'basePrice': instance.basePrice,
      'finalPrice': instance.finalPrice,
      'franchiseId': instance.franchiseId,
      'franchiseName': instance.franchiseName,
      'category': instance.category,
      'tag': instance.tag,
    };
