import 'package:freezed_annotation/freezed_annotation.dart';

part 'waitlist_entities.freezed.dart';
part 'waitlist_entities.g.dart';

// Matches backend WaitingListEntryResponse
@freezed
abstract class WaitlistEntry with _$WaitlistEntry {
  const factory WaitlistEntry({
    required String id,
    required String leagueId,
    required String userId,
    String? franchiseId,
    required String type,    // PLAYER, FRANCHISE
    required int position,
    required String status,  // WAITING, PROMOTED, WITHDRAWN
    required DateTime createdAt,
    DateTime? promotedAt,
  }) = _WaitlistEntry;

  factory WaitlistEntry.fromJson(Map<String, dynamic> json) => _$WaitlistEntryFromJson(json);
}

// Matches backend WaitingListResponse (paginated wrapper)
@freezed
abstract class WaitlistPagedResponse with _$WaitlistPagedResponse {
  const factory WaitlistPagedResponse({
    required List<WaitlistEntry> entries,
    required int totalElements,
    required int totalPages,
    required int pageNumber,
    required int pageSize,
  }) = _WaitlistPagedResponse;

  factory WaitlistPagedResponse.fromJson(Map<String, dynamic> json) => _$WaitlistPagedResponseFromJson(json);
}
