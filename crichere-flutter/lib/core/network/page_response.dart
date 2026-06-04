import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_response.freezed.dart';
part 'page_response.g.dart';

Object? _readPageNumber(Map<dynamic, dynamic> json, String key) {
  return json['pageNumber'] ?? json['number'] ?? 0;
}

Object? _readPageSize(Map<dynamic, dynamic> json, String key) {
  return json['pageSize'] ?? json['size'] ?? 0;
}

@Freezed(genericArgumentFactories: true)
abstract class PageResponse<T> with _$PageResponse<T> {
  const factory PageResponse({
    @Default([]) List<T> content,
    @Default(0) int totalElements,
    @Default(0) int totalPages,
    @JsonKey(readValue: _readPageNumber) @Default(0) int pageNumber,
    @JsonKey(readValue: _readPageSize) @Default(0) int pageSize,
  }) = _PageResponse<T>;

  factory PageResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$PageResponseFromJson(json, fromJsonT);
}
