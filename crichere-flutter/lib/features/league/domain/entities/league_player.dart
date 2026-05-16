import 'package:freezed_annotation/freezed_annotation.dart';

part 'league_player.freezed.dart';
part 'league_player.g.dart';

// Matches backend LeaguePlayerResponse
// Note: backend does NOT return playerName or franchiseName —
// those are in separate User/Franchise entities.
@freezed
abstract class LeaguePlayer with _$LeaguePlayer {
  const LeaguePlayer._();

  const factory LeaguePlayer({
    required String id,
    required String leagueId,
    // G: backend returns 'userId' not 'playerId'
    @JsonKey(name: 'userId') required String playerId,
    // G: backend doesn't return playerName — make optional
    String? playerName,
    String? playerPhotoUrl,
    required String status,
    // G: backend has basePriceOverride (can be null), also returns basePrice
    int? basePriceOverride,
    @JsonKey(name: 'basePrice') int? basePrice,
    int? finalPrice,
    String? franchiseId,
    String? franchiseName,
    String? category,
    String? tag,
  }) = _LeaguePlayer;

  factory LeaguePlayer.fromJson(Map<String, dynamic> json) => _$LeaguePlayerFromJson(json);
}
