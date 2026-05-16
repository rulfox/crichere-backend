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

_FranchiseInvite _$FranchiseInviteFromJson(Map<String, dynamic> json) =>
    _FranchiseInvite(
      id: json['id'] as String,
      franchiseId: json['franchiseId'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
      status: json['status'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      inviteUrl: json['inviteUrl'] as String?,
    );

Map<String, dynamic> _$FranchiseInviteToJson(_FranchiseInvite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'franchiseId': instance.franchiseId,
      'email': instance.email,
      'token': instance.token,
      'status': instance.status,
      'expiresAt': instance.expiresAt.toIso8601String(),
      'inviteUrl': instance.inviteUrl,
    };

_InviteAcceptRequest _$InviteAcceptRequestFromJson(Map<String, dynamic> json) =>
    _InviteAcceptRequest(token: json['token'] as String);

Map<String, dynamic> _$InviteAcceptRequestToJson(
  _InviteAcceptRequest instance,
) => <String, dynamic>{'token': instance.token};
