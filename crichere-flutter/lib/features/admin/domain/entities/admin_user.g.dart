// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdminUser _$AdminUserFromJson(Map<String, dynamic> json) => _AdminUser(
  id: json['id'] as String,
  phone: json['phone'] as String?,
  name: json['name'] as String?,
  email: json['email'] as String?,
  profileStatus: json['profileStatus'] as String?,
  suspended: json['suspended'] as bool? ?? false,
  suspensionReason: json['suspensionReason'] as String?,
);

Map<String, dynamic> _$AdminUserToJson(_AdminUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'name': instance.name,
      'email': instance.email,
      'profileStatus': instance.profileStatus,
      'suspended': instance.suspended,
      'suspensionReason': instance.suspensionReason,
    };
