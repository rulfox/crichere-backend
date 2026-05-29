import 'package:freezed_annotation/freezed_annotation.dart';
import 'auction_state_snapshot.dart';

part 'auction_event.freezed.dart';

/// Live auction events streamed over SSE.
///
/// The backend wraps every frame in a JSON envelope on the `data:` line:
///   - Snapshot (first frame): `{"event":"SNAPSHOT","data": <AuctionStateSnapshot>}`
///   - Action (live + replay):  `{"id":<seq>,"event":"<ACTION_NAME>","data":{…}}`
///
/// This union dispatches on the envelope's `event` string (NOT the Freezed
/// `runtimeType`), with byte-exact payload field names matching
/// `AuctionService.logAndBroadcast`. A [AuctionEvent.unknown] fallback keeps the
/// stream alive if the server adds a new action.
@freezed
sealed class AuctionEvent with _$AuctionEvent {
  const AuctionEvent._();

  /// First frame on (re)connect — full authoritative state.
  const factory AuctionEvent.snapshot(AuctionStateSnapshot snapshot) =
      AuctionSnapshotEvent;

  const factory AuctionEvent.playerUp({
    required String leaguePlayerId,
    String? playerName,
    int? basePrice,
    String? roundId,
  }) = PlayerUpEvent;

  const factory AuctionEvent.bidPlaced({
    required String leaguePlayerId,
    required String franchiseId,
    required int bidAmount,
    int? previousHighestBid,
    String? previousHighestBidder,
  }) = BidPlacedEvent;

  const factory AuctionEvent.bidUndone({
    required String leaguePlayerId,
    String? undoneBidId,
    int? undoneAmount,
    String? undoneFranchiseId,
    int? newHighestBid,
    String? newHighestBidder,
    String? reason,
  }) = BidUndoneEvent;

  const factory AuctionEvent.playerSold({
    required String leaguePlayerId,
    required String franchiseId,
    required int finalPrice,
    String? roundId,
  }) = PlayerSoldEvent;

  const factory AuctionEvent.soldReverted({
    required String leaguePlayerId,
    String? revertedFromFranchiseId,
    int? restoredAmount,
    String? reason,
  }) = SoldRevertedEvent;

  const factory AuctionEvent.playerUnsold({
    required String leaguePlayerId,
    String? roundId,
  }) = PlayerUnsoldEvent;

  const factory AuctionEvent.playerWithdrawn({
    required String leaguePlayerId,
    String? reason,
  }) = PlayerWithdrawnEvent;

  const factory AuctionEvent.playerForceAssigned({
    required String leaguePlayerId,
    required String franchiseId,
    int? price,
    String? assignedBy,
  }) = PlayerForceAssignedEvent;

  const factory AuctionEvent.playerPreAssigned({
    required String leaguePlayerId,
    required String franchiseId,
    int? price,
    String? assignmentType,
    String? assignedBy,
  }) = PlayerPreAssignedEvent;

  const factory AuctionEvent.roundStarted({
    required String roundId,
    int? roundNumber,
  }) = RoundStartedEvent;

  const factory AuctionEvent.roundCompleted({
    required String roundId,
    int? soldCount,
    int? unsoldCount,
  }) = RoundCompletedEvent;

  const factory AuctionEvent.auctionStarted({DateTime? startedAt}) =
      AuctionStartedEvent;

  const factory AuctionEvent.auctionPaused({String? reason}) =
      AuctionPausedEvent;

  const factory AuctionEvent.auctionResumed() = AuctionResumedEvent;

  const factory AuctionEvent.auctionCompleted({
    int? totalSold,
    int? totalUnsold,
    int? totalSpent,
    DateTime? completedAt,
  }) = AuctionCompletedEvent;

  const factory AuctionEvent.auctionCancelled({String? reason}) =
      AuctionCancelledEvent;

  const factory AuctionEvent.timerStarted({
    int? durationSeconds,
    DateTime? startedAt,
    int? antiSnipeSeconds,
    String? leaguePlayerId,
  }) = TimerStartedEvent;

  const factory AuctionEvent.timerStopped() = TimerStoppedEvent;

  const factory AuctionEvent.timerReset({
    int? newDurationSeconds,
    DateTime? startedAt,
    String? reason,
    String? leaguePlayerId,
  }) = TimerResetEvent;

  const factory AuctionEvent.timerExtended({
    int? addedSeconds,
    int? newDurationSeconds,
  }) = TimerExtendedEvent;

  /// Fallback for any action the client doesn't model yet.
  const factory AuctionEvent.unknown({
    required String event,
    @Default(<String, dynamic>{}) Map<String, dynamic> data,
  }) = UnknownAuctionEvent;

