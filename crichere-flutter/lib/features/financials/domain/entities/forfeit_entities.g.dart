// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forfeit_entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ForfeitRequest _$ForfeitRequestFromJson(Map<String, dynamic> json) =>
    _ForfeitRequest(
      id: json['id'] as String,
      leagueId: json['leagueId'] as String,
      entityId: json['entityId'] as String,
      entityName: json['entityName'] as String,
      type: json['type'] as String,
      reason: json['reason'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      refundAmount: (json['refundAmount'] as num?)?.toInt(),
      promoteNext: json['promoteNext'] as bool?,
    );

Map<String, dynamic> _$ForfeitRequestToJson(_ForfeitRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'leagueId': instance.leagueId,
      'entityId': instance.entityId,
      'entityName': instance.entityName,
      'type': instance.type,
      'reason': instance.reason,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'refundAmount': instance.refundAmount,
      'promoteNext': instance.promoteNext,
    };
