// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waitlist_entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WaitlistEntry _$WaitlistEntryFromJson(Map<String, dynamic> json) =>
    _WaitlistEntry(
      id: json['id'] as String,
      leagueId: json['leagueId'] as String,
      userId: json['userId'] as String,
      franchiseId: json['franchiseId'] as String?,
      type: json['type'] as String,
      position: (json['position'] as num).toInt(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      promotedAt: json['promotedAt'] == null
          ? null
          : DateTime.parse(json['promotedAt'] as String),
    );

Map<String, dynamic> _$WaitlistEntryToJson(_WaitlistEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'leagueId': instance.leagueId,
      'userId': instance.userId,
      'franchiseId': instance.franchiseId,
      'type': instance.type,
      'position': instance.position,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'promotedAt': instance.promotedAt?.toIso8601String(),
    };

_WaitlistPagedResponse _$WaitlistPagedResponseFromJson(
  Map<String, dynamic> json,
) => _WaitlistPagedResponse(
  entries: (json['entries'] as List<dynamic>)
      .map((e) => WaitlistEntry.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalElements: (json['totalElements'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  pageNumber: (json['pageNumber'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
);

Map<String, dynamic> _$WaitlistPagedResponseToJson(
  _WaitlistPagedResponse instance,
) => <String, dynamic>{
  'entries': instance.entries,
  'totalElements': instance.totalElements,
  'totalPages': instance.totalPages,
  'pageNumber': instance.pageNumber,
  'pageSize': instance.pageSize,
};
