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
    _VerifyRequest(
      phone: json['phone'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$VerifyRequestToJson(_VerifyRequest instance) =>
    <String, dynamic>{'phone': instance.phone, 'code': instance.code};

_RefreshRequest _$RefreshRequestFromJson(Map<String, dynamic> json) =>
    _RefreshRequest(refreshToken: json['refreshToken'] as String);

Map<String, dynamic> _$RefreshRequestToJson(_RefreshRequest instance) =>
    <String, dynamic>{'refreshToken': instance.refreshToken};

_ClaimRequest _$ClaimRequestFromJson(Map<String, dynamic> json) =>
    _ClaimRequest(
      name: json['name'] as String,
      playingRole: $enumDecode(_$PlayingRoleEnumMap, json['playingRole']),
    );

Map<String, dynamic> _$ClaimRequestToJson(_ClaimRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'playingRole': _$PlayingRoleEnumMap[instance.playingRole]!,
    };

const _$PlayingRoleEnumMap = {
  PlayingRole.BATTER: 'BATTER',
  PlayingRole.BOWLER: 'BOWLER',
  PlayingRole.ALL_ROUNDER: 'ALL_ROUNDER',
  PlayingRole.WICKET_KEEPER: 'WICKET_KEEPER',
};

_UserBasicInfoRequest _$UserBasicInfoRequestFromJson(
  Map<String, dynamic> json,
) => _UserBasicInfoRequest(
  name: json['name'] as String?,
  email: json['email'] as String?,
);

Map<String, dynamic> _$UserBasicInfoRequestToJson(
  _UserBasicInfoRequest instance,
) => <String, dynamic>{'name': instance.name, 'email': instance.email};

_CricketProfileRequest _$CricketProfileRequestFromJson(
  Map<String, dynamic> json,
) => _CricketProfileRequest(
  playingRole: $enumDecodeNullable(_$PlayingRoleEnumMap, json['playingRole']),
  battingStyle: $enumDecodeNullable(
    _$BattingStyleEnumMap,
    json['battingStyle'],
  ),
  bowlingStyle: $enumDecodeNullable(
    _$BowlingStyleEnumMap,
    json['bowlingStyle'],
  ),
  bowlingType: $enumDecodeNullable(_$BowlingTypeEnumMap, json['bowlingType']),
  experienceLevel: $enumDecodeNullable(
    _$ExperienceLevelEnumMap,
    json['experienceLevel'],
  ),
  jerseyNumber: (json['jerseyNumber'] as num?)?.toInt(),
  dateOfBirth: json['dateOfBirth'] as String?,
  gender: json['gender'] as String?,
  city: json['city'] as String?,
  state: json['state'] as String?,
);

Map<String, dynamic> _$CricketProfileRequestToJson(
  _CricketProfileRequest instance,
) => <String, dynamic>{
  'playingRole': _$PlayingRoleEnumMap[instance.playingRole],
  'battingStyle': _$BattingStyleEnumMap[instance.battingStyle],
  'bowlingStyle': _$BowlingStyleEnumMap[instance.bowlingStyle],
  'bowlingType': _$BowlingTypeEnumMap[instance.bowlingType],
  'experienceLevel': _$ExperienceLevelEnumMap[instance.experienceLevel],
  'jerseyNumber': instance.jerseyNumber,
  'dateOfBirth': instance.dateOfBirth,
  'gender': instance.gender,
  'city': instance.city,
  'state': instance.state,
};

const _$BattingStyleEnumMap = {
  BattingStyle.RIGHT_HAND: 'RIGHT_HAND',
  BattingStyle.LEFT_HAND: 'LEFT_HAND',
};

const _$BowlingStyleEnumMap = {
  BowlingStyle.RIGHT_ARM: 'RIGHT_ARM',
  BowlingStyle.LEFT_ARM: 'LEFT_ARM',
};

const _$BowlingTypeEnumMap = {
  BowlingType.FAST: 'FAST',
  BowlingType.MEDIUM_FAST: 'MEDIUM_FAST',
  BowlingType.MEDIUM: 'MEDIUM',
  BowlingType.OFF_SPIN: 'OFF_SPIN',
  BowlingType.LEG_SPIN: 'LEG_SPIN',
  BowlingType.SLOW_LEFT_ARM: 'SLOW_LEFT_ARM',
  BowlingType.SLOW_LEFT_ARM_ORTHODOX: 'SLOW_LEFT_ARM_ORTHODOX',
};

const _$ExperienceLevelEnumMap = {
  ExperienceLevel.LOCAL: 'LOCAL',
  ExperienceLevel.DISTRICT: 'DISTRICT',
  ExperienceLevel.STATE: 'STATE',
  ExperienceLevel.NATIONAL: 'NATIONAL',
};
