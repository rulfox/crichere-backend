// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_League _$LeagueFromJson(Map<String, dynamic> json) => _League(
  id: json['id'] as String,
  name: json['name'] as String,
  format: json['format'] as String?,
  rulesUrl: json['rulesUrl'] as String?,
  mustSellAll: json['mustSellAll'] as bool? ?? false,
  playerOrderMode: json['playerOrderMode'] as String? ?? 'RANDOM',
  waitingListMode: json['waitingListMode'] as String? ?? 'ADMIN_PICKS',
  logoUrl: json['logoUrl'] as String?,
  bannerUrl: json['bannerUrl'] as String?,
  status: json['status'] as String,
  auctionDate: json['auctionDate'] == null
      ? null
      : DateTime.parse(json['auctionDate'] as String),
  createdBy: json['createdBy'] as String,
  auctionIds:
      (json['auctionIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
);

Map<String, dynamic> _$LeagueToJson(_League instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'format': instance.format,
  'rulesUrl': instance.rulesUrl,
  'mustSellAll': instance.mustSellAll,
  'playerOrderMode': instance.playerOrderMode,
  'waitingListMode': instance.waitingListMode,
  'logoUrl': instance.logoUrl,
  'bannerUrl': instance.bannerUrl,
  'status': instance.status,
  'auctionDate': instance.auctionDate?.toIso8601String(),
  'createdBy': instance.createdBy,
  'auctionIds': instance.auctionIds,
};
