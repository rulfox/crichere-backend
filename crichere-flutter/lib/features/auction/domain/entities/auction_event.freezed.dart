// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auction_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuctionEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuctionEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuctionEvent()';
}


}

/// @nodoc
class $AuctionEventCopyWith<$Res>  {
$AuctionEventCopyWith(AuctionEvent _, $Res Function(AuctionEvent) __);
}


/// Adds pattern-matching-related methods to [AuctionEvent].
extension AuctionEventPatterns on AuctionEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AuctionSnapshotEvent value)?  snapshot,TResult Function( PlayerUpEvent value)?  playerUp,TResult Function( BidPlacedEvent value)?  bidPlaced,TResult Function( BidUndoneEvent value)?  bidUndone,TResult Function( PlayerSoldEvent value)?  playerSold,TResult Function( SoldRevertedEvent value)?  soldReverted,TResult Function( PlayerUnsoldEvent value)?  playerUnsold,TResult Function( PlayerWithdrawnEvent value)?  playerWithdrawn,TResult Function( PlayerForceAssignedEvent value)?  playerForceAssigned,TResult Function( PlayerPreAssignedEvent value)?  playerPreAssigned,TResult Function( RoundStartedEvent value)?  roundStarted,TResult Function( RoundCompletedEvent value)?  roundCompleted,TResult Function( AuctionStartedEvent value)?  auctionStarted,TResult Function( AuctionPausedEvent value)?  auctionPaused,TResult Function( AuctionResumedEvent value)?  auctionResumed,TResult Function( AuctionCompletedEvent value)?  auctionCompleted,TResult Function( AuctionCancelledEvent value)?  auctionCancelled,TResult Function( TimerStartedEvent value)?  timerStarted,TResult Function( TimerStoppedEvent value)?  timerStopped,TResult Function( TimerResetEvent value)?  timerReset,TResult Function( TimerExtendedEvent value)?  timerExtended,TResult Function( UnknownAuctionEvent value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AuctionSnapshotEvent() when snapshot != null:
return snapshot(_that);case PlayerUpEvent() when playerUp != null:
return playerUp(_that);case BidPlacedEvent() when bidPlaced != null:
return bidPlaced(_that);case BidUndoneEvent() when bidUndone != null:
return bidUndone(_that);case PlayerSoldEvent() when playerSold != null:
return playerSold(_that);case SoldRevertedEvent() when soldReverted != null:
return soldReverted(_that);case PlayerUnsoldEvent() when playerUnsold != null:
return playerUnsold(_that);case PlayerWithdrawnEvent() when playerWithdrawn != null:
return playerWithdrawn(_that);case PlayerForceAssignedEvent() when playerForceAssigned != null:
return playerForceAssigned(_that);case PlayerPreAssignedEvent() when playerPreAssigned != null:
return playerPreAssigned(_that);case RoundStartedEvent() when roundStarted != null:
return roundStarted(_that);case RoundCompletedEvent() when roundCompleted != null:
return roundCompleted(_that);case AuctionStartedEvent() when auctionStarted != null:
return auctionStarted(_that);case AuctionPausedEvent() when auctionPaused != null:
return auctionPaused(_that);case AuctionResumedEvent() when auctionResumed != null:
return auctionResumed(_that);case AuctionCompletedEvent() when auctionCompleted != null:
return auctionCompleted(_that);case AuctionCancelledEvent() when auctionCancelled != null:
return auctionCancelled(_that);case TimerStartedEvent() when timerStarted != null:
return timerStarted(_that);case TimerStoppedEvent() when timerStopped != null:
return timerStopped(_that);case TimerResetEvent() when timerReset != null:
return timerReset(_that);case TimerExtendedEvent() when timerExtended != null:
return timerExtended(_that);case UnknownAuctionEvent() when unknown != null:
return unknown(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AuctionSnapshotEvent value)  snapshot,required TResult Function( PlayerUpEvent value)  playerUp,required TResult Function( BidPlacedEvent value)  bidPlaced,required TResult Function( BidUndoneEvent value)  bidUndone,required TResult Function( PlayerSoldEvent value)  playerSold,required TResult Function( SoldRevertedEvent value)  soldReverted,required TResult Function( PlayerUnsoldEvent value)  playerUnsold,required TResult Function( PlayerWithdrawnEvent value)  playerWithdrawn,required TResult Function( PlayerForceAssignedEvent value)  playerForceAssigned,required TResult Function( PlayerPreAssignedEvent value)  playerPreAssigned,required TResult Function( RoundStartedEvent value)  roundStarted,required TResult Function( RoundCompletedEvent value)  roundCompleted,required TResult Function( AuctionStartedEvent value)  auctionStarted,required TResult Function( AuctionPausedEvent value)  auctionPaused,required TResult Function( AuctionResumedEvent value)  auctionResumed,required TResult Function( AuctionCompletedEvent value)  auctionCompleted,required TResult Function( AuctionCancelledEvent value)  auctionCancelled,required TResult Function( TimerStartedEvent value)  timerStarted,required TResult Function( TimerStoppedEvent value)  timerStopped,required TResult Function( TimerResetEvent value)  timerReset,required TResult Function( TimerExtendedEvent value)  timerExtended,required TResult Function( UnknownAuctionEvent value)  unknown,}){
final _that = this;
switch (_that) {
case AuctionSnapshotEvent():
return snapshot(_that);case PlayerUpEvent():
return playerUp(_that);case BidPlacedEvent():
return bidPlaced(_that);case BidUndoneEvent():
return bidUndone(_that);case PlayerSoldEvent():
return playerSold(_that);case SoldRevertedEvent():
return soldReverted(_that);case PlayerUnsoldEvent():
return playerUnsold(_that);case PlayerWithdrawnEvent():
return playerWithdrawn(_that);case PlayerForceAssignedEvent():
return playerForceAssigned(_that);case PlayerPreAssignedEvent():
return playerPreAssigned(_that);case RoundStartedEvent():
return roundStarted(_that);case RoundCompletedEvent():
return roundCompleted(_that);case AuctionStartedEvent():
return auctionStarted(_that);case AuctionPausedEvent():
return auctionPaused(_that);case AuctionResumedEvent():
return auctionResumed(_that);case AuctionCompletedEvent():
return auctionCompleted(_that);case AuctionCancelledEvent():
return auctionCancelled(_that);case TimerStartedEvent():
return timerStarted(_that);case TimerStoppedEvent():
return timerStopped(_that);case TimerResetEvent():
return timerReset(_that);case TimerExtendedEvent():
return timerExtended(_that);case UnknownAuctionEvent():
return unknown(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AuctionSnapshotEvent value)?  snapshot,TResult? Function( PlayerUpEvent value)?  playerUp,TResult? Function( BidPlacedEvent value)?  bidPlaced,TResult? Function( BidUndoneEvent value)?  bidUndone,TResult? Function( PlayerSoldEvent value)?  playerSold,TResult? Function( SoldRevertedEvent value)?  soldReverted,TResult? Function( PlayerUnsoldEvent value)?  playerUnsold,TResult? Function( PlayerWithdrawnEvent value)?  playerWithdrawn,TResult? Function( PlayerForceAssignedEvent value)?  playerForceAssigned,TResult? Function( PlayerPreAssignedEvent value)?  playerPreAssigned,TResult? Function( RoundStartedEvent value)?  roundStarted,TResult? Function( RoundCompletedEvent value)?  roundCompleted,TResult? Function( AuctionStartedEvent value)?  auctionStarted,TResult? Function( AuctionPausedEvent value)?  auctionPaused,TResult? Function( AuctionResumedEvent value)?  auctionResumed,TResult? Function( AuctionCompletedEvent value)?  auctionCompleted,TResult? Function( AuctionCancelledEvent value)?  auctionCancelled,TResult? Function( TimerStartedEvent value)?  timerStarted,TResult? Function( TimerStoppedEvent value)?  timerStopped,TResult? Function( TimerResetEvent value)?  timerReset,TResult? Function( TimerExtendedEvent value)?  timerExtended,TResult? Function( UnknownAuctionEvent value)?  unknown,}){
final _that = this;
switch (_that) {
case AuctionSnapshotEvent() when snapshot != null:
return snapshot(_that);case PlayerUpEvent() when playerUp != null:
return playerUp(_that);case BidPlacedEvent() when bidPlaced != null:
return bidPlaced(_that);case BidUndoneEvent() when bidUndone != null:
return bidUndone(_that);case PlayerSoldEvent() when playerSold != null:
return playerSold(_that);case SoldRevertedEvent() when soldReverted != null:
return soldReverted(_that);case PlayerUnsoldEvent() when playerUnsold != null:
return playerUnsold(_that);case PlayerWithdrawnEvent() when playerWithdrawn != null:
return playerWithdrawn(_that);case PlayerForceAssignedEvent() when playerForceAssigned != null:
return playerForceAssigned(_that);case PlayerPreAssignedEvent() when playerPreAssigned != null:
return playerPreAssigned(_that);case RoundStartedEvent() when roundStarted != null:
return roundStarted(_that);case RoundCompletedEvent() when roundCompleted != null:
return roundCompleted(_that);case AuctionStartedEvent() when auctionStarted != null:
return auctionStarted(_that);case AuctionPausedEvent() when auctionPaused != null:
return auctionPaused(_that);case AuctionResumedEvent() when auctionResumed != null:
return auctionResumed(_that);case AuctionCompletedEvent() when auctionCompleted != null:
return auctionCompleted(_that);case AuctionCancelledEvent() when auctionCancelled != null:
return auctionCancelled(_that);case TimerStartedEvent() when timerStarted != null:
return timerStarted(_that);case TimerStoppedEvent() when timerStopped != null:
return timerStopped(_that);case TimerResetEvent() when timerReset != null:
return timerReset(_that);case TimerExtendedEvent() when timerExtended != null:
return timerExtended(_that);case UnknownAuctionEvent() when unknown != null:
return unknown(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( AuctionStateSnapshot snapshot)?  snapshot,TResult Function( String leaguePlayerId,  String? playerName,  int? basePrice,  String? roundId)?  playerUp,TResult Function( String leaguePlayerId,  String franchiseId,  int bidAmount,  int? previousHighestBid,  String? previousHighestBidder)?  bidPlaced,TResult Function( String leaguePlayerId,  String? undoneBidId,  int? undoneAmount,  String? undoneFranchiseId,  int? newHighestBid,  String? newHighestBidder,  String? reason)?  bidUndone,TResult Function( String leaguePlayerId,  String franchiseId,  int finalPrice,  String? roundId)?  playerSold,TResult Function( String leaguePlayerId,  String? revertedFromFranchiseId,  int? restoredAmount,  String? reason)?  soldReverted,TResult Function( String leaguePlayerId,  String? roundId)?  playerUnsold,TResult Function( String leaguePlayerId,  String? reason)?  playerWithdrawn,TResult Function( String leaguePlayerId,  String franchiseId,  int? price,  String? assignedBy)?  playerForceAssigned,TResult Function( String leaguePlayerId,  String franchiseId,  int? price,  String? assignmentType,  String? assignedBy)?  playerPreAssigned,TResult Function( String roundId,  int? roundNumber)?  roundStarted,TResult Function( String roundId,  int? soldCount,  int? unsoldCount)?  roundCompleted,TResult Function( DateTime? startedAt)?  auctionStarted,TResult Function( String? reason)?  auctionPaused,TResult Function()?  auctionResumed,TResult Function( int? totalSold,  int? totalUnsold,  int? totalSpent,  DateTime? completedAt)?  auctionCompleted,TResult Function( String? reason)?  auctionCancelled,TResult Function( int? durationSeconds,  DateTime? startedAt,  int? antiSnipeSeconds,  String? leaguePlayerId)?  timerStarted,TResult Function()?  timerStopped,TResult Function( int? newDurationSeconds,  DateTime? startedAt,  String? reason,  String? leaguePlayerId)?  timerReset,TResult Function( int? addedSeconds,  int? newDurationSeconds)?  timerExtended,TResult Function( String event,  Map<String, dynamic> data)?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AuctionSnapshotEvent() when snapshot != null:
return snapshot(_that.snapshot);case PlayerUpEvent() when playerUp != null:
return playerUp(_that.leaguePlayerId,_that.playerName,_that.basePrice,_that.roundId);case BidPlacedEvent() when bidPlaced != null:
return bidPlaced(_that.leaguePlayerId,_that.franchiseId,_that.bidAmount,_that.previousHighestBid,_that.previousHighestBidder);case BidUndoneEvent() when bidUndone != null:
return bidUndone(_that.leaguePlayerId,_that.undoneBidId,_that.undoneAmount,_that.undoneFranchiseId,_that.newHighestBid,_that.newHighestBidder,_that.reason);case PlayerSoldEvent() when playerSold != null:
return playerSold(_that.leaguePlayerId,_that.franchiseId,_that.finalPrice,_that.roundId);case SoldRevertedEvent() when soldReverted != null:
return soldReverted(_that.leaguePlayerId,_that.revertedFromFranchiseId,_that.restoredAmount,_that.reason);case PlayerUnsoldEvent() when playerUnsold != null:
return playerUnsold(_that.leaguePlayerId,_that.roundId);case PlayerWithdrawnEvent() when playerWithdrawn != null:
return playerWithdrawn(_that.leaguePlayerId,_that.reason);case PlayerForceAssignedEvent() when playerForceAssigned != null:
return playerForceAssigned(_that.leaguePlayerId,_that.franchiseId,_that.price,_that.assignedBy);case PlayerPreAssignedEvent() when playerPreAssigned != null:
return playerPreAssigned(_that.leaguePlayerId,_that.franchiseId,_that.price,_that.assignmentType,_that.assignedBy);case RoundStartedEvent() when roundStarted != null:
return roundStarted(_that.roundId,_that.roundNumber);case RoundCompletedEvent() when roundCompleted != null:
return roundCompleted(_that.roundId,_that.soldCount,_that.unsoldCount);case AuctionStartedEvent() when auctionStarted != null:
return auctionStarted(_that.startedAt);case AuctionPausedEvent() when auctionPaused != null:
return auctionPaused(_that.reason);case AuctionResumedEvent() when auctionResumed != null:
return auctionResumed();case AuctionCompletedEvent() when auctionCompleted != null:
return auctionCompleted(_that.totalSold,_that.totalUnsold,_that.totalSpent,_that.completedAt);case AuctionCancelledEvent() when auctionCancelled != null:
return auctionCancelled(_that.reason);case TimerStartedEvent() when timerStarted != null:
return timerStarted(_that.durationSeconds,_that.startedAt,_that.antiSnipeSeconds,_that.leaguePlayerId);case TimerStoppedEvent() when timerStopped != null:
return timerStopped();case TimerResetEvent() when timerReset != null:
return timerReset(_that.newDurationSeconds,_that.startedAt,_that.reason,_that.leaguePlayerId);case TimerExtendedEvent() when timerExtended != null:
return timerExtended(_that.addedSeconds,_that.newDurationSeconds);case UnknownAuctionEvent() when unknown != null:
return unknown(_that.event,_that.data);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( AuctionStateSnapshot snapshot)  snapshot,required TResult Function( String leaguePlayerId,  String? playerName,  int? basePrice,  String? roundId)  playerUp,required TResult Function( String leaguePlayerId,  String franchiseId,  int bidAmount,  int? previousHighestBid,  String? previousHighestBidder)  bidPlaced,required TResult Function( String leaguePlayerId,  String? undoneBidId,  int? undoneAmount,  String? undoneFranchiseId,  int? newHighestBid,  String? newHighestBidder,  String? reason)  bidUndone,required TResult Function( String leaguePlayerId,  String franchiseId,  int finalPrice,  String? roundId)  playerSold,required TResult Function( String leaguePlayerId,  String? revertedFromFranchiseId,  int? restoredAmount,  String? reason)  soldReverted,required TResult Function( String leaguePlayerId,  String? roundId)  playerUnsold,required TResult Function( String leaguePlayerId,  String? reason)  playerWithdrawn,required TResult Function( String leaguePlayerId,  String franchiseId,  int? price,  String? assignedBy)  playerForceAssigned,required TResult Function( String leaguePlayerId,  String franchiseId,  int? price,  String? assignmentType,  String? assignedBy)  playerPreAssigned,required TResult Function( String roundId,  int? roundNumber)  roundStarted,required TResult Function( String roundId,  int? soldCount,  int? unsoldCount)  roundCompleted,required TResult Function( DateTime? startedAt)  auctionStarted,required TResult Function( String? reason)  auctionPaused,required TResult Function()  auctionResumed,required TResult Function( int? totalSold,  int? totalUnsold,  int? totalSpent,  DateTime? completedAt)  auctionCompleted,required TResult Function( String? reason)  auctionCancelled,required TResult Function( int? durationSeconds,  DateTime? startedAt,  int? antiSnipeSeconds,  String? leaguePlayerId)  timerStarted,required TResult Function()  timerStopped,required TResult Function( int? newDurationSeconds,  DateTime? startedAt,  String? reason,  String? leaguePlayerId)  timerReset,required TResult Function( int? addedSeconds,  int? newDurationSeconds)  timerExtended,required TResult Function( String event,  Map<String, dynamic> data)  unknown,}) {final _that = this;
switch (_that) {
case AuctionSnapshotEvent():
return snapshot(_that.snapshot);case PlayerUpEvent():
return playerUp(_that.leaguePlayerId,_that.playerName,_that.basePrice,_that.roundId);case BidPlacedEvent():
return bidPlaced(_that.leaguePlayerId,_that.franchiseId,_that.bidAmount,_that.previousHighestBid,_that.previousHighestBidder);case BidUndoneEvent():
return bidUndone(_that.leaguePlayerId,_that.undoneBidId,_that.undoneAmount,_that.undoneFranchiseId,_that.newHighestBid,_that.newHighestBidder,_that.reason);case PlayerSoldEvent():
return playerSold(_that.leaguePlayerId,_that.franchiseId,_that.finalPrice,_that.roundId);case SoldRevertedEvent():
return soldReverted(_that.leaguePlayerId,_that.revertedFromFranchiseId,_that.restoredAmount,_that.reason);case PlayerUnsoldEvent():
return playerUnsold(_that.leaguePlayerId,_that.roundId);case PlayerWithdrawnEvent():
return playerWithdrawn(_that.leaguePlayerId,_that.reason);case PlayerForceAssignedEvent():
return playerForceAssigned(_that.leaguePlayerId,_that.franchiseId,_that.price,_that.assignedBy);case PlayerPreAssignedEvent():
return playerPreAssigned(_that.leaguePlayerId,_that.franchiseId,_that.price,_that.assignmentType,_that.assignedBy);case RoundStartedEvent():
return roundStarted(_that.roundId,_that.roundNumber);case RoundCompletedEvent():
return roundCompleted(_that.roundId,_that.soldCount,_that.unsoldCount);case AuctionStartedEvent():
return auctionStarted(_that.startedAt);case AuctionPausedEvent():
return auctionPaused(_that.reason);case AuctionResumedEvent():
return auctionResumed();case AuctionCompletedEvent():
return auctionCompleted(_that.totalSold,_that.totalUnsold,_that.totalSpent,_that.completedAt);case AuctionCancelledEvent():
return auctionCancelled(_that.reason);case TimerStartedEvent():
return timerStarted(_that.durationSeconds,_that.startedAt,_that.antiSnipeSeconds,_that.leaguePlayerId);case TimerStoppedEvent():
return timerStopped();case TimerResetEvent():
return timerReset(_that.newDurationSeconds,_that.startedAt,_that.reason,_that.leaguePlayerId);case TimerExtendedEvent():
return timerExtended(_that.addedSeconds,_that.newDurationSeconds);case UnknownAuctionEvent():
return unknown(_that.event,_that.data);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( AuctionStateSnapshot snapshot)?  snapshot,TResult? Function( String leaguePlayerId,  String? playerName,  int? basePrice,  String? roundId)?  playerUp,TResult? Function( String leaguePlayerId,  String franchiseId,  int bidAmount,  int? previousHighestBid,  String? previousHighestBidder)?  bidPlaced,TResult? Function( String leaguePlayerId,  String? undoneBidId,  int? undoneAmount,  String? undoneFranchiseId,  int? newHighestBid,  String? newHighestBidder,  String? reason)?  bidUndone,TResult? Function( String leaguePlayerId,  String franchiseId,  int finalPrice,  String? roundId)?  playerSold,TResult? Function( String leaguePlayerId,  String? revertedFromFranchiseId,  int? restoredAmount,  String? reason)?  soldReverted,TResult? Function( String leaguePlayerId,  String? roundId)?  playerUnsold,TResult? Function( String leaguePlayerId,  String? reason)?  playerWithdrawn,TResult? Function( String leaguePlayerId,  String franchiseId,  int? price,  String? assignedBy)?  playerForceAssigned,TResult? Function( String leaguePlayerId,  String franchiseId,  int? price,  String? assignmentType,  String? assignedBy)?  playerPreAssigned,TResult? Function( String roundId,  int? roundNumber)?  roundStarted,TResult? Function( String roundId,  int? soldCount,  int? unsoldCount)?  roundCompleted,TResult? Function( DateTime? startedAt)?  auctionStarted,TResult? Function( String? reason)?  auctionPaused,TResult? Function()?  auctionResumed,TResult? Function( int? totalSold,  int? totalUnsold,  int? totalSpent,  DateTime? completedAt)?  auctionCompleted,TResult? Function( String? reason)?  auctionCancelled,TResult? Function( int? durationSeconds,  DateTime? startedAt,  int? antiSnipeSeconds,  String? leaguePlayerId)?  timerStarted,TResult? Function()?  timerStopped,TResult? Function( int? newDurationSeconds,  DateTime? startedAt,  String? reason,  String? leaguePlayerId)?  timerReset,TResult? Function( int? addedSeconds,  int? newDurationSeconds)?  timerExtended,TResult? Function( String event,  Map<String, dynamic> data)?  unknown,}) {final _that = this;
switch (_that) {
case AuctionSnapshotEvent() when snapshot != null:
return snapshot(_that.snapshot);case PlayerUpEvent() when playerUp != null:
return playerUp(_that.leaguePlayerId,_that.playerName,_that.basePrice,_that.roundId);case BidPlacedEvent() when bidPlaced != null:
return bidPlaced(_that.leaguePlayerId,_that.franchiseId,_that.bidAmount,_that.previousHighestBid,_that.previousHighestBidder);case BidUndoneEvent() when bidUndone != null:
return bidUndone(_that.leaguePlayerId,_that.undoneBidId,_that.undoneAmount,_that.undoneFranchiseId,_that.newHighestBid,_that.newHighestBidder,_that.reason);case PlayerSoldEvent() when playerSold != null:
return playerSold(_that.leaguePlayerId,_that.franchiseId,_that.finalPrice,_that.roundId);case SoldRevertedEvent() when soldReverted != null:
return soldReverted(_that.leaguePlayerId,_that.revertedFromFranchiseId,_that.restoredAmount,_that.reason);case PlayerUnsoldEvent() when playerUnsold != null:
return playerUnsold(_that.leaguePlayerId,_that.roundId);case PlayerWithdrawnEvent() when playerWithdrawn != null:
return playerWithdrawn(_that.leaguePlayerId,_that.reason);case PlayerForceAssignedEvent() when playerForceAssigned != null:
return playerForceAssigned(_that.leaguePlayerId,_that.franchiseId,_that.price,_that.assignedBy);case PlayerPreAssignedEvent() when playerPreAssigned != null:
return playerPreAssigned(_that.leaguePlayerId,_that.franchiseId,_that.price,_that.assignmentType,_that.assignedBy);case RoundStartedEvent() when roundStarted != null:
return roundStarted(_that.roundId,_that.roundNumber);case RoundCompletedEvent() when roundCompleted != null:
return roundCompleted(_that.roundId,_that.soldCount,_that.unsoldCount);case AuctionStartedEvent() when auctionStarted != null:
return auctionStarted(_that.startedAt);case AuctionPausedEvent() when auctionPaused != null:
return auctionPaused(_that.reason);case AuctionResumedEvent() when auctionResumed != null:
return auctionResumed();case AuctionCompletedEvent() when auctionCompleted != null:
return auctionCompleted(_that.totalSold,_that.totalUnsold,_that.totalSpent,_that.completedAt);case AuctionCancelledEvent() when auctionCancelled != null:
return auctionCancelled(_that.reason);case TimerStartedEvent() when timerStarted != null:
return timerStarted(_that.durationSeconds,_that.startedAt,_that.antiSnipeSeconds,_that.leaguePlayerId);case TimerStoppedEvent() when timerStopped != null:
return timerStopped();case TimerResetEvent() when timerReset != null:
return timerReset(_that.newDurationSeconds,_that.startedAt,_that.reason,_that.leaguePlayerId);case TimerExtendedEvent() when timerExtended != null:
return timerExtended(_that.addedSeconds,_that.newDurationSeconds);case UnknownAuctionEvent() when unknown != null:
return unknown(_that.event,_that.data);case _:
  return null;

}
}

}

