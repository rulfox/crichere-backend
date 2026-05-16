// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auction_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuctionSummary _$AuctionSummaryFromJson(Map<String, dynamic> json) =>
    _AuctionSummary(
      auctionId: json['auctionId'] as String,
      leagueId: json['leagueId'] as String,
      leagueName: json['leagueName'] as String,
      totalPlayersSold: (json['totalSold'] as num).toInt(),
      totalAmountSpent: (json['totalSpent'] as num).toInt(),
      totalPlayers: (json['totalPlayers'] as num).toInt(),
      totalUnsold: (json['totalUnsold'] as num).toInt(),
      topBuy: json['highestSale'] == null
          ? null
          : TopBuy.fromJson(json['highestSale'] as Map<String, dynamic>),
      franchiseResults: (json['franchiseSummaries'] as List<dynamic>)
          .map((e) => FranchiseResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$AuctionSummaryToJson(_AuctionSummary instance) =>
    <String, dynamic>{
      'auctionId': instance.auctionId,
      'leagueId': instance.leagueId,
      'leagueName': instance.leagueName,
      'totalSold': instance.totalPlayersSold,
      'totalSpent': instance.totalAmountSpent,
      'totalPlayers': instance.totalPlayers,
      'totalUnsold': instance.totalUnsold,
      'highestSale': instance.topBuy,
      'franchiseSummaries': instance.franchiseResults,
      'completedAt': instance.completedAt?.toIso8601String(),
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
      playersCount: (json['squadCount'] as num).toInt(),
      totalSpent: (json['totalSpent'] as num).toInt(),
      remainingPurse: (json['remainingPurse'] as num).toInt(),
    );

Map<String, dynamic> _$FranchiseResultToJson(_FranchiseResult instance) =>
    <String, dynamic>{
      'franchiseId': instance.franchiseId,
      'franchiseName': instance.franchiseName,
      'squadCount': instance.playersCount,
      'totalSpent': instance.totalSpent,
      'remainingPurse': instance.remainingPurse,
    };
