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
  }) = PlayerUp;

  const factory AuctionEvent.bidPlaced({
    required String franchiseId,
    required String franchiseName,
    required int amount,
  }) = BidPlaced;

  const factory AuctionEvent.playerSold({
    required String playerId,
    required String franchiseId,
    required int amount,
  }) = PlayerSold;

  const factory AuctionEvent.bidUndone() = BidUndone;
  const factory AuctionEvent.soldReverted() = SoldReverted;
  const factory AuctionEvent.playerUnsold({required String playerId}) = PlayerUnsold;
  const factory AuctionEvent.roundStarted({required int roundNumber}) = RoundStarted;
  const factory AuctionEvent.auctionStarted() = AuctionStarted;
  const factory AuctionEvent.auctionCompleted() = AuctionCompleted;

  factory AuctionEvent.fromJson(Map<String, dynamic> json) => _$AuctionEventFromJson(json);
}
