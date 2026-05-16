import 'package:freezed_annotation/freezed_annotation.dart';

part 'franchise_squad.freezed.dart';
part 'franchise_squad.g.dart';

@freezed
class AuctionPlayerSummary with _$AuctionPlayerSummary {
  const factory AuctionPlayerSummary({
    required String playerName,
    String? playerCategory,
    int? finalPrice,
    String? assignmentType,
    int? roundNumber,
  }) = _AuctionPlayerSummary;

  factory AuctionPlayerSummary.fromJson(Map<String, dynamic> json) => _$AuctionPlayerSummaryFromJson(json);
}

@freezed
class FranchiseSquadResponse with _$FranchiseSquadResponse {
  const factory FranchiseSquadResponse({
    required String franchiseId,
    required String franchiseName,
    required List<AuctionPlayerSummary> players,
  }) = _FranchiseSquadResponse;

  factory FranchiseSquadResponse.fromJson(Map<String, dynamic> json) => _$FranchiseSquadResponseFromJson(json);
}
