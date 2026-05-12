import 'package:freezed_annotation/freezed_annotation.dart';

part 'auction_summary.freezed.dart';
part 'auction_summary.g.dart';

@freezed
abstract class AuctionSummary with _$AuctionSummary {
  const factory AuctionSummary({
    required String auctionId,
    required String leagueName,
    required int totalPlayersSold,
    required int totalAmountSpent,
    required List<TopBuy> topBuys,
    required List<FranchiseResult> franchiseResults,
    required List<String> unsoldPlayerIds,
    required DateTime completedAt,
  }) = _AuctionSummary;

  factory AuctionSummary.fromJson(Map<String, dynamic> json) => _$AuctionSummaryFromJson(json);
}

@freezed
abstract class TopBuy with _$TopBuy {
  const factory TopBuy({
    required String playerName,
    required String franchiseName,
    required int amount,
  }) = _TopBuy;

  factory TopBuy.fromJson(Map<String, dynamic> json) => _$TopBuyFromJson(json);
}

@freezed
abstract class FranchiseResult with _$FranchiseResult {
  const factory FranchiseResult({
    required String franchiseId,
    required String franchiseName,
    required int totalSpent,
    required int playersCount,
    required int remainingPurse,
  }) = _FranchiseResult;

  factory FranchiseResult.fromJson(Map<String, dynamic> json) => _$FranchiseResultFromJson(json);
}
