// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'league_prices.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CategoryPrice {

 String get id; String get category; int get price;
/// Create a copy of CategoryPrice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryPriceCopyWith<CategoryPrice> get copyWith => _$CategoryPriceCopyWithImpl<CategoryPrice>(this as CategoryPrice, _$identity);

  /// Serializes this CategoryPrice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryPrice&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.price, price) || other.price == price));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,category,price);

@override
String toString() {
  return 'CategoryPrice(id: $id, category: $category, price: $price)';
}


}

/// @nodoc
abstract mixin class $CategoryPriceCopyWith<$Res>  {
  factory $CategoryPriceCopyWith(CategoryPrice value, $Res Function(CategoryPrice) _then) = _$CategoryPriceCopyWithImpl;
@useResult
$Res call({
 String id, String category, int price
});




}
/// @nodoc
class _$CategoryPriceCopyWithImpl<$Res>
    implements $CategoryPriceCopyWith<$Res> {
  _$CategoryPriceCopyWithImpl(this._self, this._then);

  final CategoryPrice _self;
  final $Res Function(CategoryPrice) _then;

/// Create a copy of CategoryPrice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? category = null,Object? price = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryPrice].
extension CategoryPricePatterns on CategoryPrice {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryPrice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryPrice() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryPrice value)  $default,){
final _that = this;
switch (_that) {
case _CategoryPrice():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryPrice value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryPrice() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String category,  int price)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryPrice() when $default != null:
return $default(_that.id,_that.category,_that.price);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String category,  int price)  $default,) {final _that = this;
switch (_that) {
case _CategoryPrice():
return $default(_that.id,_that.category,_that.price);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String category,  int price)?  $default,) {final _that = this;
switch (_that) {
case _CategoryPrice() when $default != null:
return $default(_that.id,_that.category,_that.price);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CategoryPrice implements CategoryPrice {
  const _CategoryPrice({required this.id, required this.category, required this.price});
  factory _CategoryPrice.fromJson(Map<String, dynamic> json) => _$CategoryPriceFromJson(json);

@override final  String id;
@override final  String category;
@override final  int price;

/// Create a copy of CategoryPrice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryPriceCopyWith<_CategoryPrice> get copyWith => __$CategoryPriceCopyWithImpl<_CategoryPrice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategoryPriceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryPrice&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.price, price) || other.price == price));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,category,price);

@override
String toString() {
  return 'CategoryPrice(id: $id, category: $category, price: $price)';
}


}

/// @nodoc
abstract mixin class _$CategoryPriceCopyWith<$Res> implements $CategoryPriceCopyWith<$Res> {
  factory _$CategoryPriceCopyWith(_CategoryPrice value, $Res Function(_CategoryPrice) _then) = __$CategoryPriceCopyWithImpl;
@override @useResult
$Res call({
 String id, String category, int price
});




}
/// @nodoc
class __$CategoryPriceCopyWithImpl<$Res>
    implements _$CategoryPriceCopyWith<$Res> {
  __$CategoryPriceCopyWithImpl(this._self, this._then);

  final _CategoryPrice _self;
  final $Res Function(_CategoryPrice) _then;

/// Create a copy of CategoryPrice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? category = null,Object? price = null,}) {
  return _then(_CategoryPrice(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TagPrice {

 String get id; String get tag; int get price;
/// Create a copy of TagPrice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TagPriceCopyWith<TagPrice> get copyWith => _$TagPriceCopyWithImpl<TagPrice>(this as TagPrice, _$identity);

  /// Serializes this TagPrice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TagPrice&&(identical(other.id, id) || other.id == id)&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.price, price) || other.price == price));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tag,price);

@override
String toString() {
  return 'TagPrice(id: $id, tag: $tag, price: $price)';
}


}

/// @nodoc
abstract mixin class $TagPriceCopyWith<$Res>  {
  factory $TagPriceCopyWith(TagPrice value, $Res Function(TagPrice) _then) = _$TagPriceCopyWithImpl;
@useResult
$Res call({
 String id, String tag, int price
});




}
/// @nodoc
class _$TagPriceCopyWithImpl<$Res>
    implements $TagPriceCopyWith<$Res> {
  _$TagPriceCopyWithImpl(this._self, this._then);

  final TagPrice _self;
  final $Res Function(TagPrice) _then;

/// Create a copy of TagPrice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tag = null,Object? price = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TagPrice].
extension TagPricePatterns on TagPrice {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TagPrice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TagPrice() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TagPrice value)  $default,){
final _that = this;
switch (_that) {
case _TagPrice():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TagPrice value)?  $default,){
final _that = this;
switch (_that) {
case _TagPrice() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tag,  int price)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TagPrice() when $default != null:
return $default(_that.id,_that.tag,_that.price);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tag,  int price)  $default,) {final _that = this;
switch (_that) {
case _TagPrice():
return $default(_that.id,_that.tag,_that.price);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tag,  int price)?  $default,) {final _that = this;
switch (_that) {
case _TagPrice() when $default != null:
return $default(_that.id,_that.tag,_that.price);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TagPrice implements TagPrice {
  const _TagPrice({required this.id, required this.tag, required this.price});
  factory _TagPrice.fromJson(Map<String, dynamic> json) => _$TagPriceFromJson(json);

@override final  String id;
@override final  String tag;
@override final  int price;

/// Create a copy of TagPrice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TagPriceCopyWith<_TagPrice> get copyWith => __$TagPriceCopyWithImpl<_TagPrice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TagPriceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TagPrice&&(identical(other.id, id) || other.id == id)&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.price, price) || other.price == price));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tag,price);

@override
String toString() {
  return 'TagPrice(id: $id, tag: $tag, price: $price)';
}


}

/// @nodoc
abstract mixin class _$TagPriceCopyWith<$Res> implements $TagPriceCopyWith<$Res> {
  factory _$TagPriceCopyWith(_TagPrice value, $Res Function(_TagPrice) _then) = __$TagPriceCopyWithImpl;
@override @useResult
$Res call({
 String id, String tag, int price
});




}
/// @nodoc
class __$TagPriceCopyWithImpl<$Res>
    implements _$TagPriceCopyWith<$Res> {
  __$TagPriceCopyWithImpl(this._self, this._then);

  final _TagPrice _self;
  final $Res Function(_TagPrice) _then;

/// Create a copy of TagPrice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tag = null,Object? price = null,}) {
  return _then(_TagPrice(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
