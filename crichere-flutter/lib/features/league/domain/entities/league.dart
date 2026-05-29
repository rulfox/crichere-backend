import 'package:freezed_annotation/freezed_annotation.dart';

part 'league.freezed.dart';
part 'league.g.dart';

@freezed
abstract class League with _$League {
  const League._();

  const factory League({
    required String id,
    required String name,
    String? format,
    String? rulesUrl,
    @Default(false) bool mustSellAll,
    @Default('RANDOM') String playerOrderMode,
    @Default('ADMIN_PICKS') String waitingListMode,
    String? logoUrl,
    String? bannerUrl,
    required String status,
    DateTime? auctionDate,
    required String createdBy,
    @Default(<String>[]) List<String> auctionIds,
  }) = _League;

  factory League.fromJson(Map<String, dynamic> json) => _$LeagueFromJson(json);

  /// Convenience: the first/active auction for this league, if any.
  /// (Backend exposes `auctionIds: List<UUID>` with no explicit "current".)
  String? get currentAuctionId => auctionIds.isEmpty ? null : auctionIds.first;
}
