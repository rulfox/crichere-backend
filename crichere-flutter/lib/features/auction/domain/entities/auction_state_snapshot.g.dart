// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auction_state_snapshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BidIncrementSlab _$BidIncrementSlabFromJson(Map<String, dynamic> json) =>
    _BidIncrementSlab(
      fromAmount: (json['fromAmount'] as num).toInt(),
      toAmount: (json['toAmount'] as num?)?.toInt(),
      incrementBy: (json['incrementBy'] as num).toInt(),
    );

Map<String, dynamic> _$BidIncrementSlabToJson(_BidIncrementSlab instance) =>
    <String, dynamic>{
      'fromAmount': instance.fromAmount,
      'toAmount': instance.toAmount,
      'incrementBy': instance.incrementBy,
    };

_RoundConfig _$RoundConfigFromJson(Map<String, dynamic> json) => _RoundConfig(
  roundNumber: (json['roundNumber'] as num).toInt(),
  name: json['name'] as String?,
  currencyType: $enumDecode(
    _$CurrencyTypeEnumMap,
    json['currencyType'],
    unknownValue: CurrencyType.unknown,
  ),
  purseAmount: (json['purseAmount'] as num?)?.toInt(),
  purseSource: $enumDecode(
    _$PurseSourceEnumMap,
    json['purseSource'],
    unknownValue: PurseSource.unknown,
  ),
  bidMode: $enumDecode(
    _$BidModeEnumMap,
    json['bidMode'],
    unknownValue: BidMode.unknown,
  ),
  playerPoolSource: $enumDecode(
    _$PlayerPoolSourceEnumMap,
    json['playerPoolSource'],
    unknownValue: PlayerPoolSource.unknown,
  ),
  franchiseEligibilityRule: $enumDecode(
    _$FranchiseEligibilityRuleEnumMap,
    json['franchiseEligibilityRule'],
    unknownValue: FranchiseEligibilityRule.unknown,
  ),
  completionTrigger: $enumDecode(
    _$CompletionTriggerEnumMap,
    json['completionTrigger'],
    unknownValue: CompletionTrigger.unknown,
  ),
  countdownSeconds: (json['countdownSeconds'] as num?)?.toInt(),
  antiSnipeSeconds: (json['antiSnipeSeconds'] as num?)?.toInt(),
  bidIncrementSlabs:
      (json['bidIncrementSlabs'] as List<dynamic>?)
          ?.map((e) => BidIncrementSlab.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <BidIncrementSlab>[],
);

Map<String, dynamic> _$RoundConfigToJson(
  _RoundConfig instance,
) => <String, dynamic>{
  'roundNumber': instance.roundNumber,
  'name': instance.name,
  'currencyType': _$CurrencyTypeEnumMap[instance.currencyType]!,
  'purseAmount': instance.purseAmount,
  'purseSource': _$PurseSourceEnumMap[instance.purseSource]!,
  'bidMode': _$BidModeEnumMap[instance.bidMode]!,
  'playerPoolSource': _$PlayerPoolSourceEnumMap[instance.playerPoolSource]!,
  'franchiseEligibilityRule':
      _$FranchiseEligibilityRuleEnumMap[instance.franchiseEligibilityRule]!,
  'completionTrigger': _$CompletionTriggerEnumMap[instance.completionTrigger]!,
  'countdownSeconds': instance.countdownSeconds,
  'antiSnipeSeconds': instance.antiSnipeSeconds,
  'bidIncrementSlabs': instance.bidIncrementSlabs,
};

const _$CurrencyTypeEnumMap = {
  CurrencyType.points: 'POINTS',
  CurrencyType.cash: 'CASH',
  CurrencyType.unknown: 'unknown',
};

const _$PurseSourceEnumMap = {
  PurseSource.fresh: 'FRESH',
  PurseSource.carryOver: 'CARRY_OVER',
  PurseSource.unknown: 'unknown',
};

const _$BidModeEnumMap = {
  BidMode.finalBidOnly: 'FINAL_BID_ONLY',
  BidMode.eachBidRecorded: 'EACH_BID_RECORDED',
  BidMode.unknown: 'unknown',
};

const _$PlayerPoolSourceEnumMap = {
  PlayerPoolSource.allRegistered: 'ALL_REGISTERED',
  PlayerPoolSource.unsoldPreviousRound: 'UNSOLD_PREVIOUS_ROUND',
  PlayerPoolSource.unsoldAnyPreviousRound: 'UNSOLD_ANY_PREVIOUS_ROUND',
  PlayerPoolSource.auctioneerCurated: 'AUCTIONEER_CURATED',
  PlayerPoolSource.unknown: 'unknown',
};

const _$FranchiseEligibilityRuleEnumMap = {
  FranchiseEligibilityRule.all: 'ALL',
  FranchiseEligibilityRule.remainingPurseGreaterThanZero:
      'REMAINING_PURSE_GREATER_THAN_ZERO',
  FranchiseEligibilityRule.unknown: 'unknown',
};

const _$CompletionTriggerEnumMap = {
  CompletionTrigger.playerPoolExhausted: 'PLAYER_POOL_EXHAUSTED',
  CompletionTrigger.allPurseExhausted: 'ALL_PURSE_EXHAUSTED',
  CompletionTrigger.auctioneerManual: 'AUCTIONEER_MANUAL',
  CompletionTrigger.unknown: 'unknown',
};

_PlayerAuctionState _$PlayerAuctionStateFromJson(Map<String, dynamic> json) =>
    _PlayerAuctionState(
      id: json['id'] as String,
      auctionId: json['auctionId'] as String,
      leaguePlayerId: json['leaguePlayerId'] as String,
      state: $enumDecode(
        _$PlayerAuctionStateValueEnumMap,
        json['state'],
        unknownValue: PlayerAuctionStateValue.unknown,
      ),
      currentHighestBid: (json['currentHighestBid'] as num?)?.toInt(),
      currentHighestBidderId: json['currentHighestBidderId'] as String?,
      finalPrice: (json['finalPrice'] as num?)?.toInt(),
      soldToFranchiseId: json['soldToFranchiseId'] as String?,
      playerName: json['playerName'] as String?,
      playerCategory: json['playerCategory'] as String?,
      basePrice: (json['basePrice'] as num?)?.toInt(),
      playerPhoto: json['playerPhoto'] as String?,
    );

Map<String, dynamic> _$PlayerAuctionStateToJson(_PlayerAuctionState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'auctionId': instance.auctionId,
      'leaguePlayerId': instance.leaguePlayerId,
      'state': _$PlayerAuctionStateValueEnumMap[instance.state]!,
      'currentHighestBid': instance.currentHighestBid,
      'currentHighestBidderId': instance.currentHighestBidderId,
      'finalPrice': instance.finalPrice,
      'soldToFranchiseId': instance.soldToFranchiseId,
      'playerName': instance.playerName,
      'playerCategory': instance.playerCategory,
      'basePrice': instance.basePrice,
      'playerPhoto': instance.playerPhoto,
    };

const _$PlayerAuctionStateValueEnumMap = {
  PlayerAuctionStateValue.available: 'AVAILABLE',
  PlayerAuctionStateValue.upForBidding: 'UP_FOR_BIDDING',
  PlayerAuctionStateValue.sold: 'SOLD',
  PlayerAuctionStateValue.unsold: 'UNSOLD',
  PlayerAuctionStateValue.withdrawn: 'WITHDRAWN',
  PlayerAuctionStateValue.forceAssigned: 'FORCE_ASSIGNED',
  PlayerAuctionStateValue.preAssigned: 'PRE_ASSIGNED',
  PlayerAuctionStateValue.unknown: 'unknown',
};

_FranchisePurseState _$FranchisePurseStateFromJson(Map<String, dynamic> json) =>
    _FranchisePurseState(
      id: json['id'] as String,
      franchiseId: json['franchiseId'] as String,
      roundId: json['roundId'] as String?,
      currencyType: $enumDecodeNullable(
        _$CurrencyTypeEnumMap,
        json['currencyType'],
        unknownValue: CurrencyType.unknown,
      ),
      startingAmount: (json['startingAmount'] as num?)?.toInt(),
      currentAmount: (json['currentAmount'] as num).toInt(),
      reservedAmount: (json['reservedAmount'] as num).toInt(),
      franchiseName: json['franchiseName'] as String?,
      franchiseLogoUrl: json['franchiseLogoUrl'] as String?,
    );

Map<String, dynamic> _$FranchisePurseStateToJson(
  _FranchisePurseState instance,
) => <String, dynamic>{
  'id': instance.id,
  'franchiseId': instance.franchiseId,
  'roundId': instance.roundId,
  'currencyType': _$CurrencyTypeEnumMap[instance.currencyType],
  'startingAmount': instance.startingAmount,
  'currentAmount': instance.currentAmount,
  'reservedAmount': instance.reservedAmount,
  'franchiseName': instance.franchiseName,
  'franchiseLogoUrl': instance.franchiseLogoUrl,
};

_TimerState _$TimerStateFromJson(Map<String, dynamic> json) => _TimerState(
  isRunning: json['isRunning'] as bool,
  startedAt: json['startedAt'] == null
      ? null
      : DateTime.parse(json['startedAt'] as String),
  durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
  remainingSeconds: (json['remainingSeconds'] as num?)?.toInt(),
  antiSnipeSeconds: (json['antiSnipeSeconds'] as num).toInt(),
);

Map<String, dynamic> _$TimerStateToJson(_TimerState instance) =>
    <String, dynamic>{
      'isRunning': instance.isRunning,
      'startedAt': instance.startedAt?.toIso8601String(),
      'durationSeconds': instance.durationSeconds,
      'remainingSeconds': instance.remainingSeconds,
      'antiSnipeSeconds': instance.antiSnipeSeconds,
    };

_AuctionStateSnapshot _$AuctionStateSnapshotFromJson(
  Map<String, dynamic> json,
) => _AuctionStateSnapshot(
  leagueName: json['leagueName'] as String,
  auctionStatus: $enumDecode(
    _$AuctionStatusEnumMap,
    json['auctionStatus'],
    unknownValue: AuctionStatus.unknown,
  ),
  currentRound: json['currentRound'] == null
      ? null
      : RoundConfig.fromJson(json['currentRound'] as Map<String, dynamic>),
  currentPlayer: json['currentPlayer'] == null
      ? null
      : PlayerAuctionState.fromJson(
          json['currentPlayer'] as Map<String, dynamic>,
        ),
  currentHighestBid: (json['currentHighestBid'] as num?)?.toInt(),
  currentHighestBidderId: json['currentHighestBidderId'] as String?,
  franchisePurseStates:
      (json['franchisePurseStates'] as List<dynamic>?)
          ?.map((e) => FranchisePurseState.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <FranchisePurseState>[],
  timer: json['timer'] == null
      ? null
      : TimerState.fromJson(json['timer'] as Map<String, dynamic>),
  lastSequenceNumber: (json['lastSequenceNumber'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$AuctionStateSnapshotToJson(
  _AuctionStateSnapshot instance,
) => <String, dynamic>{
  'leagueName': instance.leagueName,
  'auctionStatus': _$AuctionStatusEnumMap[instance.auctionStatus]!,
  'currentRound': instance.currentRound,
  'currentPlayer': instance.currentPlayer,
  'currentHighestBid': instance.currentHighestBid,
  'currentHighestBidderId': instance.currentHighestBidderId,
  'franchisePurseStates': instance.franchisePurseStates,
  'timer': instance.timer,
  'lastSequenceNumber': instance.lastSequenceNumber,
};

const _$AuctionStatusEnumMap = {
  AuctionStatus.draft: 'DRAFT',
  AuctionStatus.live: 'LIVE',
  AuctionStatus.paused: 'PAUSED',
  AuctionStatus.completed: 'COMPLETED',
  AuctionStatus.cancelled: 'CANCELLED',
  AuctionStatus.unknown: 'unknown',
};
