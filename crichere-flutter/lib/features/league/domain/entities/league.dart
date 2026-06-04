import 'package:freezed_annotation/freezed_annotation.dart';

part 'league.freezed.dart';
part 'league.g.dart';

DateTime? _parseDate(dynamic value) {
  if (value == null) return null;
  if (value is String) return DateTime.tryParse(value);
  if (value is num) {
    // If > 1e11, it's likely milliseconds. Otherwise seconds (or float seconds)
    if (value > 100000000000) return DateTime.fromMillisecondsSinceEpoch(value.toInt());
    return DateTime.fromMillisecondsSinceEpoch((value * 1000).toInt());
  }
  return null;
}

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
    @JsonKey(fromJson: _parseDate) DateTime? auctionDate,
    required String createdBy,
    @Default(<String>[]) List<String> auctionIds,
  }) = _League;

  factory League.fromJson(Map<String, dynamic> json) => _$LeagueFromJson(json);

  /// Convenience: the first/active auction for this league, if any.
  /// (Backend exposes `auctionIds: List<UUID>` with no explicit "current".)
  String? get currentAuctionId => auctionIds.isEmpty ? null : auctionIds.first;
}
