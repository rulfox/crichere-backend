import 'package:freezed_annotation/freezed_annotation.dart';

part 'waitlist_entities.freezed.dart';
part 'waitlist_entities.g.dart';

@freezed
abstract class WaitlistEntry with _$WaitlistEntry {
  const factory WaitlistEntry({
    required String id,
    required String leagueId,
    required String playerId,
    required String playerName,
    required int position,
    required DateTime createdAt,
  }) = _WaitlistEntry;

  factory WaitlistEntry.fromJson(Map<String, dynamic> json) => _$WaitlistEntryFromJson(json);
}
