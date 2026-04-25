import 'package:freezed_annotation/freezed_annotation.dart';

part 'league_request.freezed.dart';
part 'league_request.g.dart';

@freezed
class LeagueCreateRequest with _$LeagueCreateRequest {
  const LeagueCreateRequest._();

  const factory LeagueCreateRequest({
    required String name,
    required String format, // T20, ODI, etc.
    required int basePrice,
    required int purseAmount,
    required int maxPlayersPerFranchise,
    required String waitingListMode, // AUTO_PROMOTE, MANUAL
  }) = _LeagueCreateRequest;

  factory LeagueCreateRequest.fromJson(Map<String, dynamic> json) => _$LeagueCreateRequestFromJson(json);
}
