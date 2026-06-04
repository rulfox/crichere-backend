import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_response.freezed.dart';
part 'page_response.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class PageResponse<T> with _$PageResponse<T> {
  const factory PageResponse({
    @Default([]) List<T> content,
    @Default(0) int totalElements,
    @Default(0) int totalPages,
    @JsonKey(name: 'number', defaultValue: 0) @Default(0) int pageNumber,
    @JsonKey(name: 'size', defaultValue: 0) @Default(0) int pageSize,
  }) = _PageResponse<T>;

  factory PageResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) {
    // Map Spring Boot's 'number' and 'size' if 'pageNumber' / 'pageSize' are missing
    if (!json.containsKey('pageNumber') && json.containsKey('number')) {
      json['pageNumber'] = json['number'];
    }
    if (!json.containsKey('pageSize') && json.containsKey('size')) {
      json['pageSize'] = json['size'];
    }
    return _$PageResponseFromJson(json, fromJsonT);
  }
}
