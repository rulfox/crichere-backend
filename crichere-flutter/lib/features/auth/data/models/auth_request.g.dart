// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) =>
    _LoginRequest(phone: json['phone'] as String);

Map<String, dynamic> _$LoginRequestToJson(_LoginRequest instance) =>
    <String, dynamic>{'phone': instance.phone};

_VerifyRequest _$VerifyRequestFromJson(Map<String, dynamic> json) =>
    _VerifyRequest(phone: json['phone'] as String, otp: json['otp'] as String);

Map<String, dynamic> _$VerifyRequestToJson(_VerifyRequest instance) =>
    <String, dynamic>{'phone': instance.phone, 'otp': instance.otp};

_RefreshRequest _$RefreshRequestFromJson(Map<String, dynamic> json) =>
    _RefreshRequest(refreshToken: json['refreshToken'] as String);

Map<String, dynamic> _$RefreshRequestToJson(_RefreshRequest instance) =>
    <String, dynamic>{'refreshToken': instance.refreshToken};

_ClaimRequest _$ClaimRequestFromJson(Map<String, dynamic> json) =>
    _ClaimRequest(profileId: json['profileId'] as String);

Map<String, dynamic> _$ClaimRequestToJson(_ClaimRequest instance) =>
    <String, dynamic>{'profileId': instance.profileId};
