import 'package:freezed_annotation/freezed_annotation.dart';

part 'franchise_invite.freezed.dart';
part 'franchise_invite.g.dart';

@freezed
abstract class InviteValidationResponse with _$InviteValidationResponse {
  const factory InviteValidationResponse({
    required String franchiseId,
    required String franchiseName,
    required String leagueId,
    required String leagueName,
    required String invitedBy,
    required DateTime expiresAt,
  }) = _InviteValidationResponse;

  factory InviteValidationResponse.fromJson(Map<String, dynamic> json) => _$InviteValidationResponseFromJson(json);
}

@freezed
abstract class InviteAcceptRequest with _$InviteAcceptRequest {
  const factory InviteAcceptRequest({
    required String token,
  }) = _InviteAcceptRequest;

  factory InviteAcceptRequest.fromJson(Map<String, dynamic> json) => _$InviteAcceptRequestFromJson(json);
}
