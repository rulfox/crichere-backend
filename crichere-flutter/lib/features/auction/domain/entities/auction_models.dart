import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:crichere_flutter/core/enums/backend_enums.dart';

part 'auction_models.freezed.dart';
part 'auction_models.g.dart';

/// Mirrors backend `AuctionResponse`.
@freezed
abstract class AuctionResponse with _$AuctionResponse {
  const factory AuctionResponse({
    required String id,
    required String leagueId,
    String? auctioneerId,
    @JsonKey(unknownEnumValue: AuctionStatus.unknown) required AuctionStatus status,
    String? currentRoundId,
    String? currentLeaguePlayerId,
    DateTime? startedAt,
    DateTime? completedAt,
    String? displayUrl,
    String? publicViewUrl,
    String? publicViewToken,
  }) = _AuctionResponse;

  factory AuctionResponse.fromJson(Map<String, dynamic> json) =>
      _$AuctionResponseFromJson(json);
}

/// Mirrors backend `BidResponse`.
@freezed
abstract class BidResponse with _$BidResponse {
  const factory BidResponse({
    required String id,
    required String auctionId,
    required String roundId,
    required String leaguePlayerId,
    required String franchiseId,
    required int bidAmount,
    @JsonKey(unknownEnumValue: BidStatus.unknown) required BidStatus status,
    String? recordedBy,
    DateTime? bidAt,
  }) = _BidResponse;

  factory BidResponse.fromJson(Map<String, dynamic> json) =>
      _$BidResponseFromJson(json);
}

/// Mirrors backend `CategoryIncrementResponse`.
@freezed
abstract class CategoryIncrement with _$CategoryIncrement {
  const factory CategoryIncrement({
    required String id,
    required String roundId,
    String? category,
    String? tag,
    required int bidIncrement,
  }) = _CategoryIncrement;

  factory CategoryIncrement.fromJson(Map<String, dynamic> json) =>
      _$CategoryIncrementFromJson(json);
}

/// Mirrors backend `AuditLogResponse`.
@freezed
abstract class AuditLogResponse with _$AuditLogResponse {
  const factory AuditLogResponse({
    required String id,
    required String auctionId,
    required int sequenceNumber,
    @JsonKey(unknownEnumValue: AuctionAction.unknown) required AuctionAction action,
    @Default(<String, dynamic>{}) Map<String, dynamic> payload,
    String? actorId,
    DateTime? createdAt,
  }) = _AuditLogResponse;

  factory AuditLogResponse.fromJson(Map<String, dynamic> json) =>
      _$AuditLogResponseFromJson(json);
}
