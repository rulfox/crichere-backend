import 'package:freezed_annotation/freezed_annotation.dart';

part 'league_request.freezed.dart';
part 'league_request.g.dart';

// Matches backend LeagueCreateRequest
@freezed
abstract class LeagueCreateRequest with _$LeagueCreateRequest {
  const LeagueCreateRequest._();

  const factory LeagueCreateRequest({
    required String name,
    String? format,
    String? rulesUrl,
    @Default(false) bool mustSellAll,
    @Default('RANDOM') String playerOrderMode,
    @Default('ADMIN_PICKS') String waitingListMode,
    String? logoUrl,
    String? bannerUrl,
    String? auctionDate, // ISO-8601 string sent to backend as Instant
  }) = _LeagueCreateRequest;

  factory LeagueCreateRequest.fromJson(Map<String, dynamic> json) => _$LeagueCreateRequestFromJson(json);
}