/// @nodoc


class AuctionSnapshotEvent extends AuctionEvent {
  const AuctionSnapshotEvent(this.snapshot): super._();
  

 final  AuctionStateSnapshot snapshot;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuctionSnapshotEventCopyWith<AuctionSnapshotEvent> get copyWith => _$AuctionSnapshotEventCopyWithImpl<AuctionSnapshotEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuctionSnapshotEvent&&(identical(other.snapshot, snapshot) || other.snapshot == snapshot));
}


@override
int get hashCode => Object.hash(runtimeType,snapshot);

@override
String toString() {
  return 'AuctionEvent.snapshot(snapshot: $snapshot)';
}


}

/// @nodoc
abstract mixin class $AuctionSnapshotEventCopyWith<$Res> implements $AuctionEventCopyWith<$Res> {
  factory $AuctionSnapshotEventCopyWith(AuctionSnapshotEvent value, $Res Function(AuctionSnapshotEvent) _then) = _$AuctionSnapshotEventCopyWithImpl;
@useResult
$Res call({
 AuctionStateSnapshot snapshot
});


$AuctionStateSnapshotCopyWith<$Res> get snapshot;

}
/// @nodoc
class _$AuctionSnapshotEventCopyWithImpl<$Res>
    implements $AuctionSnapshotEventCopyWith<$Res> {
  _$AuctionSnapshotEventCopyWithImpl(this._self, this._then);

  final AuctionSnapshotEvent _self;
  final $Res Function(AuctionSnapshotEvent) _then;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? snapshot = null,}) {
  return _then(AuctionSnapshotEvent(
null == snapshot ? _self.snapshot : snapshot // ignore: cast_nullable_to_non_nullable
as AuctionStateSnapshot,
  ));
}

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuctionStateSnapshotCopyWith<$Res> get snapshot {
  
  return $AuctionStateSnapshotCopyWith<$Res>(_self.snapshot, (value) {
    return _then(_self.copyWith(snapshot: value));
  });
}
}

