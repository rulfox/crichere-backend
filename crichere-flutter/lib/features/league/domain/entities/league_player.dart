import 'package:freezed_annotation/freezed_annotation.dart';

part 'league_player.freezed.dart';
part 'league_player.g.dart';

@freezed
abstract class LeaguePlayer with _$LeaguePlayer {
  const LeaguePlayer._();

  const factory LeaguePlayer({
    required String id,
    required String leagueId,
    @JsonKey(name: 'userId') required String playerId,
    String? playerName,
    String? playerPhotoUrl,
    required String status,
    int? basePriceOverride,
    @JsonKey(name: 'basePrice') int? basePrice,
    int? finalPrice,
    String? franchiseId,
    String? franchiseName,
    String? category,
    String? tag,
    @Default(false) bool auctionEligible,
  }) = _LeaguePlayer;

  factory LeaguePlayer.fromJson(Map<String, dynamic> json) => _$LeaguePlayerFromJson(json);
}
