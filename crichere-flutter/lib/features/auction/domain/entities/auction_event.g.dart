// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auction_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerUp _$PlayerUpFromJson(Map<String, dynamic> json) => PlayerUp(
  playerId: json['playerId'] as String,
  playerName: json['playerName'] as String,
  playerPhotoUrl: json['playerPhotoUrl'] as String?,
  basePrice: (json['basePrice'] as num).toInt(),
  bidIncrement: (json['bidIncrement'] as num?)?.toInt(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$PlayerUpToJson(PlayerUp instance) => <String, dynamic>{
  'playerId': instance.playerId,
  'playerName': instance.playerName,
  'playerPhotoUrl': instance.playerPhotoUrl,
  'basePrice': instance.basePrice,
  'bidIncrement': instance.bidIncrement,
  'runtimeType': instance.$type,
};

BidPlaced _$BidPlacedFromJson(Map<String, dynamic> json) => BidPlaced(
  franchiseId: json['franchiseId'] as String,
  franchiseName: json['franchiseName'] as String,
  amount: (json['amount'] as num).toInt(),
  nextMinimumBid: (json['nextMinimumBid'] as num?)?.toInt(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$BidPlacedToJson(BidPlaced instance) => <String, dynamic>{
  'franchiseId': instance.franchiseId,
  'franchiseName': instance.franchiseName,
  'amount': instance.amount,
  'nextMinimumBid': instance.nextMinimumBid,
  'runtimeType': instance.$type,
};

PlayerSold _$PlayerSoldFromJson(Map<String, dynamic> json) => PlayerSold(
  playerId: json['playerId'] as String,
  franchiseId: json['franchiseId'] as String,
  amount: (json['amount'] as num).toInt(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$PlayerSoldToJson(PlayerSold instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'franchiseId': instance.franchiseId,
      'amount': instance.amount,
      'runtimeType': instance.$type,
    };

BidUndone _$BidUndoneFromJson(Map<String, dynamic> json) =>
    BidUndone($type: json['runtimeType'] as String?);

Map<String, dynamic> _$BidUndoneToJson(BidUndone instance) => <String, dynamic>{
  'runtimeType': instance.$type,
};

SoldReverted _$SoldRevertedFromJson(Map<String, dynamic> json) =>
    SoldReverted($type: json['runtimeType'] as String?);

Map<String, dynamic> _$SoldRevertedToJson(SoldReverted instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

PlayerUnsold _$PlayerUnsoldFromJson(Map<String, dynamic> json) => PlayerUnsold(
  playerId: json['playerId'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$PlayerUnsoldToJson(PlayerUnsold instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'runtimeType': instance.$type,
    };

PlayerForceAssigned _$PlayerForceAssignedFromJson(Map<String, dynamic> json) =>
    PlayerForceAssigned(
      playerId: json['playerId'] as String,
      franchiseId: json['franchiseId'] as String,
      franchiseName: json['franchiseName'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$PlayerForceAssignedToJson(
  PlayerForceAssigned instance,
) => <String, dynamic>{
  'playerId': instance.playerId,
  'franchiseId': instance.franchiseId,
  'franchiseName': instance.franchiseName,
  'runtimeType': instance.$type,
};

TimerStarted _$TimerStartedFromJson(Map<String, dynamic> json) => TimerStarted(
  remainingSeconds: (json['remainingSeconds'] as num).toInt(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$TimerStartedToJson(TimerStarted instance) =>
    <String, dynamic>{
      'remainingSeconds': instance.remainingSeconds,
      'runtimeType': instance.$type,
    };

TimerPaused _$TimerPausedFromJson(Map<String, dynamic> json) => TimerPaused(
  remainingSeconds: (json['remainingSeconds'] as num).toInt(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$TimerPausedToJson(TimerPaused instance) =>
    <String, dynamic>{
      'remainingSeconds': instance.remainingSeconds,
      'runtimeType': instance.$type,
    };

TimerReset _$TimerResetFromJson(Map<String, dynamic> json) => TimerReset(
  remainingSeconds: (json['remainingSeconds'] as num).toInt(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$TimerResetToJson(TimerReset instance) =>
    <String, dynamic>{
      'remainingSeconds': instance.remainingSeconds,
      'runtimeType': instance.$type,
    };

RoundStarted _$RoundStartedFromJson(Map<String, dynamic> json) => RoundStarted(
  roundNumber: (json['roundNumber'] as num).toInt(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$RoundStartedToJson(RoundStarted instance) =>
    <String, dynamic>{
      'roundNumber': instance.roundNumber,
      'runtimeType': instance.$type,
    };

AuctionStarted _$AuctionStartedFromJson(Map<String, dynamic> json) =>
    AuctionStarted($type: json['runtimeType'] as String?);

Map<String, dynamic> _$AuctionStartedToJson(AuctionStarted instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

AuctionCompleted _$AuctionCompletedFromJson(Map<String, dynamic> json) =>
    AuctionCompleted($type: json['runtimeType'] as String?);

Map<String, dynamic> _$AuctionCompletedToJson(AuctionCompleted instance) =>
    <String, dynamic>{'runtimeType': instance.$type};
