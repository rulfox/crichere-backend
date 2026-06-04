// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PageResponse<T> {

 List<T> get content; int get totalElements; int get totalPages;@JsonKey(readValue: _readPageNumber) int get pageNumber;@JsonKey(readValue: _readPageSize) int get pageSize;
/// Create a copy of PageResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageResponseCopyWith<T, PageResponse<T>> get copyWith => _$PageResponseCopyWithImpl<T, PageResponse<T>>(this as PageResponse<T>, _$identity);

  /// Serializes this PageResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageResponse<T>&&const DeepCollectionEquality().equals(other.content, content)&&(identical(other.totalElements, totalElements) || other.totalElements == totalElements)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(content),totalElements,totalPages,pageNumber,pageSize);

@override
String toString() {
  return 'PageResponse<$T>(content: $content, totalElements: $totalElements, totalPages: $totalPages, pageNumber: $pageNumber, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class $PageResponseCopyWith<T,$Res>  {
  factory $PageResponseCopyWith(PageResponse<T> value, $Res Function(PageResponse<T>) _then) = _$PageResponseCopyWithImpl;
@useResult
$Res call({
 List<T> content, int totalElements, int totalPages,@JsonKey(readValue: _readPageNumber) int pageNumber,@JsonKey(readValue: _readPageSize) int pageSize
});




}
/// @nodoc
class _$PageResponseCopyWithImpl<T,$Res>
    implements $PageResponseCopyWith<T, $Res> {
  _$PageResponseCopyWithImpl(this._self, this._then);

  final PageResponse<T> _self;
  final $Res Function(PageResponse<T>) _then;

/// Create a copy of PageResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = null,Object? totalElements = null,Object? totalPages = null,Object? pageNumber = null,Object? pageSize = null,}) {
  return _then(_self.copyWith(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as List<T>,totalElements: null == totalElements ? _self.totalElements : totalElements // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PageResponse].
extension PageResponsePatterns<T> on PageResponse<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PageResponse<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PageResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PageResponse<T> value)  $default,){
final _that = this;
switch (_that) {
case _PageResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PageResponse<T> value)?  $default,){
final _that = this;
switch (_that) {
case _PageResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<T> content,  int totalElements,  int totalPages, @JsonKey(readValue: _readPageNumber)  int pageNumber, @JsonKey(readValue: _readPageSize)  int pageSize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PageResponse() when $default != null:
return $default(_that.content,_that.totalElements,_that.totalPages,_that.pageNumber,_that.pageSize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<T> content,  int totalElements,  int totalPages, @JsonKey(readValue: _readPageNumber)  int pageNumber, @JsonKey(readValue: _readPageSize)  int pageSize)  $default,) {final _that = this;
switch (_that) {
case _PageResponse():
return $default(_that.content,_that.totalElements,_that.totalPages,_that.pageNumber,_that.pageSize);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<T> content,  int totalElements,  int totalPages, @JsonKey(readValue: _readPageNumber)  int pageNumber, @JsonKey(readValue: _readPageSize)  int pageSize)?  $default,) {final _that = this;
switch (_that) {
case _PageResponse() when $default != null:
return $default(_that.content,_that.totalElements,_that.totalPages,_that.pageNumber,_that.pageSize);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class _PageResponse<T> implements PageResponse<T> {
  const _PageResponse({final  List<T> content = const [], this.totalElements = 0, this.totalPages = 0, @JsonKey(readValue: _readPageNumber) this.pageNumber = 0, @JsonKey(readValue: _readPageSize) this.pageSize = 0}): _content = content;
  factory _PageResponse.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$PageResponseFromJson(json,fromJsonT);

 final  List<T> _content;
@override@JsonKey() List<T> get content {
  if (_content is EqualUnmodifiableListView) return _content;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_content);
}

@override@JsonKey() final  int totalElements;
@override@JsonKey() final  int totalPages;
@override@JsonKey(readValue: _readPageNumber) final  int pageNumber;
@override@JsonKey(readValue: _readPageSize) final  int pageSize;

/// Create a copy of PageResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PageResponseCopyWith<T, _PageResponse<T>> get copyWith => __$PageResponseCopyWithImpl<T, _PageResponse<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$PageResponseToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PageResponse<T>&&const DeepCollectionEquality().equals(other._content, _content)&&(identical(other.totalElements, totalElements) || other.totalElements == totalElements)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_content),totalElements,totalPages,pageNumber,pageSize);

@override
String toString() {
  return 'PageResponse<$T>(content: $content, totalElements: $totalElements, totalPages: $totalPages, pageNumber: $pageNumber, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class _$PageResponseCopyWith<T,$Res> implements $PageResponseCopyWith<T, $Res> {
  factory _$PageResponseCopyWith(_PageResponse<T> value, $Res Function(_PageResponse<T>) _then) = __$PageResponseCopyWithImpl;
@override @useResult
$Res call({
 List<T> content, int totalElements, int totalPages,@JsonKey(readValue: _readPageNumber) int pageNumber,@JsonKey(readValue: _readPageSize) int pageSize
});




}
/// @nodoc
class __$PageResponseCopyWithImpl<T,$Res>
    implements _$PageResponseCopyWith<T, $Res> {
  __$PageResponseCopyWithImpl(this._self, this._then);

  final _PageResponse<T> _self;
  final $Res Function(_PageResponse<T>) _then;

/// Create a copy of PageResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = null,Object? totalElements = null,Object? totalPages = null,Object? pageNumber = null,Object? pageSize = null,}) {
  return _then(_PageResponse<T>(
content: null == content ? _self._content : content // ignore: cast_nullable_to_non_nullable
as List<T>,totalElements: null == totalElements ? _self.totalElements : totalElements // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
