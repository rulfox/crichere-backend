// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) =>
    _AuthResponse(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      userId: _readUserId(json, 'userId') as String?,
      phone: json['phone'] as String?,
      name: json['name'] as String?,
      profileStatus: $enumDecodeNullable(
        _$ProfileStatusEnumMap,
        json['profileStatus'],
      ),
      isNewUser: json['isNewUser'] as bool? ?? false,
      profileId: json['profileId'] as String?,
    );

Map<String, dynamic> _$AuthResponseToJson(_AuthResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'userId': instance.userId,
      'phone': instance.phone,
      'name': instance.name,
      'profileStatus': _$ProfileStatusEnumMap[instance.profileStatus],
      'isNewUser': instance.isNewUser,
      'profileId': instance.profileId,
    };

const _$ProfileStatusEnumMap = {
  ProfileStatus.ghost: 'GHOST',
  ProfileStatus.claimed: 'CLAIMED',
  ProfileStatus.active: 'ACTIVE',
};
