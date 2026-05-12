import 'package:freezed_annotation/freezed_annotation.dart';

part 'auction_event.freezed.dart';
part 'auction_event.g.dart';

@freezed
sealed class AuctionEvent with _$AuctionEvent {
  const AuctionEvent._();

  const factory AuctionEvent.playerUp({
    required String playerId,
    required String playerName,
    String? playerPhotoUrl,
    required int basePrice,
    int? bidIncrement,
  }) = PlayerUp;

  const factory AuctionEvent.bidPlaced({
    required String franchiseId,
    required String franchiseName,
    required int amount,
    int? nextMinimumBid,
  }) = BidPlaced;

  const factory AuctionEvent.playerSold({
    required String playerId,
    required String franchiseId,
    required int amount,
  }) = PlayerSold;

  const factory AuctionEvent.bidUndone() = BidUndone;
  const factory AuctionEvent.soldReverted() = SoldReverted;
  const factory AuctionEvent.playerUnsold({required String playerId}) = PlayerUnsold;

  const factory AuctionEvent.playerForceAssigned({
    required String playerId,
    required String franchiseId,
    required String franchiseName,
  }) = PlayerForceAssigned;

  const factory AuctionEvent.timerStarted({
    required int remainingSeconds,
  }) = TimerStarted;

  const factory AuctionEvent.timerPaused({
    required int remainingSeconds,
  }) = TimerPaused;

  const factory AuctionEvent.timerReset({
    required int remainingSeconds,
  }) = TimerReset;

  const factory AuctionEvent.roundStarted({required int roundNumber}) = RoundStarted;
  const factory AuctionEvent.auctionStarted() = AuctionStarted;
  const factory AuctionEvent.auctionCompleted() = AuctionCompleted;

  factory AuctionEvent.fromJson(Map<String, dynamic> json) => _$AuctionEventFromJson(json);
}
