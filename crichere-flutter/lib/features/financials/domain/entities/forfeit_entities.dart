import 'package:freezed_annotation/freezed_annotation.dart';

part 'forfeit_entities.freezed.dart';
part 'forfeit_entities.g.dart';

// Matches backend ForfeitRequestResponse
@freezed
abstract class ForfeitRequest with _$ForfeitRequest {
  const factory ForfeitRequest({
    required String id,
    required String leagueId,
    required String userId,
    String? franchiseId,
    required String type,    // PLAYER, FRANCHISE
    required String reason,
    required String status,  // PENDING, APPROVED, REJECTED
    String? feeRefundDecision,
    int? feeRefundAmount,
    String? adminNotes,
    required DateTime createdAt,
    DateTime? resolvedAt,
  }) = _ForfeitRequest;

  factory ForfeitRequest.fromJson(Map<String, dynamic> json) => _$ForfeitRequestFromJson(json);
}

// Matches backend ForfeitRequestListResponse (paginated)
@freezed
abstract class ForfeitRequestListResponse with _$ForfeitRequestListResponse {
  const factory ForfeitRequestListResponse({
    required List<ForfeitRequest> requests,
    required int totalElements,
    required int totalPages,
    required int pageNumber,
    required int pageSize,
  }) = _ForfeitRequestListResponse;

  factory ForfeitRequestListResponse.fromJson(Map<String, dynamic> json) => _$ForfeitRequestListResponseFromJson(json);
}
