import 'package:freezed_annotation/freezed_annotation.dart';

part 'forfeit_entities.freezed.dart';
part 'forfeit_entities.g.dart';
@freezed
abstract class ForfeitRequest with _$ForfeitRequest {
  const factory ForfeitRequest({
    required String id,
    required String leagueId,
    required String entityId,
    required String entityName,
    required String type, // PLAYER, FRANCHISE
    required String reason,
    required String status, // PENDING, APPROVED, REJECTED
    required DateTime createdAt,
    int? refundAmount,
    bool? promoteNext,
  }) = _ForfeitRequest;

  factory ForfeitRequest.fromJson(Map<String, dynamic> json) => _$ForfeitRequestFromJson(json);
}
