import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_response.freezed.dart';
part 'page_response.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class PageResponse<T> with _$PageResponse<T> {
  const factory PageResponse({
    required List<T> content,
    required int totalElements,
    required int totalPages,
    required int pageNumber,
    required int pageSize,
  }) = _PageResponse<T>;

  factory PageResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$PageResponseFromJson(json, fromJsonT);
}