/// @nodoc


class PlayerUpEvent extends AuctionEvent {
  const PlayerUpEvent({required this.leaguePlayerId, this.playerName, this.basePrice, this.roundId}): super._();
  

 final  String leaguePlayerId;
 final  String? playerName;
 final  int? basePrice;
 final  String? roundId;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerUpEventCopyWith<PlayerUpEvent> get copyWith => _$PlayerUpEventCopyWithImpl<PlayerUpEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerUpEvent&&(identical(other.leaguePlayerId, leaguePlayerId) || other.leaguePlayerId == leaguePlayerId)&&(identical(other.playerName, playerName) || other.playerName == playerName)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.roundId, roundId) || other.roundId == roundId));
}


@override
int get hashCode => Object.hash(runtimeType,leaguePlayerId,playerName,basePrice,roundId);

@override
String toString() {
  return 'AuctionEvent.playerUp(leaguePlayerId: $leaguePlayerId, playerName: $playerName, basePrice: $basePrice, roundId: $roundId)';
}


}

/// @nodoc
abstract mixin class $PlayerUpEventCopyWith<$Res> implements $AuctionEventCopyWith<$Res> {
  factory $PlayerUpEventCopyWith(PlayerUpEvent value, $Res Function(PlayerUpEvent) _then) = _$PlayerUpEventCopyWithImpl;
@useResult
$Res call({
 String leaguePlayerId, String? playerName, int? basePrice, String? roundId
});




}
/// @nodoc
class _$PlayerUpEventCopyWithImpl<$Res>
    implements $PlayerUpEventCopyWith<$Res> {
  _$PlayerUpEventCopyWithImpl(this._self, this._then);

  final PlayerUpEvent _self;
  final $Res Function(PlayerUpEvent) _then;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? leaguePlayerId = null,Object? playerName = freezed,Object? basePrice = freezed,Object? roundId = freezed,}) {
  return _then(PlayerUpEvent(
leaguePlayerId: null == leaguePlayerId ? _self.leaguePlayerId : leaguePlayerId // ignore: cast_nullable_to_non_nullable
as String,playerName: freezed == playerName ? _self.playerName : playerName // ignore: cast_nullable_to_non_nullable
as String?,basePrice: freezed == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as int?,roundId: freezed == roundId ? _self.roundId : roundId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class BidPlacedEvent extends AuctionEvent {
  const BidPlacedEvent({required this.leaguePlayerId, required this.franchiseId, required this.bidAmount, this.previousHighestBid, this.previousHighestBidder}): super._();
  

 final  String leaguePlayerId;
 final  String franchiseId;
 final  int bidAmount;
 final  int? previousHighestBid;
 final  String? previousHighestBidder;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BidPlacedEventCopyWith<BidPlacedEvent> get copyWith => _$BidPlacedEventCopyWithImpl<BidPlacedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BidPlacedEvent&&(identical(other.leaguePlayerId, leaguePlayerId) || other.leaguePlayerId == leaguePlayerId)&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.bidAmount, bidAmount) || other.bidAmount == bidAmount)&&(identical(other.previousHighestBid, previousHighestBid) || other.previousHighestBid == previousHighestBid)&&(identical(other.previousHighestBidder, previousHighestBidder) || other.previousHighestBidder == previousHighestBidder));
}


