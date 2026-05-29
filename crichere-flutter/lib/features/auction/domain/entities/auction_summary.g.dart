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
      status: $enumDecodeNullable(
        _$AuctionStatusEnumMap,
        json['status'],
        unknownValue: AuctionStatus.unknown,
      ),
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      totalPlayers: (json['totalPlayers'] as num?)?.toInt() ?? 0,
      totalSold: (json['totalSold'] as num?)?.toInt() ?? 0,
      totalUnsold: (json['totalUnsold'] as num?)?.toInt() ?? 0,
      totalWithdrawn: (json['totalWithdrawn'] as num?)?.toInt() ?? 0,
      totalSpent: (json['totalSpent'] as num?)?.toInt() ?? 0,
      highestSale: json['highestSale'] == null
          ? null
          : TopBuy.fromJson(json['highestSale'] as Map<String, dynamic>),
      franchiseSummaries:
          (json['franchiseSummaries'] as List<dynamic>?)
              ?.map((e) => FranchiseResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FranchiseResult>[],
    );

Map<String, dynamic> _$AuctionSummaryToJson(_AuctionSummary instance) =>
    <String, dynamic>{
      'auctionId': instance.auctionId,
      'leagueId': instance.leagueId,
      'leagueName': instance.leagueName,
      'status': _$AuctionStatusEnumMap[instance.status],
      'startedAt': instance.startedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'totalPlayers': instance.totalPlayers,
      'totalSold': instance.totalSold,
      'totalUnsold': instance.totalUnsold,
      'totalWithdrawn': instance.totalWithdrawn,
      'totalSpent': instance.totalSpent,
      'highestSale': instance.highestSale,
      'franchiseSummaries': instance.franchiseSummaries,
    };

const _$AuctionStatusEnumMap = {
  AuctionStatus.draft: 'DRAFT',
  AuctionStatus.live: 'LIVE',
  AuctionStatus.paused: 'PAUSED',
  AuctionStatus.completed: 'COMPLETED',
  AuctionStatus.cancelled: 'CANCELLED',
  AuctionStatus.unknown: 'unknown',
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

_AuctionPlayerSummary _$AuctionPlayerSummaryFromJson(
  Map<String, dynamic> json,
) => _AuctionPlayerSummary(
  playerName: json['playerName'] as String,
  playerCategory: json['playerCategory'] as String?,
  playerTag: json['playerTag'] as String?,
  finalPrice: (json['finalPrice'] as num?)?.toInt(),
  assignmentType: json['assignmentType'] as String?,
  roundNumber: (json['roundNumber'] as num?)?.toInt(),
);

Map<String, dynamic> _$AuctionPlayerSummaryToJson(
  _AuctionPlayerSummary instance,
) => <String, dynamic>{
  'playerName': instance.playerName,
  'playerCategory': instance.playerCategory,
  'playerTag': instance.playerTag,
  'finalPrice': instance.finalPrice,
  'assignmentType': instance.assignmentType,
  'roundNumber': instance.roundNumber,
};

_FranchiseResult _$FranchiseResultFromJson(Map<String, dynamic> json) =>
    _FranchiseResult(
      franchiseId: json['franchiseId'] as String,
      franchiseName: json['franchiseName'] as String,
      squadCount: (json['squadCount'] as num?)?.toInt() ?? 0,
      totalSpent: (json['totalSpent'] as num?)?.toInt() ?? 0,
      remainingPurse: (json['remainingPurse'] as num?)?.toInt() ?? 0,
      players:
          (json['players'] as List<dynamic>?)
              ?.map(
                (e) => AuctionPlayerSummary.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <AuctionPlayerSummary>[],
    );

Map<String, dynamic> _$FranchiseResultToJson(_FranchiseResult instance) =>
    <String, dynamic>{
      'franchiseId': instance.franchiseId,
      'franchiseName': instance.franchiseName,
      'squadCount': instance.squadCount,
      'totalSpent': instance.totalSpent,
      'remainingPurse': instance.remainingPurse,
      'players': instance.players,
    };

_CategoryBreakdown _$CategoryBreakdownFromJson(Map<String, dynamic> json) =>
    _CategoryBreakdown(
      category: json['category'] as String,
      count: (json['count'] as num?)?.toInt() ?? 0,
      totalSpent: (json['totalSpent'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CategoryBreakdownToJson(_CategoryBreakdown instance) =>
    <String, dynamic>{
      'category': instance.category,
      'count': instance.count,
      'totalSpent': instance.totalSpent,
    };

_FranchiseDetailedSummary _$FranchiseDetailedSummaryFromJson(
  Map<String, dynamic> json,
) => _FranchiseDetailedSummary(
  franchiseId: json['franchiseId'] as String,
  franchiseName: json['franchiseName'] as String,
  squadCount: (json['squadCount'] as num?)?.toInt() ?? 0,
  totalSpent: (json['totalSpent'] as num?)?.toInt() ?? 0,
  remainingPurse: (json['remainingPurse'] as num?)?.toInt() ?? 0,
  categoryBreakdown:
      (json['categoryBreakdown'] as List<dynamic>?)
          ?.map((e) => CategoryBreakdown.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <CategoryBreakdown>[],
  players:
      (json['players'] as List<dynamic>?)
          ?.map((e) => AuctionPlayerSummary.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <AuctionPlayerSummary>[],
);

Map<String, dynamic> _$FranchiseDetailedSummaryToJson(
  _FranchiseDetailedSummary instance,
) => <String, dynamic>{
  'franchiseId': instance.franchiseId,
  'franchiseName': instance.franchiseName,
  'squadCount': instance.squadCount,
  'totalSpent': instance.totalSpent,
  'remainingPurse': instance.remainingPurse,
  'categoryBreakdown': instance.categoryBreakdown,
  'players': instance.players,
};

_UnsoldPlayersResponse _$UnsoldPlayersResponseFromJson(
  Map<String, dynamic> json,
) => _UnsoldPlayersResponse(
  players:
      (json['players'] as List<dynamic>?)
          ?.map((e) => AuctionPlayerSummary.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <AuctionPlayerSummary>[],
  totalElements: (json['totalElements'] as num?)?.toInt() ?? 0,
  totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
  pageNumber: (json['pageNumber'] as num?)?.toInt() ?? 0,
  pageSize: (json['pageSize'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$UnsoldPlayersResponseToJson(
  _UnsoldPlayersResponse instance,
) => <String, dynamic>{
  'players': instance.players,
  'totalElements': instance.totalElements,
  'totalPages': instance.totalPages,
  'pageNumber': instance.pageNumber,
  'pageSize': instance.pageSize,
};
