// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_League _$LeagueFromJson(Map<String, dynamic> json) => _League(
  id: json['id'] as String,
  name: json['name'] as String,
  logoUrl: json['logoUrl'] as String?,
  status: json['status'] as String,
  auctionDate: json['auctionDate'] == null
      ? null
      : DateTime.parse(json['auctionDate'] as String),
);

Map<String, dynamic> _$LeagueToJson(_League instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'logoUrl': instance.logoUrl,
  'status': instance.status,
  'auctionDate': instance.auctionDate?.toIso8601String(),
};