@override
int get hashCode => Object.hash(runtimeType,leaguePlayerId,franchiseId,bidAmount,previousHighestBid,previousHighestBidder);

@override
String toString() {
  return 'AuctionEvent.bidPlaced(leaguePlayerId: $leaguePlayerId, franchiseId: $franchiseId, bidAmount: $bidAmount, previousHighestBid: $previousHighestBid, previousHighestBidder: $previousHighestBidder)';
}


}

/// @nodoc
abstract mixin class $BidPlacedEventCopyWith<$Res> implements $AuctionEventCopyWith<$Res> {
  factory $BidPlacedEventCopyWith(BidPlacedEvent value, $Res Function(BidPlacedEvent) _then) = _$BidPlacedEventCopyWithImpl;
@useResult
$Res call({
 String leaguePlayerId, String franchiseId, int bidAmount, int? previousHighestBid, String? previousHighestBidder
});




}
/// @nodoc
class _$BidPlacedEventCopyWithImpl<$Res>
    implements $BidPlacedEventCopyWith<$Res> {
  _$BidPlacedEventCopyWithImpl(this._self, this._then);

  final BidPlacedEvent _self;
  final $Res Function(BidPlacedEvent) _then;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? leaguePlayerId = null,Object? franchiseId = null,Object? bidAmount = null,Object? previousHighestBid = freezed,Object? previousHighestBidder = freezed,}) {
  return _then(BidPlacedEvent(
leaguePlayerId: null == leaguePlayerId ? _self.leaguePlayerId : leaguePlayerId // ignore: cast_nullable_to_non_nullable
as String,franchiseId: null == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String,bidAmount: null == bidAmount ? _self.bidAmount : bidAmount // ignore: cast_nullable_to_non_nullable
as int,previousHighestBid: freezed == previousHighestBid ? _self.previousHighestBid : previousHighestBid // ignore: cast_nullable_to_non_nullable
as int?,previousHighestBidder: freezed == previousHighestBidder ? _self.previousHighestBidder : previousHighestBidder // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class BidUndoneEvent extends AuctionEvent {
  const BidUndoneEvent({required this.leaguePlayerId, this.undoneBidId, this.undoneAmount, this.undoneFranchiseId, this.newHighestBid, this.newHighestBidder, this.reason}): super._();
  

 final  String leaguePlayerId;
 final  String? undoneBidId;
 final  int? undoneAmount;
 final  String? undoneFranchiseId;
 final  int? newHighestBid;
 final  String? newHighestBidder;
 final  String? reason;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BidUndoneEventCopyWith<BidUndoneEvent> get copyWith => _$BidUndoneEventCopyWithImpl<BidUndoneEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BidUndoneEvent&&(identical(other.leaguePlayerId, leaguePlayerId) || other.leaguePlayerId == leaguePlayerId)&&(identical(other.undoneBidId, undoneBidId) || other.undoneBidId == undoneBidId)&&(identical(other.undoneAmount, undoneAmount) || other.undoneAmount == undoneAmount)&&(identical(other.undoneFranchiseId, undoneFranchiseId) || other.undoneFranchiseId == undoneFranchiseId)&&(identical(other.newHighestBid, newHighestBid) || other.newHighestBid == newHighestBid)&&(identical(other.newHighestBidder, newHighestBidder) || other.newHighestBidder == newHighestBidder)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,leaguePlayerId,undoneBidId,undoneAmount,undoneFranchiseId,newHighestBid,newHighestBidder,reason);

@override
String toString() {
  return 'AuctionEvent.bidUndone(leaguePlayerId: $leaguePlayerId, undoneBidId: $undoneBidId, undoneAmount: $undoneAmount, undoneFranchiseId: $undoneFranchiseId, newHighestBid: $newHighestBid, newHighestBidder: $newHighestBidder, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $BidUndoneEventCopyWith<$Res> implements $AuctionEventCopyWith<$Res> {
  factory $BidUndoneEventCopyWith(BidUndoneEvent value, $Res Function(BidUndoneEvent) _then) = _$BidUndoneEventCopyWithImpl;
@useResult
$Res call({
 String leaguePlayerId, String? undoneBidId, int? undoneAmount, String? undoneFranchiseId, int? newHighestBid, String? newHighestBidder, String? reason
});




}
/// @nodoc
class _$BidUndoneEventCopyWithImpl<$Res>
    implements $BidUndoneEventCopyWith<$Res> {
  _$BidUndoneEventCopyWithImpl(this._self, this._then);

  final BidUndoneEvent _self;
  final $Res Function(BidUndoneEvent) _then;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? leaguePlayerId = null,Object? undoneBidId = freezed,Object? undoneAmount = freezed,Object? undoneFranchiseId = freezed,Object? newHighestBid = freezed,Object? newHighestBidder = freezed,Object? reason = freezed,}) {
  return _then(BidUndoneEvent(
leaguePlayerId: null == leaguePlayerId ? _self.leaguePlayerId : leaguePlayerId // ignore: cast_nullable_to_non_nullable
as String,undoneBidId: freezed == undoneBidId ? _self.undoneBidId : undoneBidId // ignore: cast_nullable_to_non_nullable
as String?,undoneAmount: freezed == undoneAmount ? _self.undoneAmount : undoneAmount // ignore: cast_nullable_to_non_nullable
as int?,undoneFranchiseId: freezed == undoneFranchiseId ? _self.undoneFranchiseId : undoneFranchiseId // ignore: cast_nullable_to_non_nullable
as String?,newHighestBid: freezed == newHighestBid ? _self.newHighestBid : newHighestBid // ignore: cast_nullable_to_non_nullable
as int?,newHighestBidder: freezed == newHighestBidder ? _self.newHighestBidder : newHighestBidder // ignore: cast_nullable_to_non_nullable
as String?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class PlayerSoldEvent extends AuctionEvent {
  const PlayerSoldEvent({required this.leaguePlayerId, required this.franchiseId, required this.finalPrice, this.roundId}): super._();
  

 final  String leaguePlayerId;
 final  String franchiseId;
 final  int finalPrice;
 final  String? roundId;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerSoldEventCopyWith<PlayerSoldEvent> get copyWith => _$PlayerSoldEventCopyWithImpl<PlayerSoldEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerSoldEvent&&(identical(other.leaguePlayerId, leaguePlayerId) || other.leaguePlayerId == leaguePlayerId)&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.finalPrice, finalPrice) || other.finalPrice == finalPrice)&&(identical(other.roundId, roundId) || other.roundId == roundId));
}


@override
int get hashCode => Object.hash(runtimeType,leaguePlayerId,franchiseId,finalPrice,roundId);

@override
String toString() {
  return 'AuctionEvent.playerSold(leaguePlayerId: $leaguePlayerId, franchiseId: $franchiseId, finalPrice: $finalPrice, roundId: $roundId)';
}


}