  /// Builds an [AuctionEvent] from the decoded SSE envelope's `event` string and
  /// `data` map. Tolerant of missing/extra keys and numeric-vs-string types.
  static AuctionEvent fromEnvelope(String event, Map<String, dynamic> data) {
    int? asInt(Object? v) => v == null ? null : (v as num).toInt();
    String? asStr(Object? v) => v?.toString();
    DateTime? asDate(Object? v) =>
        v == null ? null : DateTime.tryParse(v.toString());

    switch (event) {
      case 'SNAPSHOT':
        return AuctionEvent.snapshot(AuctionStateSnapshot.fromJson(data));
      case 'PLAYER_UP':
        return AuctionEvent.playerUp(
          leaguePlayerId: asStr(data['leaguePlayerId']) ?? '',
          playerName: asStr(data['playerName']),
          basePrice: asInt(data['basePrice']),
          roundId: asStr(data['roundId']),
        );
      case 'BID_PLACED':
        return AuctionEvent.bidPlaced(
          leaguePlayerId: asStr(data['leaguePlayerId']) ?? '',
          franchiseId: asStr(data['franchiseId']) ?? '',
          bidAmount: asInt(data['bidAmount']) ?? 0,
          previousHighestBid: asInt(data['previousHighestBid']),
          previousHighestBidder: asStr(data['previousHighestBidder']),
        );
      case 'BID_UNDONE':
        return AuctionEvent.bidUndone(
          leaguePlayerId: asStr(data['leaguePlayerId']) ?? '',
          undoneBidId: asStr(data['undoneBidId']),
          undoneAmount: asInt(data['undoneAmount']),
          undoneFranchiseId: asStr(data['undoneFranchiseId']),
          newHighestBid: asInt(data['newHighestBid']),
          newHighestBidder: asStr(data['newHighestBidder']),
          reason: asStr(data['reason']),
        );
      case 'PLAYER_SOLD':
        return AuctionEvent.playerSold(
          leaguePlayerId: asStr(data['leaguePlayerId']) ?? '',
          franchiseId: asStr(data['franchiseId']) ?? '',
          finalPrice: asInt(data['finalPrice']) ?? 0,
          roundId: asStr(data['roundId']),
        );
      case 'SOLD_REVERTED':
        return AuctionEvent.soldReverted(
          leaguePlayerId: asStr(data['leaguePlayerId']) ?? '',
          revertedFromFranchiseId: asStr(data['revertedFromFranchiseId']),
          restoredAmount: asInt(data['restoredAmount']),
          reason: asStr(data['reason']),
        );
      case 'PLAYER_UNSOLD':
        return AuctionEvent.playerUnsold(
          leaguePlayerId: asStr(data['leaguePlayerId']) ?? '',
          roundId: asStr(data['roundId']),
        );
      case 'PLAYER_WITHDRAWN':
        return AuctionEvent.playerWithdrawn(
          leaguePlayerId: asStr(data['leaguePlayerId']) ?? '',
          reason: asStr(data['reason']),
        );
      case 'PLAYER_FORCE_ASSIGNED':
        return AuctionEvent.playerForceAssigned(
          leaguePlayerId: asStr(data['leaguePlayerId']) ?? '',
          franchiseId: asStr(data['franchiseId']) ?? '',
          price: asInt(data['price']),
          assignedBy: asStr(data['assignedBy']),
        );
      case 'PLAYER_PRE_ASSIGNED':
        return AuctionEvent.playerPreAssigned(
          leaguePlayerId: asStr(data['leaguePlayerId']) ?? '',
          franchiseId: asStr(data['franchiseId']) ?? '',
          price: asInt(data['price']),
          assignmentType: asStr(data['assignmentType']),
          assignedBy: asStr(data['assignedBy']),
        );
      case 'ROUND_STARTED':
        return AuctionEvent.roundStarted(
          roundId: asStr(data['roundId']) ?? '',
          roundNumber: asInt(data['roundNumber']),
        );
      case 'ROUND_COMPLETED':
        return AuctionEvent.roundCompleted(
          roundId: asStr(data['roundId']) ?? '',
          soldCount: asInt(data['soldCount']),
          unsoldCount: asInt(data['unsoldCount']),
        );
      case 'AUCTION_STARTED':
        return AuctionEvent.auctionStarted(startedAt: asDate(data['startedAt']));
      case 'AUCTION_PAUSED':
        return AuctionEvent.auctionPaused(reason: asStr(data['reason']));
      case 'AUCTION_RESUMED':
        return const AuctionEvent.auctionResumed();
      case 'AUCTION_COMPLETED':
        return AuctionEvent.auctionCompleted(
          totalSold: asInt(data['totalSold']),
          totalUnsold: asInt(data['totalUnsold']),
          totalSpent: asInt(data['totalSpent']),
          completedAt: asDate(data['completedAt']),
        );
      case 'AUCTION_CANCELLED':
        return AuctionEvent.auctionCancelled(reason: asStr(data['reason']));
      case 'TIMER_STARTED':
        return AuctionEvent.timerStarted(
          durationSeconds: asInt(data['durationSeconds']),
          startedAt: asDate(data['startedAt']),
          antiSnipeSeconds: asInt(data['antiSnipeSeconds']),
          leaguePlayerId: asStr(data['leaguePlayerId']),
        );
      case 'TIMER_STOPPED':
        return const AuctionEvent.timerStopped();
      case 'TIMER_RESET':
        return AuctionEvent.timerReset(
          newDurationSeconds: asInt(data['newDurationSeconds']),
          startedAt: asDate(data['startedAt']),
          reason: asStr(data['reason']),
          leaguePlayerId: asStr(data['leaguePlayerId']),
        );
      case 'TIMER_EXTENDED':
        return AuctionEvent.timerExtended(
          addedSeconds: asInt(data['addedSeconds']),
          newDurationSeconds: asInt(data['newDurationSeconds']),
        );
      default:
        return AuctionEvent.unknown(event: event, data: data);
    }
  }
}
