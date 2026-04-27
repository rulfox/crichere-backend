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
  }) = _League;

  factory League.fromJson(Map<String, dynamic> json) => _$LeagueFromJson(json);
}