/// @nodoc
abstract mixin class $PlayerSoldEventCopyWith<$Res> implements $AuctionEventCopyWith<$Res> {
  factory $PlayerSoldEventCopyWith(PlayerSoldEvent value, $Res Function(PlayerSoldEvent) _then) = _$PlayerSoldEventCopyWithImpl;
@useResult
$Res call({
 String leaguePlayerId, String franchiseId, int finalPrice, String? roundId
});




}
/// @nodoc
class _$PlayerSoldEventCopyWithImpl<$Res>
    implements $PlayerSoldEventCopyWith<$Res> {
  _$PlayerSoldEventCopyWithImpl(this._self, this._then);

  final PlayerSoldEvent _self;
  final $Res Function(PlayerSoldEvent) _then;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? leaguePlayerId = null,Object? franchiseId = null,Object? finalPrice = null,Object? roundId = freezed,}) {
  return _then(PlayerSoldEvent(
leaguePlayerId: null == leaguePlayerId ? _self.leaguePlayerId : leaguePlayerId // ignore: cast_nullable_to_non_nullable
as String,franchiseId: null == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String,finalPrice: null == finalPrice ? _self.finalPrice : finalPrice // ignore: cast_nullable_to_non_nullable
as int,roundId: freezed == roundId ? _self.roundId : roundId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class SoldRevertedEvent extends AuctionEvent {
  const SoldRevertedEvent({required this.leaguePlayerId, this.revertedFromFranchiseId, this.restoredAmount, this.reason}): super._();
  

 final  String leaguePlayerId;
 final  String? revertedFromFranchiseId;
 final  int? restoredAmount;
 final  String? reason;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SoldRevertedEventCopyWith<SoldRevertedEvent> get copyWith => _$SoldRevertedEventCopyWithImpl<SoldRevertedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SoldRevertedEvent&&(identical(other.leaguePlayerId, leaguePlayerId) || other.leaguePlayerId == leaguePlayerId)&&(identical(other.revertedFromFranchiseId, revertedFromFranchiseId) || other.revertedFromFranchiseId == revertedFromFranchiseId)&&(identical(other.restoredAmount, restoredAmount) || other.restoredAmount == restoredAmount)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,leaguePlayerId,revertedFromFranchiseId,restoredAmount,reason);

@override
String toString() {
  return 'AuctionEvent.soldReverted(leaguePlayerId: $leaguePlayerId, revertedFromFranchiseId: $revertedFromFranchiseId, restoredAmount: $restoredAmount, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $SoldRevertedEventCopyWith<$Res> implements $AuctionEventCopyWith<$Res> {
  factory $SoldRevertedEventCopyWith(SoldRevertedEvent value, $Res Function(SoldRevertedEvent) _then) = _$SoldRevertedEventCopyWithImpl;
@useResult
$Res call({
 String leaguePlayerId, String? revertedFromFranchiseId, int? restoredAmount, String? reason
});




}
/// @nodoc
class _$SoldRevertedEventCopyWithImpl<$Res>
    implements $SoldRevertedEventCopyWith<$Res> {
  _$SoldRevertedEventCopyWithImpl(this._self, this._then);

  final SoldRevertedEvent _self;
  final $Res Function(SoldRevertedEvent) _then;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? leaguePlayerId = null,Object? revertedFromFranchiseId = freezed,Object? restoredAmount = freezed,Object? reason = freezed,}) {
  return _then(SoldRevertedEvent(
leaguePlayerId: null == leaguePlayerId ? _self.leaguePlayerId : leaguePlayerId // ignore: cast_nullable_to_non_nullable
as String,revertedFromFranchiseId: freezed == revertedFromFranchiseId ? _self.revertedFromFranchiseId : revertedFromFranchiseId // ignore: cast_nullable_to_non_nullable
as String?,restoredAmount: freezed == restoredAmount ? _self.restoredAmount : restoredAmount // ignore: cast_nullable_to_non_nullable
as int?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class PlayerUnsoldEvent extends AuctionEvent {
  const PlayerUnsoldEvent({required this.leaguePlayerId, this.roundId}): super._();
  

 final  String leaguePlayerId;
 final  String? roundId;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerUnsoldEventCopyWith<PlayerUnsoldEvent> get copyWith => _$PlayerUnsoldEventCopyWithImpl<PlayerUnsoldEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerUnsoldEvent&&(identical(other.leaguePlayerId, leaguePlayerId) || other.leaguePlayerId == leaguePlayerId)&&(identical(other.roundId, roundId) || other.roundId == roundId));
}


@override
int get hashCode => Object.hash(runtimeType,leaguePlayerId,roundId);

@override
String toString() {
  return 'AuctionEvent.playerUnsold(leaguePlayerId: $leaguePlayerId, roundId: $roundId)';
}


}

/// @nodoc
abstract mixin class $PlayerUnsoldEventCopyWith<$Res> implements $AuctionEventCopyWith<$Res> {
  factory $PlayerUnsoldEventCopyWith(PlayerUnsoldEvent value, $Res Function(PlayerUnsoldEvent) _then) = _$PlayerUnsoldEventCopyWithImpl;
@useResult
$Res call({
 String leaguePlayerId, String? roundId
});




}
/// @nodoc
class _$PlayerUnsoldEventCopyWithImpl<$Res>
    implements $PlayerUnsoldEventCopyWith<$Res> {
  _$PlayerUnsoldEventCopyWithImpl(this._self, this._then);

  final PlayerUnsoldEvent _self;
  final $Res Function(PlayerUnsoldEvent) _then;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? leaguePlayerId = null,Object? roundId = freezed,}) {
  return _then(PlayerUnsoldEvent(
leaguePlayerId: null == leaguePlayerId ? _self.leaguePlayerId : leaguePlayerId // ignore: cast_nullable_to_non_nullable
as String,roundId: freezed == roundId ? _self.roundId : roundId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class PlayerWithdrawnEvent extends AuctionEvent {
  const PlayerWithdrawnEvent({required this.leaguePlayerId, this.reason}): super._();
  

 final  String leaguePlayerId;
 final  String? reason;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerWithdrawnEventCopyWith<PlayerWithdrawnEvent> get copyWith => _$PlayerWithdrawnEventCopyWithImpl<PlayerWithdrawnEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerWithdrawnEvent&&(identical(other.leaguePlayerId, leaguePlayerId) || other.leaguePlayerId == leaguePlayerId)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,leaguePlayerId,reason);

@override
String toString() {
  return 'AuctionEvent.playerWithdrawn(leaguePlayerId: $leaguePlayerId, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $PlayerWithdrawnEventCopyWith<$Res> implements $AuctionEventCopyWith<$Res> {
  factory $PlayerWithdrawnEventCopyWith(PlayerWithdrawnEvent value, $Res Function(PlayerWithdrawnEvent) _then) = _$PlayerWithdrawnEventCopyWithImpl;
@useResult
$Res call({
 String leaguePlayerId, String? reason
});




}
/// @nodoc
class _$PlayerWithdrawnEventCopyWithImpl<$Res>
    implements $PlayerWithdrawnEventCopyWith<$Res> {
  _$PlayerWithdrawnEventCopyWithImpl(this._self, this._then);

  final PlayerWithdrawnEvent _self;
  final $Res Function(PlayerWithdrawnEvent) _then;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? leaguePlayerId = null,Object? reason = freezed,}) {
  return _then(PlayerWithdrawnEvent(
leaguePlayerId: null == leaguePlayerId ? _self.leaguePlayerId : leaguePlayerId // ignore: cast_nullable_to_non_nullable
as String,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class PlayerForceAssignedEvent extends AuctionEvent {
  const PlayerForceAssignedEvent({required this.leaguePlayerId, required this.franchiseId, this.price, this.assignedBy}): super._();
  

 final  String leaguePlayerId;
 final  String franchiseId;
 final  int? price;
 final  String? assignedBy;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerForceAssignedEventCopyWith<PlayerForceAssignedEvent> get copyWith => _$PlayerForceAssignedEventCopyWithImpl<PlayerForceAssignedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerForceAssignedEvent&&(identical(other.leaguePlayerId, leaguePlayerId) || other.leaguePlayerId == leaguePlayerId)&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.price, price) || other.price == price)&&(identical(other.assignedBy, assignedBy) || other.assignedBy == assignedBy));
}


@override
int get hashCode => Object.hash(runtimeType,leaguePlayerId,franchiseId,price,assignedBy);

@override
String toString() {
  return 'AuctionEvent.playerForceAssigned(leaguePlayerId: $leaguePlayerId, franchiseId: $franchiseId, price: $price, assignedBy: $assignedBy)';
}


}

/// @nodoc
abstract mixin class $PlayerForceAssignedEventCopyWith<$Res> implements $AuctionEventCopyWith<$Res> {
  factory $PlayerForceAssignedEventCopyWith(PlayerForceAssignedEvent value, $Res Function(PlayerForceAssignedEvent) _then) = _$PlayerForceAssignedEventCopyWithImpl;
@useResult
$Res call({
 String leaguePlayerId, String franchiseId, int? price, String? assignedBy
});




}
/// @nodoc
class _$PlayerForceAssignedEventCopyWithImpl<$Res>
    implements $PlayerForceAssignedEventCopyWith<$Res> {
  _$PlayerForceAssignedEventCopyWithImpl(this._self, this._then);

  final PlayerForceAssignedEvent _self;
  final $Res Function(PlayerForceAssignedEvent) _then;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? leaguePlayerId = null,Object? franchiseId = null,Object? price = freezed,Object? assignedBy = freezed,}) {
  return _then(PlayerForceAssignedEvent(
leaguePlayerId: null == leaguePlayerId ? _self.leaguePlayerId : leaguePlayerId // ignore: cast_nullable_to_non_nullable
as String,franchiseId: null == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int?,assignedBy: freezed == assignedBy ? _self.assignedBy : assignedBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class PlayerPreAssignedEvent extends AuctionEvent {
  const PlayerPreAssignedEvent({required this.leaguePlayerId, required this.franchiseId, this.price, this.assignmentType, this.assignedBy}): super._();
  

 final  String leaguePlayerId;
 final  String franchiseId;
 final  int? price;
 final  String? assignmentType;
 final  String? assignedBy;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerPreAssignedEventCopyWith<PlayerPreAssignedEvent> get copyWith => _$PlayerPreAssignedEventCopyWithImpl<PlayerPreAssignedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerPreAssignedEvent&&(identical(other.leaguePlayerId, leaguePlayerId) || other.leaguePlayerId == leaguePlayerId)&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.price, price) || other.price == price)&&(identical(other.assignmentType, assignmentType) || other.assignmentType == assignmentType)&&(identical(other.assignedBy, assignedBy) || other.assignedBy == assignedBy));
}


@override
int get hashCode => Object.hash(runtimeType,leaguePlayerId,franchiseId,price,assignmentType,assignedBy);

@override
String toString() {
  return 'AuctionEvent.playerPreAssigned(leaguePlayerId: $leaguePlayerId, franchiseId: $franchiseId, price: $price, assignmentType: $assignmentType, assignedBy: $assignedBy)';
}


}

/// @nodoc
abstract mixin class $PlayerPreAssignedEventCopyWith<$Res> implements $AuctionEventCopyWith<$Res> {
  factory $PlayerPreAssignedEventCopyWith(PlayerPreAssignedEvent value, $Res Function(PlayerPreAssignedEvent) _then) = _$PlayerPreAssignedEventCopyWithImpl;
@useResult
$Res call({
 String leaguePlayerId, String franchiseId, int? price, String? assignmentType, String? assignedBy
});




}
/// @nodoc
class _$PlayerPreAssignedEventCopyWithImpl<$Res>
    implements $PlayerPreAssignedEventCopyWith<$Res> {
  _$PlayerPreAssignedEventCopyWithImpl(this._self, this._then);

  final PlayerPreAssignedEvent _self;
  final $Res Function(PlayerPreAssignedEvent) _then;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? leaguePlayerId = null,Object? franchiseId = null,Object? price = freezed,Object? assignmentType = freezed,Object? assignedBy = freezed,}) {
  return _then(PlayerPreAssignedEvent(
leaguePlayerId: null == leaguePlayerId ? _self.leaguePlayerId : leaguePlayerId // ignore: cast_nullable_to_non_nullable
as String,franchiseId: null == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int?,assignmentType: freezed == assignmentType ? _self.assignmentType : assignmentType // ignore: cast_nullable_to_non_nullable
as String?,assignedBy: freezed == assignedBy ? _self.assignedBy : assignedBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class RoundStartedEvent extends AuctionEvent {
  const RoundStartedEvent({required this.roundId, this.roundNumber}): super._();
  

 final  String roundId;
 final  int? roundNumber;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoundStartedEventCopyWith<RoundStartedEvent> get copyWith => _$RoundStartedEventCopyWithImpl<RoundStartedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoundStartedEvent&&(identical(other.roundId, roundId) || other.roundId == roundId)&&(identical(other.roundNumber, roundNumber) || other.roundNumber == roundNumber));
}


@override
int get hashCode => Object.hash(runtimeType,roundId,roundNumber);

@override
String toString() {
  return 'AuctionEvent.roundStarted(roundId: $roundId, roundNumber: $roundNumber)';
}


}

/// @nodoc
abstract mixin class $RoundStartedEventCopyWith<$Res> implements $AuctionEventCopyWith<$Res> {
  factory $RoundStartedEventCopyWith(RoundStartedEvent value, $Res Function(RoundStartedEvent) _then) = _$RoundStartedEventCopyWithImpl;
@useResult
$Res call({
 String roundId, int? roundNumber
});




}
/// @nodoc
class _$RoundStartedEventCopyWithImpl<$Res>
    implements $RoundStartedEventCopyWith<$Res> {
  _$RoundStartedEventCopyWithImpl(this._self, this._then);

  final RoundStartedEvent _self;
  final $Res Function(RoundStartedEvent) _then;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? roundId = null,Object? roundNumber = freezed,}) {
  return _then(RoundStartedEvent(
roundId: null == roundId ? _self.roundId : roundId // ignore: cast_nullable_to_non_nullable
as String,roundNumber: freezed == roundNumber ? _self.roundNumber : roundNumber // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class RoundCompletedEvent extends AuctionEvent {
  const RoundCompletedEvent({required this.roundId, this.soldCount, this.unsoldCount}): super._();
  

 final  String roundId;
 final  int? soldCount;
 final  int? unsoldCount;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoundCompletedEventCopyWith<RoundCompletedEvent> get copyWith => _$RoundCompletedEventCopyWithImpl<RoundCompletedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoundCompletedEvent&&(identical(other.roundId, roundId) || other.roundId == roundId)&&(identical(other.soldCount, soldCount) || other.soldCount == soldCount)&&(identical(other.unsoldCount, unsoldCount) || other.unsoldCount == unsoldCount));
}


@override
int get hashCode => Object.hash(runtimeType,roundId,soldCount,unsoldCount);

@override
String toString() {
  return 'AuctionEvent.roundCompleted(roundId: $roundId, soldCount: $soldCount, unsoldCount: $unsoldCount)';
}


}

