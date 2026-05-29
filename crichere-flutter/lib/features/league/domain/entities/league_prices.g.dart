// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league_prices.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategoryPrice _$CategoryPriceFromJson(Map<String, dynamic> json) =>
    _CategoryPrice(
      id: json['id'] as String,
      category: json['category'] as String,
      price: (json['price'] as num).toInt(),
    );

Map<String, dynamic> _$CategoryPriceToJson(_CategoryPrice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'price': instance.price,
    };

_TagPrice _$TagPriceFromJson(Map<String, dynamic> json) => _TagPrice(
  id: json['id'] as String,
  tag: json['tag'] as String,
  price: (json['price'] as num).toInt(),
);

Map<String, dynamic> _$TagPriceToJson(_TagPrice instance) => <String, dynamic>{
  'id': instance.id,
  'tag': instance.tag,
  'price': instance.price,
};
