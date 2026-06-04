// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PageResponse<T> _$PageResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _PageResponse<T>(
  content:
      (json['content'] as List<dynamic>?)?.map(fromJsonT).toList() ?? const [],
  totalElements: (json['totalElements'] as num?)?.toInt() ?? 0,
  totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
  pageNumber: (_readPageNumber(json, 'pageNumber') as num?)?.toInt() ?? 0,
  pageSize: (_readPageSize(json, 'pageSize') as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$PageResponseToJson<T>(
  _PageResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'content': instance.content.map(toJsonT).toList(),
  'totalElements': instance.totalElements,
  'totalPages': instance.totalPages,
  'pageNumber': instance.pageNumber,
  'pageSize': instance.pageSize,
};