/// @nodoc
abstract mixin class $RoundCompletedEventCopyWith<$Res> implements $AuctionEventCopyWith<$Res> {
  factory $RoundCompletedEventCopyWith(RoundCompletedEvent value, $Res Function(RoundCompletedEvent) _then) = _$RoundCompletedEventCopyWithImpl;
@useResult
$Res call({
 String roundId, int? soldCount, int? unsoldCount
});




}
/// @nodoc
class _$RoundCompletedEventCopyWithImpl<$Res>
    implements $RoundCompletedEventCopyWith<$Res> {
  _$RoundCompletedEventCopyWithImpl(this._self, this._then);

  final RoundCompletedEvent _self;
  final $Res Function(RoundCompletedEvent) _then;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? roundId = null,Object? soldCount = freezed,Object? unsoldCount = freezed,}) {
  return _then(RoundCompletedEvent(
roundId: null == roundId ? _self.roundId : roundId // ignore: cast_nullable_to_non_nullable
as String,soldCount: freezed == soldCount ? _self.soldCount : soldCount // ignore: cast_nullable_to_non_nullable
as int?,unsoldCount: freezed == unsoldCount ? _self.unsoldCount : unsoldCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class AuctionStartedEvent extends AuctionEvent {
  const AuctionStartedEvent({this.startedAt}): super._();
  

 final  DateTime? startedAt;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuctionStartedEventCopyWith<AuctionStartedEvent> get copyWith => _$AuctionStartedEventCopyWithImpl<AuctionStartedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuctionStartedEvent&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt));
}


@override
int get hashCode => Object.hash(runtimeType,startedAt);

@override
String toString() {
  return 'AuctionEvent.auctionStarted(startedAt: $startedAt)';
}


}

