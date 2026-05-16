import 'package:freezed_annotation/freezed_annotation.dart';

part 'auction_summary.freezed.dart';
part 'auction_summary.g.dart';

// Matches backend AuctionSummaryResponse
@freezed
abstract class AuctionSummary with _$AuctionSummary {
  const factory AuctionSummary({
    required String auctionId,
    required String leagueId,
    required String leagueName,
    // A13: backend uses totalSold not totalPlayersSold
    @JsonKey(name: 'totalSold') required int totalPlayersSold,
    // A13: backend uses totalSpent not totalAmountSpent
    @JsonKey(name: 'totalSpent') required int totalAmountSpent,
    required int totalPlayers,
    required int totalUnsold,
    // A13: backend uses highestSale (singular), not topBuys (list)
    @JsonKey(name: 'highestSale') TopBuy? topBuy,
    // A13: backend uses franchiseSummaries not franchiseResults
    @JsonKey(name: 'franchiseSummaries') required List<FranchiseResult> franchiseResults,
    DateTime? completedAt,
  }) = _AuctionSummary;

  factory AuctionSummary.fromJson(Map<String, dynamic> json) => _$AuctionSummaryFromJson(json);
}

// Matches backend SaleSummary
@freezed
abstract class TopBuy with _$TopBuy {
  const factory TopBuy({
    required String playerName,
    required String franchiseName,
    required int amount,
  }) = _TopBuy;

  factory TopBuy.fromJson(Map<String, dynamic> json) => _$TopBuyFromJson(json);
}

// Matches backend FranchiseSummary
@freezed
abstract class FranchiseResult with _$FranchiseResult {
  const factory FranchiseResult({
    required String franchiseId,
    required String franchiseName,
    // A13: backend uses squadCount not playersCount
    @JsonKey(name: 'squadCount') required int playersCount,
    required int totalSpent,
    required int remainingPurse,
  }) = _FranchiseResult;

  factory FranchiseResult.fromJson(Map<String, dynamic> json) => _$FranchiseResultFromJson(json);
}
