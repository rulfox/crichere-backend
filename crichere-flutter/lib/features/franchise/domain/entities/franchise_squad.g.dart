// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'franchise_squad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuctionPlayerSummary _$AuctionPlayerSummaryFromJson(
  Map<String, dynamic> json,
) => _AuctionPlayerSummary(
  playerName: json['playerName'] as String,
  playerCategory: json['playerCategory'] as String?,
  finalPrice: (json['finalPrice'] as num?)?.toInt(),
  assignmentType: json['assignmentType'] as String?,
  roundNumber: (json['roundNumber'] as num?)?.toInt(),
);

Map<String, dynamic> _$AuctionPlayerSummaryToJson(
  _AuctionPlayerSummary instance,
) => <String, dynamic>{
  'playerName': instance.playerName,
  'playerCategory': instance.playerCategory,
  'finalPrice': instance.finalPrice,
  'assignmentType': instance.assignmentType,
  'roundNumber': instance.roundNumber,
};

_FranchiseSquadResponse _$FranchiseSquadResponseFromJson(
  Map<String, dynamic> json,
) => _FranchiseSquadResponse(
  franchiseId: json['franchiseId'] as String,
  franchiseName: json['franchiseName'] as String,
  players: (json['players'] as List<dynamic>)
      .map((e) => AuctionPlayerSummary.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$FranchiseSquadResponseToJson(
  _FranchiseSquadResponse instance,
) => <String, dynamic>{
  'franchiseId': instance.franchiseId,
  'franchiseName': instance.franchiseName,
  'players': instance.players,
};