/// @nodoc
abstract mixin class $AuctionStartedEventCopyWith<$Res> implements $AuctionEventCopyWith<$Res> {
  factory $AuctionStartedEventCopyWith(AuctionStartedEvent value, $Res Function(AuctionStartedEvent) _then) = _$AuctionStartedEventCopyWithImpl;
@useResult
$Res call({
 DateTime? startedAt
});




}
/// @nodoc
class _$AuctionStartedEventCopyWithImpl<$Res>
    implements $AuctionStartedEventCopyWith<$Res> {
  _$AuctionStartedEventCopyWithImpl(this._self, this._then);

  final AuctionStartedEvent _self;
  final $Res Function(AuctionStartedEvent) _then;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? startedAt = freezed,}) {
  return _then(AuctionStartedEvent(
startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class AuctionPausedEvent extends AuctionEvent {
  const AuctionPausedEvent({this.reason}): super._();
  

 final  String? reason;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuctionPausedEventCopyWith<AuctionPausedEvent> get copyWith => _$AuctionPausedEventCopyWithImpl<AuctionPausedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuctionPausedEvent&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'AuctionEvent.auctionPaused(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $AuctionPausedEventCopyWith<$Res> implements $AuctionEventCopyWith<$Res> {
  factory $AuctionPausedEventCopyWith(AuctionPausedEvent value, $Res Function(AuctionPausedEvent) _then) = _$AuctionPausedEventCopyWithImpl;
@useResult
$Res call({
 String? reason
});




}
/// @nodoc
class _$AuctionPausedEventCopyWithImpl<$Res>
    implements $AuctionPausedEventCopyWith<$Res> {
  _$AuctionPausedEventCopyWithImpl(this._self, this._then);

  final AuctionPausedEvent _self;
  final $Res Function(AuctionPausedEvent) _then;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = freezed,}) {
  return _then(AuctionPausedEvent(
reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class AuctionResumedEvent extends AuctionEvent {
  const AuctionResumedEvent(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuctionResumedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuctionEvent.auctionResumed()';
}


}




/// @nodoc


class AuctionCompletedEvent extends AuctionEvent {
  const AuctionCompletedEvent({this.totalSold, this.totalUnsold, this.totalSpent, this.completedAt}): super._();
  

 final  int? totalSold;
 final  int? totalUnsold;
 final  int? totalSpent;
 final  DateTime? completedAt;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuctionCompletedEventCopyWith<AuctionCompletedEvent> get copyWith => _$AuctionCompletedEventCopyWithImpl<AuctionCompletedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuctionCompletedEvent&&(identical(other.totalSold, totalSold) || other.totalSold == totalSold)&&(identical(other.totalUnsold, totalUnsold) || other.totalUnsold == totalUnsold)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}


@override
int get hashCode => Object.hash(runtimeType,totalSold,totalUnsold,totalSpent,completedAt);

@override
String toString() {
  return 'AuctionEvent.auctionCompleted(totalSold: $totalSold, totalUnsold: $totalUnsold, totalSpent: $totalSpent, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $AuctionCompletedEventCopyWith<$Res> implements $AuctionEventCopyWith<$Res> {
  factory $AuctionCompletedEventCopyWith(AuctionCompletedEvent value, $Res Function(AuctionCompletedEvent) _then) = _$AuctionCompletedEventCopyWithImpl;
@useResult
$Res call({
 int? totalSold, int? totalUnsold, int? totalSpent, DateTime? completedAt
});




}
/// @nodoc
class _$AuctionCompletedEventCopyWithImpl<$Res>
    implements $AuctionCompletedEventCopyWith<$Res> {
  _$AuctionCompletedEventCopyWithImpl(this._self, this._then);

  final AuctionCompletedEvent _self;
  final $Res Function(AuctionCompletedEvent) _then;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? totalSold = freezed,Object? totalUnsold = freezed,Object? totalSpent = freezed,Object? completedAt = freezed,}) {
  return _then(AuctionCompletedEvent(
totalSold: freezed == totalSold ? _self.totalSold : totalSold // ignore: cast_nullable_to_non_nullable
as int?,totalUnsold: freezed == totalUnsold ? _self.totalUnsold : totalUnsold // ignore: cast_nullable_to_non_nullable
as int?,totalSpent: freezed == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as int?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class AuctionCancelledEvent extends AuctionEvent {
  const AuctionCancelledEvent({this.reason}): super._();
  

 final  String? reason;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuctionCancelledEventCopyWith<AuctionCancelledEvent> get copyWith => _$AuctionCancelledEventCopyWithImpl<AuctionCancelledEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuctionCancelledEvent&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'AuctionEvent.auctionCancelled(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $AuctionCancelledEventCopyWith<$Res> implements $AuctionEventCopyWith<$Res> {
  factory $AuctionCancelledEventCopyWith(AuctionCancelledEvent value, $Res Function(AuctionCancelledEvent) _then) = _$AuctionCancelledEventCopyWithImpl;
@useResult
$Res call({
 String? reason
});




}
/// @nodoc
class _$AuctionCancelledEventCopyWithImpl<$Res>
    implements $AuctionCancelledEventCopyWith<$Res> {
  _$AuctionCancelledEventCopyWithImpl(this._self, this._then);

  final AuctionCancelledEvent _self;
  final $Res Function(AuctionCancelledEvent) _then;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = freezed,}) {
  return _then(AuctionCancelledEvent(
reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class TimerStartedEvent extends AuctionEvent {
  const TimerStartedEvent({this.durationSeconds, this.startedAt, this.antiSnipeSeconds, this.leaguePlayerId}): super._();
  

 final  int? durationSeconds;
 final  DateTime? startedAt;
 final  int? antiSnipeSeconds;
 final  String? leaguePlayerId;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimerStartedEventCopyWith<TimerStartedEvent> get copyWith => _$TimerStartedEventCopyWithImpl<TimerStartedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimerStartedEvent&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.antiSnipeSeconds, antiSnipeSeconds) || other.antiSnipeSeconds == antiSnipeSeconds)&&(identical(other.leaguePlayerId, leaguePlayerId) || other.leaguePlayerId == leaguePlayerId));
}


@override
int get hashCode => Object.hash(runtimeType,durationSeconds,startedAt,antiSnipeSeconds,leaguePlayerId);

@override
String toString() {
  return 'AuctionEvent.timerStarted(durationSeconds: $durationSeconds, startedAt: $startedAt, antiSnipeSeconds: $antiSnipeSeconds, leaguePlayerId: $leaguePlayerId)';
}


}

/// @nodoc
abstract mixin class $TimerStartedEventCopyWith<$Res> implements $AuctionEventCopyWith<$Res> {
  factory $TimerStartedEventCopyWith(TimerStartedEvent value, $Res Function(TimerStartedEvent) _then) = _$TimerStartedEventCopyWithImpl;
@useResult
$Res call({
 int? durationSeconds, DateTime? startedAt, int? antiSnipeSeconds, String? leaguePlayerId
});




}
/// @nodoc
class _$TimerStartedEventCopyWithImpl<$Res>
    implements $TimerStartedEventCopyWith<$Res> {
  _$TimerStartedEventCopyWithImpl(this._self, this._then);

  final TimerStartedEvent _self;
  final $Res Function(TimerStartedEvent) _then;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? durationSeconds = freezed,Object? startedAt = freezed,Object? antiSnipeSeconds = freezed,Object? leaguePlayerId = freezed,}) {
  return _then(TimerStartedEvent(
durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,antiSnipeSeconds: freezed == antiSnipeSeconds ? _self.antiSnipeSeconds : antiSnipeSeconds // ignore: cast_nullable_to_non_nullable
as int?,leaguePlayerId: freezed == leaguePlayerId ? _self.leaguePlayerId : leaguePlayerId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class TimerStoppedEvent extends AuctionEvent {
  const TimerStoppedEvent(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimerStoppedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuctionEvent.timerStopped()';
}


}




/// @nodoc


class TimerResetEvent extends AuctionEvent {
  const TimerResetEvent({this.newDurationSeconds, this.startedAt, this.reason, this.leaguePlayerId}): super._();
  

 final  int? newDurationSeconds;
 final  DateTime? startedAt;
 final  String? reason;
 final  String? leaguePlayerId;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimerResetEventCopyWith<TimerResetEvent> get copyWith => _$TimerResetEventCopyWithImpl<TimerResetEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimerResetEvent&&(identical(other.newDurationSeconds, newDurationSeconds) || other.newDurationSeconds == newDurationSeconds)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.leaguePlayerId, leaguePlayerId) || other.leaguePlayerId == leaguePlayerId));
}


@override
int get hashCode => Object.hash(runtimeType,newDurationSeconds,startedAt,reason,leaguePlayerId);

@override
String toString() {
  return 'AuctionEvent.timerReset(newDurationSeconds: $newDurationSeconds, startedAt: $startedAt, reason: $reason, leaguePlayerId: $leaguePlayerId)';
}


}

/// @nodoc
abstract mixin class $TimerResetEventCopyWith<$Res> implements $AuctionEventCopyWith<$Res> {
  factory $TimerResetEventCopyWith(TimerResetEvent value, $Res Function(TimerResetEvent) _then) = _$TimerResetEventCopyWithImpl;
@useResult
$Res call({
 int? newDurationSeconds, DateTime? startedAt, String? reason, String? leaguePlayerId
});




}
/// @nodoc
class _$TimerResetEventCopyWithImpl<$Res>
    implements $TimerResetEventCopyWith<$Res> {
  _$TimerResetEventCopyWithImpl(this._self, this._then);

  final TimerResetEvent _self;
  final $Res Function(TimerResetEvent) _then;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? newDurationSeconds = freezed,Object? startedAt = freezed,Object? reason = freezed,Object? leaguePlayerId = freezed,}) {
  return _then(TimerResetEvent(
newDurationSeconds: freezed == newDurationSeconds ? _self.newDurationSeconds : newDurationSeconds // ignore: cast_nullable_to_non_nullable
as int?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,leaguePlayerId: freezed == leaguePlayerId ? _self.leaguePlayerId : leaguePlayerId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class TimerExtendedEvent extends AuctionEvent {
  const TimerExtendedEvent({this.addedSeconds, this.newDurationSeconds}): super._();
  

 final  int? addedSeconds;
 final  int? newDurationSeconds;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimerExtendedEventCopyWith<TimerExtendedEvent> get copyWith => _$TimerExtendedEventCopyWithImpl<TimerExtendedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimerExtendedEvent&&(identical(other.addedSeconds, addedSeconds) || other.addedSeconds == addedSeconds)&&(identical(other.newDurationSeconds, newDurationSeconds) || other.newDurationSeconds == newDurationSeconds));
}


@override
int get hashCode => Object.hash(runtimeType,addedSeconds,newDurationSeconds);

@override
String toString() {
  return 'AuctionEvent.timerExtended(addedSeconds: $addedSeconds, newDurationSeconds: $newDurationSeconds)';
}


}

/// @nodoc
abstract mixin class $TimerExtendedEventCopyWith<$Res> implements $AuctionEventCopyWith<$Res> {
  factory $TimerExtendedEventCopyWith(TimerExtendedEvent value, $Res Function(TimerExtendedEvent) _then) = _$TimerExtendedEventCopyWithImpl;
@useResult
$Res call({
 int? addedSeconds, int? newDurationSeconds
});




}
/// @nodoc
class _$TimerExtendedEventCopyWithImpl<$Res>
    implements $TimerExtendedEventCopyWith<$Res> {
  _$TimerExtendedEventCopyWithImpl(this._self, this._then);

  final TimerExtendedEvent _self;
  final $Res Function(TimerExtendedEvent) _then;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? addedSeconds = freezed,Object? newDurationSeconds = freezed,}) {
  return _then(TimerExtendedEvent(
addedSeconds: freezed == addedSeconds ? _self.addedSeconds : addedSeconds // ignore: cast_nullable_to_non_nullable
as int?,newDurationSeconds: freezed == newDurationSeconds ? _self.newDurationSeconds : newDurationSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class UnknownAuctionEvent extends AuctionEvent {
  const UnknownAuctionEvent({required this.event, final  Map<String, dynamic> data = const <String, dynamic>{}}): _data = data,super._();
  

 final  String event;
 final  Map<String, dynamic> _data;
@JsonKey() Map<String, dynamic> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}


/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnknownAuctionEventCopyWith<UnknownAuctionEvent> get copyWith => _$UnknownAuctionEventCopyWithImpl<UnknownAuctionEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownAuctionEvent&&(identical(other.event, event) || other.event == event)&&const DeepCollectionEquality().equals(other._data, _data));
}


@override
int get hashCode => Object.hash(runtimeType,event,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'AuctionEvent.unknown(event: $event, data: $data)';
}


}

/// @nodoc
abstract mixin class $UnknownAuctionEventCopyWith<$Res> implements $AuctionEventCopyWith<$Res> {
  factory $UnknownAuctionEventCopyWith(UnknownAuctionEvent value, $Res Function(UnknownAuctionEvent) _then) = _$UnknownAuctionEventCopyWithImpl;
@useResult
$Res call({
 String event, Map<String, dynamic> data
});




}
/// @nodoc
class _$UnknownAuctionEventCopyWithImpl<$Res>
    implements $UnknownAuctionEventCopyWith<$Res> {
  _$UnknownAuctionEventCopyWithImpl(this._self, this._then);

  final UnknownAuctionEvent _self;
  final $Res Function(UnknownAuctionEvent) _then;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? event = null,Object? data = null,}) {
  return _then(UnknownAuctionEvent(
event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
