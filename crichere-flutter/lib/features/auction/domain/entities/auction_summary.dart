import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:crichere_flutter/core/enums/backend_enums.dart';

part 'auction_summary.freezed.dart';
part 'auction_summary.g.dart';

/// Mirrors backend `AuctionSummaryResponse`.
@freezed
abstract class AuctionSummary with _$AuctionSummary {
  const factory AuctionSummary({
    required String auctionId,
    required String leagueId,
    required String leagueName,
    @JsonKey(unknownEnumValue: AuctionStatus.unknown) AuctionStatus? status,
    DateTime? startedAt,
    DateTime? completedAt,
    @Default(0) int totalPlayers,
    @Default(0) int totalSold,
    @Default(0) int totalUnsold,
    @Default(0) int totalWithdrawn,
    // Backend serializes this as Long; read as int.
    @Default(0) int totalSpent,
    TopBuy? highestSale,
    @Default(<FranchiseResult>[]) List<FranchiseResult> franchiseSummaries,
  }) = _AuctionSummary;

  factory AuctionSummary.fromJson(Map<String, dynamic> json) =>
      _$AuctionSummaryFromJson(json);
}

/// Mirrors backend `SaleSummary`.
@freezed
abstract class TopBuy with _$TopBuy {
  const factory TopBuy({
    required String playerName,
    required String franchiseName,
    required int amount,
  }) = _TopBuy;

  factory TopBuy.fromJson(Map<String, dynamic> json) => _$TopBuyFromJson(json);
}

/// Mirrors backend `AuctionPlayerSummary`.
@freezed
abstract class AuctionPlayerSummary with _$AuctionPlayerSummary {
  const factory AuctionPlayerSummary({
    required String playerName,
    String? playerCategory,
    String? playerTag,
    int? finalPrice,
    String? assignmentType,
    int? roundNumber,
  }) = _AuctionPlayerSummary;

  factory AuctionPlayerSummary.fromJson(Map<String, dynamic> json) =>
      _$AuctionPlayerSummaryFromJson(json);
}

/// Mirrors backend `FranchiseSummary`.
@freezed
abstract class FranchiseResult with _$FranchiseResult {
  const factory FranchiseResult({
    required String franchiseId,
    required String franchiseName,
    @Default(0) int squadCount,
    @Default(0) int totalSpent,
    @Default(0) int remainingPurse,
    @Default(<AuctionPlayerSummary>[]) List<AuctionPlayerSummary> players,
  }) = _FranchiseResult;

  factory FranchiseResult.fromJson(Map<String, dynamic> json) =>
      _$FranchiseResultFromJson(json);
}

/// Mirrors backend `CategoryBreakdown`.
@freezed
abstract class CategoryBreakdown with _$CategoryBreakdown {
  const factory CategoryBreakdown({
    required String category,
    @Default(0) int count,
    @Default(0) int totalSpent,
  }) = _CategoryBreakdown;

  factory CategoryBreakdown.fromJson(Map<String, dynamic> json) =>
      _$CategoryBreakdownFromJson(json);
}

/// Mirrors backend `FranchiseDetailedSummaryResponse`.
@freezed
abstract class FranchiseDetailedSummary with _$FranchiseDetailedSummary {
  const factory FranchiseDetailedSummary({
    required String franchiseId,
    required String franchiseName,
    @Default(0) int squadCount,
    @Default(0) int totalSpent,
    @Default(0) int remainingPurse,
    @Default(<CategoryBreakdown>[]) List<CategoryBreakdown> categoryBreakdown,
    @Default(<AuctionPlayerSummary>[]) List<AuctionPlayerSummary> players,
  }) = _FranchiseDetailedSummary;

  factory FranchiseDetailedSummary.fromJson(Map<String, dynamic> json) =>
      _$FranchiseDetailedSummaryFromJson(json);
}

/// Mirrors backend `UnsoldPlayersResponse`.
@freezed
abstract class UnsoldPlayersResponse with _$UnsoldPlayersResponse {
  const factory UnsoldPlayersResponse({
    @Default(<AuctionPlayerSummary>[]) List<AuctionPlayerSummary> players,
    @Default(0) int totalElements,
    @Default(0) int totalPages,
    @Default(0) int pageNumber,
    @Default(0) int pageSize,
  }) = _UnsoldPlayersResponse;

  factory UnsoldPlayersResponse.fromJson(Map<String, dynamic> json) =>
      _$UnsoldPlayersResponseFromJson(json);
}
