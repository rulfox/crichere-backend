// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forfeit_entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ForfeitRequest _$ForfeitRequestFromJson(Map<String, dynamic> json) =>
    _ForfeitRequest(
      id: json['id'] as String,
      leagueId: json['leagueId'] as String,
      userId: json['userId'] as String,
      franchiseId: json['franchiseId'] as String?,
      type: json['type'] as String,
      reason: json['reason'] as String,
      status: json['status'] as String,
      feeRefundDecision: json['feeRefundDecision'] as String?,
      feeRefundAmount: (json['feeRefundAmount'] as num?)?.toInt(),
      adminNotes: json['adminNotes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      resolvedAt: json['resolvedAt'] == null
          ? null
          : DateTime.parse(json['resolvedAt'] as String),
    );

Map<String, dynamic> _$ForfeitRequestToJson(_ForfeitRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'leagueId': instance.leagueId,
      'userId': instance.userId,
      'franchiseId': instance.franchiseId,
      'type': instance.type,
      'reason': instance.reason,
      'status': instance.status,
      'feeRefundDecision': instance.feeRefundDecision,
      'feeRefundAmount': instance.feeRefundAmount,
      'adminNotes': instance.adminNotes,
      'createdAt': instance.createdAt.toIso8601String(),
      'resolvedAt': instance.resolvedAt?.toIso8601String(),
    };

_ForfeitRequestListResponse _$ForfeitRequestListResponseFromJson(
  Map<String, dynamic> json,
) => _ForfeitRequestListResponse(
  requests: (json['requests'] as List<dynamic>)
      .map((e) => ForfeitRequest.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalElements: (json['totalElements'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  pageNumber: (json['pageNumber'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
);

Map<String, dynamic> _$ForfeitRequestListResponseToJson(
  _ForfeitRequestListResponse instance,
) => <String, dynamic>{
  'requests': instance.requests,
  'totalElements': instance.totalElements,
  'totalPages': instance.totalPages,
  'pageNumber': instance.pageNumber,
  'pageSize': instance.pageSize,
};
