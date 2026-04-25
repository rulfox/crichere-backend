// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'franchise_player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FranchisePlayer {

 String get playerId; String get name; String? get photoUrl; String get role; int get price; String get assignmentType;
/// Create a copy of FranchisePlayer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FranchisePlayerCopyWith<FranchisePlayer> get copyWith => _$FranchisePlayerCopyWithImpl<FranchisePlayer>(this as FranchisePlayer, _$identity);

  /// Serializes this FranchisePlayer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FranchisePlayer&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.role, role) || other.role == role)&&(identical(other.price, price) || other.price == price)&&(identical(other.assignmentType, assignmentType) || other.assignmentType == assignmentType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,name,photoUrl,role,price,assignmentType);

@override
String toString() {
  return 'FranchisePlayer(playerId: $playerId, name: $name, photoUrl: $photoUrl, role: $role, price: $price, assignmentType: $assignmentType)';
}


}

/// @nodoc
abstract mixin class $FranchisePlayerCopyWith<$Res>  {
  factory $FranchisePlayerCopyWith(FranchisePlayer value, $Res Function(FranchisePlayer) _then) = _$FranchisePlayerCopyWithImpl;
@useResult
$Res call({
 String playerId, String name, String? photoUrl, String role, int price, String assignmentType
});




}
/// @nodoc
class _$FranchisePlayerCopyWithImpl<$Res>
    implements $FranchisePlayerCopyWith<$Res> {
  _$FranchisePlayerCopyWithImpl(this._self, this._then);

  final FranchisePlayer _self;
  final $Res Function(FranchisePlayer) _then;

/// Create a copy of FranchisePlayer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? name = null,Object? photoUrl = freezed,Object? role = null,Object? price = null,Object? assignmentType = null,}) {
  return _then(_self.copyWith(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,assignmentType: null == assignmentType ? _self.assignmentType : assignmentType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FranchisePlayer].
extension FranchisePlayerPatterns on FranchisePlayer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FranchisePlayer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FranchisePlayer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FranchisePlayer value)  $default,){
final _that = this;
switch (_that) {
case _FranchisePlayer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FranchisePlayer value)?  $default,){
final _that = this;
switch (_that) {
case _FranchisePlayer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerId,  String name,  String? photoUrl,  String role,  int price,  String assignmentType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FranchisePlayer() when $default != null:
return $default(_that.playerId,_that.name,_that.photoUrl,_that.role,_that.price,_that.assignmentType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerId,  String name,  String? photoUrl,  String role,  int price,  String assignmentType)  $default,) {final _that = this;
switch (_that) {
case _FranchisePlayer():
return $default(_that.playerId,_that.name,_that.photoUrl,_that.role,_that.price,_that.assignmentType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerId,  String name,  String? photoUrl,  String role,  int price,  String assignmentType)?  $default,) {final _that = this;
switch (_that) {
case _FranchisePlayer() when $default != null:
return $default(_that.playerId,_that.name,_that.photoUrl,_that.role,_that.price,_that.assignmentType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FranchisePlayer implements FranchisePlayer {
  const _FranchisePlayer({required this.playerId, required this.name, this.photoUrl, required this.role, required this.price, required this.assignmentType});
  factory _FranchisePlayer.fromJson(Map<String, dynamic> json) => _$FranchisePlayerFromJson(json);

@override final  String playerId;
@override final  String name;
@override final  String? photoUrl;
@override final  String role;
@override final  int price;
@override final  String assignmentType;

/// Create a copy of FranchisePlayer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FranchisePlayerCopyWith<_FranchisePlayer> get copyWith => __$FranchisePlayerCopyWithImpl<_FranchisePlayer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FranchisePlayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FranchisePlayer&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.role, role) || other.role == role)&&(identical(other.price, price) || other.price == price)&&(identical(other.assignmentType, assignmentType) || other.assignmentType == assignmentType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,name,photoUrl,role,price,assignmentType);

@override
String toString() {
  return 'FranchisePlayer(playerId: $playerId, name: $name, photoUrl: $photoUrl, role: $role, price: $price, assignmentType: $assignmentType)';
}


}

/// @nodoc
abstract mixin class _$FranchisePlayerCopyWith<$Res> implements $FranchisePlayerCopyWith<$Res> {
  factory _$FranchisePlayerCopyWith(_FranchisePlayer value, $Res Function(_FranchisePlayer) _then) = __$FranchisePlayerCopyWithImpl;
@override @useResult
$Res call({
 String playerId, String name, String? photoUrl, String role, int price, String assignmentType
});




}
/// @nodoc
class __$FranchisePlayerCopyWithImpl<$Res>
    implements _$FranchisePlayerCopyWith<$Res> {
  __$FranchisePlayerCopyWithImpl(this._self, this._then);

  final _FranchisePlayer _self;
  final $Res Function(_FranchisePlayer) _then;

/// Create a copy of FranchisePlayer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? name = null,Object? photoUrl = freezed,Object? role = null,Object? price = null,Object? assignmentType = null,}) {
  return _then(_FranchisePlayer(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,assignmentType: null == assignmentType ? _self.assignmentType : assignmentType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
