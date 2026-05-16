// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeagueCreateRequest _$LeagueCreateRequestFromJson(Map<String, dynamic> json) =>
    _LeagueCreateRequest(
      name: json['name'] as String,
      format: json['format'] as String?,
      rulesUrl: json['rulesUrl'] as String?,
      mustSellAll: json['mustSellAll'] as bool? ?? false,
      playerOrderMode: json['playerOrderMode'] as String? ?? 'RANDOM',
      waitingListMode: json['waitingListMode'] as String? ?? 'ADMIN_PICKS',
      logoUrl: json['logoUrl'] as String?,
      bannerUrl: json['bannerUrl'] as String?,
      auctionDate: json['auctionDate'] as String?,
    );

Map<String, dynamic> _$LeagueCreateRequestToJson(
  _LeagueCreateRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'format': instance.format,
  'rulesUrl': instance.rulesUrl,
  'mustSellAll': instance.mustSellAll,
  'playerOrderMode': instance.playerOrderMode,
  'waitingListMode': instance.waitingListMode,
  'logoUrl': instance.logoUrl,
  'bannerUrl': instance.bannerUrl,
  'auctionDate': instance.auctionDate,
};
