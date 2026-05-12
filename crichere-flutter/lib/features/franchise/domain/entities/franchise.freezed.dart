// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'franchise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Franchise {

 String get id; String get leagueId; String get name; String? get logoUrl; int get startingPurse; int get currentPurse;
/// Create a copy of Franchise
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FranchiseCopyWith<Franchise> get copyWith => _$FranchiseCopyWithImpl<Franchise>(this as Franchise, _$identity);

  /// Serializes this Franchise to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Franchise&&(identical(other.id, id) || other.id == id)&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.name, name) || other.name == name)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.startingPurse, startingPurse) || other.startingPurse == startingPurse)&&(identical(other.currentPurse, currentPurse) || other.currentPurse == currentPurse));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,leagueId,name,logoUrl,startingPurse,currentPurse);

@override
String toString() {
  return 'Franchise(id: $id, leagueId: $leagueId, name: $name, logoUrl: $logoUrl, startingPurse: $startingPurse, currentPurse: $currentPurse)';
}


}

/// @nodoc
abstract mixin class $FranchiseCopyWith<$Res>  {
  factory $FranchiseCopyWith(Franchise value, $Res Function(Franchise) _then) = _$FranchiseCopyWithImpl;
@useResult
$Res call({
 String id, String leagueId, String name, String? logoUrl, int startingPurse, int currentPurse
});




}
/// @nodoc
class _$FranchiseCopyWithImpl<$Res>
    implements $FranchiseCopyWith<$Res> {
  _$FranchiseCopyWithImpl(this._self, this._then);

  final Franchise _self;
  final $Res Function(Franchise) _then;

/// Create a copy of Franchise
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? leagueId = null,Object? name = null,Object? logoUrl = freezed,Object? startingPurse = null,Object? currentPurse = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,startingPurse: null == startingPurse ? _self.startingPurse : startingPurse // ignore: cast_nullable_to_non_nullable
as int,currentPurse: null == currentPurse ? _self.currentPurse : currentPurse // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Franchise].
extension FranchisePatterns on Franchise {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Franchise value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Franchise() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Franchise value)  $default,){
final _that = this;
switch (_that) {
case _Franchise():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Franchise value)?  $default,){
final _that = this;
switch (_that) {
case _Franchise() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String leagueId,  String name,  String? logoUrl,  int startingPurse,  int currentPurse)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Franchise() when $default != null:
return $default(_that.id,_that.leagueId,_that.name,_that.logoUrl,_that.startingPurse,_that.currentPurse);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String leagueId,  String name,  String? logoUrl,  int startingPurse,  int currentPurse)  $default,) {final _that = this;
switch (_that) {
case _Franchise():
return $default(_that.id,_that.leagueId,_that.name,_that.logoUrl,_that.startingPurse,_that.currentPurse);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String leagueId,  String name,  String? logoUrl,  int startingPurse,  int currentPurse)?  $default,) {final _that = this;
switch (_that) {
case _Franchise() when $default != null:
return $default(_that.id,_that.leagueId,_that.name,_that.logoUrl,_that.startingPurse,_that.currentPurse);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Franchise extends Franchise {
  const _Franchise({required this.id, required this.leagueId, required this.name, this.logoUrl, required this.startingPurse, required this.currentPurse}): super._();
  factory _Franchise.fromJson(Map<String, dynamic> json) => _$FranchiseFromJson(json);

@override final  String id;
@override final  String leagueId;
@override final  String name;
@override final  String? logoUrl;
@override final  int startingPurse;
@override final  int currentPurse;

/// Create a copy of Franchise
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FranchiseCopyWith<_Franchise> get copyWith => __$FranchiseCopyWithImpl<_Franchise>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FranchiseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Franchise&&(identical(other.id, id) || other.id == id)&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.name, name) || other.name == name)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.startingPurse, startingPurse) || other.startingPurse == startingPurse)&&(identical(other.currentPurse, currentPurse) || other.currentPurse == currentPurse));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,leagueId,name,logoUrl,startingPurse,currentPurse);

@override
String toString() {
  return 'Franchise(id: $id, leagueId: $leagueId, name: $name, logoUrl: $logoUrl, startingPurse: $startingPurse, currentPurse: $currentPurse)';
}


}

/// @nodoc
abstract mixin class _$FranchiseCopyWith<$Res> implements $FranchiseCopyWith<$Res> {
  factory _$FranchiseCopyWith(_Franchise value, $Res Function(_Franchise) _then) = __$FranchiseCopyWithImpl;
@override @useResult
$Res call({
 String id, String leagueId, String name, String? logoUrl, int startingPurse, int currentPurse
});




}
/// @nodoc
class __$FranchiseCopyWithImpl<$Res>
    implements _$FranchiseCopyWith<$Res> {
  __$FranchiseCopyWithImpl(this._self, this._then);

  final _Franchise _self;
  final $Res Function(_Franchise) _then;

/// Create a copy of Franchise
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? leagueId = null,Object? name = null,Object? logoUrl = freezed,Object? startingPurse = null,Object? currentPurse = null,}) {
  return _then(_Franchise(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,startingPurse: null == startingPurse ? _self.startingPurse : startingPurse // ignore: cast_nullable_to_non_nullable
as int,currentPurse: null == currentPurse ? _self.currentPurse : currentPurse // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
