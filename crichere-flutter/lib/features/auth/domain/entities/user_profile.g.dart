// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  id: json['id'] as String,
  phone: json['phone'] as String?,
  name: json['name'] as String?,
  email: json['email'] as String?,
  profilePhoto: json['profilePhoto'] as String?,
  profileStatus: $enumDecodeNullable(
    _$ProfileStatusEnumMap,
    json['profileStatus'],
    unknownValue: ProfileStatus.active,
  ),
  playingRole: $enumDecodeNullable(
    _$PlayingRoleEnumMap,
    json['playingRole'],
    unknownValue: PlayingRole.batter,
  ),
  battingStyle: $enumDecodeNullable(
    _$BattingStyleEnumMap,
    json['battingStyle'],
    unknownValue: BattingStyle.rightHand,
  ),
  bowlingStyle: $enumDecodeNullable(
    _$BowlingStyleEnumMap,
    json['bowlingStyle'],
    unknownValue: BowlingStyle.rightArm,
  ),
  bowlingType: $enumDecodeNullable(
    _$BowlingTypeEnumMap,
    json['bowlingType'],
    unknownValue: BowlingType.medium,
  ),
  experienceLevel: $enumDecodeNullable(
    _$ExperienceLevelEnumMap,
    json['experienceLevel'],
    unknownValue: ExperienceLevel.local,
  ),
  jerseyNumber: (json['jerseyNumber'] as num?)?.toInt(),
  dateOfBirth: json['dateOfBirth'] == null
      ? null
      : DateTime.parse(json['dateOfBirth'] as String),
  gender: json['gender'] as String?,
  city: json['city'] as String?,
  state: json['state'] as String?,
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'name': instance.name,
      'email': instance.email,
      'profilePhoto': instance.profilePhoto,
      'profileStatus': _$ProfileStatusEnumMap[instance.profileStatus],
      'playingRole': _$PlayingRoleEnumMap[instance.playingRole],
      'battingStyle': _$BattingStyleEnumMap[instance.battingStyle],
      'bowlingStyle': _$BowlingStyleEnumMap[instance.bowlingStyle],
      'bowlingType': _$BowlingTypeEnumMap[instance.bowlingType],
      'experienceLevel': _$ExperienceLevelEnumMap[instance.experienceLevel],
      'jerseyNumber': instance.jerseyNumber,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'gender': instance.gender,
      'city': instance.city,
      'state': instance.state,
    };

const _$ProfileStatusEnumMap = {
  ProfileStatus.ghost: 'GHOST',
  ProfileStatus.claimed: 'CLAIMED',
  ProfileStatus.active: 'ACTIVE',
};

const _$PlayingRoleEnumMap = {
  PlayingRole.batter: 'BATTER',
  PlayingRole.bowler: 'BOWLER',
  PlayingRole.allRounder: 'ALL_ROUNDER',
  PlayingRole.wicketKeeper: 'WICKET_KEEPER',
};

const _$BattingStyleEnumMap = {
  BattingStyle.rightHand: 'RIGHT_HAND',
  BattingStyle.leftHand: 'LEFT_HAND',
};

const _$BowlingStyleEnumMap = {
  BowlingStyle.rightArm: 'RIGHT_ARM',
  BowlingStyle.leftArm: 'LEFT_ARM',
};

const _$BowlingTypeEnumMap = {
  BowlingType.fast: 'FAST',
  BowlingType.mediumFast: 'MEDIUM_FAST',
  BowlingType.medium: 'MEDIUM',
  BowlingType.offSpin: 'OFF_SPIN',
  BowlingType.legSpin: 'LEG_SPIN',
  BowlingType.slowLeftArm: 'SLOW_LEFT_ARM',
  BowlingType.slowLeftArmOrthodox: 'SLOW_LEFT_ARM_ORTHODOX',
};

const _$ExperienceLevelEnumMap = {
  ExperienceLevel.local: 'LOCAL',
  ExperienceLevel.district: 'DISTRICT',
  ExperienceLevel.state: 'STATE',
  ExperienceLevel.national: 'NATIONAL',
};
