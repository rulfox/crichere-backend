// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auction_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuctionSummary _$AuctionSummaryFromJson(Map<String, dynamic> json) =>
    _AuctionSummary(
      auctionId: json['auctionId'] as String,
      leagueName: json['leagueName'] as String,
      totalPlayersSold: (json['totalPlayersSold'] as num).toInt(),
      totalAmountSpent: (json['totalAmountSpent'] as num).toInt(),
      topBuys: (json['topBuys'] as List<dynamic>)
          .map((e) => TopBuy.fromJson(e as Map<String, dynamic>))
          .toList(),
      franchiseResults: (json['franchiseResults'] as List<dynamic>)
          .map((e) => FranchiseResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      unsoldPlayerIds: (json['unsoldPlayerIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      completedAt: DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$AuctionSummaryToJson(_AuctionSummary instance) =>
    <String, dynamic>{
      'auctionId': instance.auctionId,
      'leagueName': instance.leagueName,
      'totalPlayersSold': instance.totalPlayersSold,
      'totalAmountSpent': instance.totalAmountSpent,
      'topBuys': instance.topBuys,
      'franchiseResults': instance.franchiseResults,
      'unsoldPlayerIds': instance.unsoldPlayerIds,
      'completedAt': instance.completedAt.toIso8601String(),
    };

_TopBuy _$TopBuyFromJson(Map<String, dynamic> json) => _TopBuy(
  playerName: json['playerName'] as String,
  franchiseName: json['franchiseName'] as String,
  amount: (json['amount'] as num).toInt(),
);

Map<String, dynamic> _$TopBuyToJson(_TopBuy instance) => <String, dynamic>{
  'playerName': instance.playerName,
  'franchiseName': instance.franchiseName,
  'amount': instance.amount,
};

_FranchiseResult _$FranchiseResultFromJson(Map<String, dynamic> json) =>
    _FranchiseResult(
      franchiseId: json['franchiseId'] as String,
      franchiseName: json['franchiseName'] as String,
      totalSpent: (json['totalSpent'] as num).toInt(),
      playersCount: (json['playersCount'] as num).toInt(),
      remainingPurse: (json['remainingPurse'] as num).toInt(),
    );

Map<String, dynamic> _$FranchiseResultToJson(_FranchiseResult instance) =>
    <String, dynamic>{
      'franchiseId': instance.franchiseId,
      'franchiseName': instance.franchiseName,
      'totalSpent': instance.totalSpent,
      'playersCount': instance.playersCount,
      'remainingPurse': instance.remainingPurse,
    };
