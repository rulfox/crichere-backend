// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeagueCreateRequest _$LeagueCreateRequestFromJson(Map<String, dynamic> json) =>
    _LeagueCreateRequest(
      name: json['name'] as String,
      format: json['format'] as String,
      basePrice: (json['basePrice'] as num).toInt(),
      purseAmount: (json['purseAmount'] as num).toInt(),
      maxPlayersPerFranchise: (json['maxPlayersPerFranchise'] as num).toInt(),
      waitingListMode: json['waitingListMode'] as String,
    );

Map<String, dynamic> _$LeagueCreateRequestToJson(
  _LeagueCreateRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'format': instance.format,
  'basePrice': instance.basePrice,
  'purseAmount': instance.purseAmount,
  'maxPlayersPerFranchise': instance.maxPlayersPerFranchise,
  'waitingListMode': instance.waitingListMode,
};
