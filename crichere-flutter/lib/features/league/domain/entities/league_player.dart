import 'package:freezed_annotation/freezed_annotation.dart';

part 'league_player.freezed.dart';
part 'league_player.g.dart';

@freezed
abstract class LeaguePlayer with _$LeaguePlayer {
  const LeaguePlayer._();

  const factory LeaguePlayer({
    required String id,
    required String leagueId,
    required String playerId,
    required String playerName,
    String? playerPhotoUrl,
    required String status,
    int? basePriceOverride,
    int? finalPrice,
    String? franchiseId,
    String? franchiseName,
  }) = _LeaguePlayer;

  factory LeaguePlayer.fromJson(Map<String, dynamic> json) => _$LeaguePlayerFromJson(json);
}
