// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'franchise_invite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InviteValidationResponse _$InviteValidationResponseFromJson(
  Map<String, dynamic> json,
) => _InviteValidationResponse(
  franchiseId: json['franchiseId'] as String,
  franchiseName: json['franchiseName'] as String,
  leagueId: json['leagueId'] as String,
  leagueName: json['leagueName'] as String,
  invitedBy: json['invitedBy'] as String,
  expiresAt: DateTime.parse(json['expiresAt'] as String),
);

Map<String, dynamic> _$InviteValidationResponseToJson(
  _InviteValidationResponse instance,
) => <String, dynamic>{
  'franchiseId': instance.franchiseId,
  'franchiseName': instance.franchiseName,
  'leagueId': instance.leagueId,
  'leagueName': instance.leagueName,
  'invitedBy': instance.invitedBy,
  'expiresAt': instance.expiresAt.toIso8601String(),
};

_InviteAcceptRequest _$InviteAcceptRequestFromJson(Map<String, dynamic> json) =>
    _InviteAcceptRequest(token: json['token'] as String);

Map<String, dynamic> _$InviteAcceptRequestToJson(
  _InviteAcceptRequest instance,
) => <String, dynamic>{'token': instance.token};
