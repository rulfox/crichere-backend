import 'package:freezed_annotation/freezed_annotation.dart';

part 'league_prices.freezed.dart';
part 'league_prices.g.dart';

/// Mirrors backend `CategoryPriceResponse`.
@freezed
abstract class CategoryPrice with _$CategoryPrice {
  const factory CategoryPrice({
    required String id,
    required String category,
    required int price,
  }) = _CategoryPrice;

  factory CategoryPrice.fromJson(Map<String, dynamic> json) =>
      _$CategoryPriceFromJson(json);
}

/// Mirrors backend `TagPriceResponse`.
@freezed
abstract class TagPrice with _$TagPrice {
  const factory TagPrice({
    required String id,
    required String tag,
    required int price,
  }) = _TagPrice;

  factory TagPrice.fromJson(Map<String, dynamic> json) =>
      _$TagPriceFromJson(json);
}
