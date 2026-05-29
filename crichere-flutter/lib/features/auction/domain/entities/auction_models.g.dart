// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auction_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuctionResponse _$AuctionResponseFromJson(Map<String, dynamic> json) =>
    _AuctionResponse(
      id: json['id'] as String,
      leagueId: json['leagueId'] as String,
      auctioneerId: json['auctioneerId'] as String?,
      status: $enumDecode(
        _$AuctionStatusEnumMap,
        json['status'],
        unknownValue: AuctionStatus.unknown,
      ),
      currentRoundId: json['currentRoundId'] as String?,
      currentLeaguePlayerId: json['currentLeaguePlayerId'] as String?,
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      displayUrl: json['displayUrl'] as String?,
      publicViewUrl: json['publicViewUrl'] as String?,
      publicViewToken: json['publicViewToken'] as String?,
    );

Map<String, dynamic> _$AuctionResponseToJson(_AuctionResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'leagueId': instance.leagueId,
      'auctioneerId': instance.auctioneerId,
      'status': _$AuctionStatusEnumMap[instance.status]!,
      'currentRoundId': instance.currentRoundId,
      'currentLeaguePlayerId': instance.currentLeaguePlayerId,
      'startedAt': instance.startedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'displayUrl': instance.displayUrl,
      'publicViewUrl': instance.publicViewUrl,
      'publicViewToken': instance.publicViewToken,
    };

const _$AuctionStatusEnumMap = {
  AuctionStatus.draft: 'DRAFT',
  AuctionStatus.live: 'LIVE',
  AuctionStatus.paused: 'PAUSED',
  AuctionStatus.completed: 'COMPLETED',
  AuctionStatus.cancelled: 'CANCELLED',
  AuctionStatus.unknown: 'unknown',
};

_BidResponse _$BidResponseFromJson(Map<String, dynamic> json) => _BidResponse(
  id: json['id'] as String,
  auctionId: json['auctionId'] as String,
  roundId: json['roundId'] as String,
  leaguePlayerId: json['leaguePlayerId'] as String,
  franchiseId: json['franchiseId'] as String,
  bidAmount: (json['bidAmount'] as num).toInt(),
  status: $enumDecode(
    _$BidStatusEnumMap,
    json['status'],
    unknownValue: BidStatus.unknown,
  ),
  recordedBy: json['recordedBy'] as String?,
  bidAt: json['bidAt'] == null ? null : DateTime.parse(json['bidAt'] as String),
);

Map<String, dynamic> _$BidResponseToJson(_BidResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'auctionId': instance.auctionId,
      'roundId': instance.roundId,
      'leaguePlayerId': instance.leaguePlayerId,
      'franchiseId': instance.franchiseId,
      'bidAmount': instance.bidAmount,
      'status': _$BidStatusEnumMap[instance.status]!,
      'recordedBy': instance.recordedBy,
      'bidAt': instance.bidAt?.toIso8601String(),
    };

const _$BidStatusEnumMap = {
  BidStatus.active: 'ACTIVE',
  BidStatus.undone: 'UNDONE',
  BidStatus.unknown: 'unknown',
};

_CategoryIncrement _$CategoryIncrementFromJson(Map<String, dynamic> json) =>
    _CategoryIncrement(
      id: json['id'] as String,
      roundId: json['roundId'] as String,
      category: json['category'] as String?,
      tag: json['tag'] as String?,
      bidIncrement: (json['bidIncrement'] as num).toInt(),
    );

Map<String, dynamic> _$CategoryIncrementToJson(_CategoryIncrement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roundId': instance.roundId,
      'category': instance.category,
      'tag': instance.tag,
      'bidIncrement': instance.bidIncrement,
    };

_AuditLogResponse _$AuditLogResponseFromJson(Map<String, dynamic> json) =>
    _AuditLogResponse(
      id: json['id'] as String,
      auctionId: json['auctionId'] as String,
      sequenceNumber: (json['sequenceNumber'] as num).toInt(),
      action: $enumDecode(
        _$AuctionActionEnumMap,
        json['action'],
        unknownValue: AuctionAction.unknown,
      ),
      payload:
          json['payload'] as Map<String, dynamic>? ?? const <String, dynamic>{},
      actorId: json['actorId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$AuditLogResponseToJson(_AuditLogResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'auctionId': instance.auctionId,
      'sequenceNumber': instance.sequenceNumber,
      'action': _$AuctionActionEnumMap[instance.action]!,
      'payload': instance.payload,
      'actorId': instance.actorId,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$AuctionActionEnumMap = {
  AuctionAction.playerUp: 'PLAYER_UP',
  AuctionAction.bidPlaced: 'BID_PLACED',
  AuctionAction.bidUndone: 'BID_UNDONE',
  AuctionAction.playerSold: 'PLAYER_SOLD',
  AuctionAction.soldReverted: 'SOLD_REVERTED',
  AuctionAction.playerUnsold: 'PLAYER_UNSOLD',
  AuctionAction.playerWithdrawn: 'PLAYER_WITHDRAWN',
  AuctionAction.playerForceAssigned: 'PLAYER_FORCE_ASSIGNED',
  AuctionAction.playerPreAssigned: 'PLAYER_PRE_ASSIGNED',
  AuctionAction.roundStarted: 'ROUND_STARTED',
  AuctionAction.roundCompleted: 'ROUND_COMPLETED',
  AuctionAction.auctionStarted: 'AUCTION_STARTED',
  AuctionAction.auctionPaused: 'AUCTION_PAUSED',
  AuctionAction.auctionResumed: 'AUCTION_RESUMED',
  AuctionAction.auctionCompleted: 'AUCTION_COMPLETED',
  AuctionAction.auctionCancelled: 'AUCTION_CANCELLED',
  AuctionAction.timerStarted: 'TIMER_STARTED',
  AuctionAction.timerStopped: 'TIMER_STOPPED',
  AuctionAction.timerReset: 'TIMER_RESET',
  AuctionAction.timerExtended: 'TIMER_EXTENDED',
  AuctionAction.unknown: 'unknown',
};
