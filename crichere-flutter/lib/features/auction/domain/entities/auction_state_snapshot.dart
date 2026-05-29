import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:crichere_flutter/core/enums/backend_enums.dart';

part 'auction_state_snapshot.freezed.dart';
part 'auction_state_snapshot.g.dart';

/// Mirrors backend `BidIncrementSlabDto`.
@freezed
abstract class BidIncrementSlab with _$BidIncrementSlab {
  const factory BidIncrementSlab({
    required int fromAmount,
    int? toAmount,
    required int incrementBy,
  }) = _BidIncrementSlab;

  factory BidIncrementSlab.fromJson(Map<String, dynamic> json) =>
      _$BidIncrementSlabFromJson(json);
}

/// Mirrors backend `RoundConfigDto`.
@freezed
abstract class RoundConfig with _$RoundConfig {
  const factory RoundConfig({
    required int roundNumber,
    String? name,
    @JsonKey(unknownEnumValue: CurrencyType.unknown) required CurrencyType currencyType,
    int? purseAmount,
    @JsonKey(unknownEnumValue: PurseSource.unknown) required PurseSource purseSource,
    @JsonKey(unknownEnumValue: BidMode.unknown) required BidMode bidMode,
    @JsonKey(unknownEnumValue: PlayerPoolSource.unknown)
    required PlayerPoolSource playerPoolSource,
    @JsonKey(unknownEnumValue: FranchiseEligibilityRule.unknown)
    required FranchiseEligibilityRule franchiseEligibilityRule,
    @JsonKey(unknownEnumValue: CompletionTrigger.unknown)
    required CompletionTrigger completionTrigger,
    int? countdownSeconds,
    int? antiSnipeSeconds,
    @Default(<BidIncrementSlab>[]) List<BidIncrementSlab> bidIncrementSlabs,
  }) = _RoundConfig;

  factory RoundConfig.fromJson(Map<String, dynamic> json) =>
      _$RoundConfigFromJson(json);
}

/// Mirrors backend `PlayerAuctionStateResponse`.
@freezed
abstract class PlayerAuctionState with _$PlayerAuctionState {
  const factory PlayerAuctionState({
    required String id,
    required String auctionId,
    required String leaguePlayerId,
    @JsonKey(unknownEnumValue: PlayerAuctionStateValue.unknown)
    required PlayerAuctionStateValue state,
    int? currentHighestBid,
    String? currentHighestBidderId,
    int? finalPrice,
    String? soldToFranchiseId,
    String? playerName,
    String? playerCategory,
    int? basePrice,
    String? playerPhoto,
  }) = _PlayerAuctionState;

  factory PlayerAuctionState.fromJson(Map<String, dynamic> json) =>
      _$PlayerAuctionStateFromJson(json);
}

/// Mirrors backend `FranchisePurseStateResponse`.
@freezed
abstract class FranchisePurseState with _$FranchisePurseState {
  const factory FranchisePurseState({
    required String id,
    required String franchiseId,
    String? roundId,
    @JsonKey(unknownEnumValue: CurrencyType.unknown) CurrencyType? currencyType,
    int? startingAmount,
    required int currentAmount,
    required int reservedAmount,
    String? franchiseName,
    String? franchiseLogoUrl,
  }) = _FranchisePurseState;

  factory FranchisePurseState.fromJson(Map<String, dynamic> json) =>
      _$FranchisePurseStateFromJson(json);
}

/// Mirrors backend `TimerStateResponse`.
@freezed
abstract class TimerState with _$TimerState {
  const factory TimerState({
    required bool isRunning,
    DateTime? startedAt,
    int? durationSeconds,
    int? remainingSeconds,
    required int antiSnipeSeconds,
  }) = _TimerState;

  factory TimerState.fromJson(Map<String, dynamic> json) =>
      _$TimerStateFromJson(json);
}

/// Mirrors backend `AuctionStateSnapshot` — the first SSE event on connect.
@freezed
abstract class AuctionStateSnapshot with _$AuctionStateSnapshot {
  const factory AuctionStateSnapshot({
    required String leagueName,
    @JsonKey(unknownEnumValue: AuctionStatus.unknown)
    required AuctionStatus auctionStatus,
    RoundConfig? currentRound,
    PlayerAuctionState? currentPlayer,
    int? currentHighestBid,
    String? currentHighestBidderId,
    @Default(<FranchisePurseState>[]) List<FranchisePurseState> franchisePurseStates,
    TimerState? timer,
    @Default(0) int lastSequenceNumber,
  }) = _AuctionStateSnapshot;

  factory AuctionStateSnapshot.fromJson(Map<String, dynamic> json) =>
      _$AuctionStateSnapshotFromJson(json);
}
