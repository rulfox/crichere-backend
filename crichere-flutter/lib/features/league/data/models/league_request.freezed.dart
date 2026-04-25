// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'league_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeagueCreateRequest {

 String get name; String get format;// T20, ODI, etc.
 int get basePrice; int get purseAmount; int get maxPlayersPerFranchise; String get waitingListMode;
/// Create a copy of LeagueCreateRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeagueCreateRequestCopyWith<LeagueCreateRequest> get copyWith => _$LeagueCreateRequestCopyWithImpl<LeagueCreateRequest>(this as LeagueCreateRequest, _$identity);

  /// Serializes this LeagueCreateRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeagueCreateRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.format, format) || other.format == format)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.purseAmount, purseAmount) || other.purseAmount == purseAmount)&&(identical(other.maxPlayersPerFranchise, maxPlayersPerFranchise) || other.maxPlayersPerFranchise == maxPlayersPerFranchise)&&(identical(other.waitingListMode, waitingListMode) || other.waitingListMode == waitingListMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,format,basePrice,purseAmount,maxPlayersPerFranchise,waitingListMode);

@override
String toString() {
  return 'LeagueCreateRequest(name: $name, format: $format, basePrice: $basePrice, purseAmount: $purseAmount, maxPlayersPerFranchise: $maxPlayersPerFranchise, waitingListMode: $waitingListMode)';
}


}

/// @nodoc
abstract mixin class $LeagueCreateRequestCopyWith<$Res>  {
  factory $LeagueCreateRequestCopyWith(LeagueCreateRequest value, $Res Function(LeagueCreateRequest) _then) = _$LeagueCreateRequestCopyWithImpl;
@useResult
$Res call({
 String name, String format, int basePrice, int purseAmount, int maxPlayersPerFranchise, String waitingListMode
});




}
/// @nodoc
class _$LeagueCreateRequestCopyWithImpl<$Res>
    implements $LeagueCreateRequestCopyWith<$Res> {
  _$LeagueCreateRequestCopyWithImpl(this._self, this._then);

  final LeagueCreateRequest _self;
  final $Res Function(LeagueCreateRequest) _then;

/// Create a copy of LeagueCreateRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? format = null,Object? basePrice = null,Object? purseAmount = null,Object? maxPlayersPerFranchise = null,Object? waitingListMode = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,basePrice: null == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as int,purseAmount: null == purseAmount ? _self.purseAmount : purseAmount // ignore: cast_nullable_to_non_nullable
as int,maxPlayersPerFranchise: null == maxPlayersPerFranchise ? _self.maxPlayersPerFranchise : maxPlayersPerFranchise // ignore: cast_nullable_to_non_nullable
as int,waitingListMode: null == waitingListMode ? _self.waitingListMode : waitingListMode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LeagueCreateRequest].
extension LeagueCreateRequestPatterns on LeagueCreateRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeagueCreateRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeagueCreateRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeagueCreateRequest value)  $default,){
final _that = this;
switch (_that) {
case _LeagueCreateRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeagueCreateRequest value)?  $default,){
final _that = this;
switch (_that) {
case _LeagueCreateRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String format,  int basePrice,  int purseAmount,  int maxPlayersPerFranchise,  String waitingListMode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeagueCreateRequest() when $default != null:
return $default(_that.name,_that.format,_that.basePrice,_that.purseAmount,_that.maxPlayersPerFranchise,_that.waitingListMode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String format,  int basePrice,  int purseAmount,  int maxPlayersPerFranchise,  String waitingListMode)  $default,) {final _that = this;
switch (_that) {
case _LeagueCreateRequest():
return $default(_that.name,_that.format,_that.basePrice,_that.purseAmount,_that.maxPlayersPerFranchise,_that.waitingListMode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String format,  int basePrice,  int purseAmount,  int maxPlayersPerFranchise,  String waitingListMode)?  $default,) {final _that = this;
switch (_that) {
case _LeagueCreateRequest() when $default != null:
return $default(_that.name,_that.format,_that.basePrice,_that.purseAmount,_that.maxPlayersPerFranchise,_that.waitingListMode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeagueCreateRequest extends LeagueCreateRequest {
  const _LeagueCreateRequest({required this.name, required this.format, required this.basePrice, required this.purseAmount, required this.maxPlayersPerFranchise, required this.waitingListMode}): super._();
  factory _LeagueCreateRequest.fromJson(Map<String, dynamic> json) => _$LeagueCreateRequestFromJson(json);

@override final  String name;
@override final  String format;
// T20, ODI, etc.
@override final  int basePrice;
@override final  int purseAmount;
@override final  int maxPlayersPerFranchise;
@override final  String waitingListMode;

/// Create a copy of LeagueCreateRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeagueCreateRequestCopyWith<_LeagueCreateRequest> get copyWith => __$LeagueCreateRequestCopyWithImpl<_LeagueCreateRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeagueCreateRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeagueCreateRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.format, format) || other.format == format)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.purseAmount, purseAmount) || other.purseAmount == purseAmount)&&(identical(other.maxPlayersPerFranchise, maxPlayersPerFranchise) || other.maxPlayersPerFranchise == maxPlayersPerFranchise)&&(identical(other.waitingListMode, waitingListMode) || other.waitingListMode == waitingListMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,format,basePrice,purseAmount,maxPlayersPerFranchise,waitingListMode);

@override
String toString() {
  return 'LeagueCreateRequest(name: $name, format: $format, basePrice: $basePrice, purseAmount: $purseAmount, maxPlayersPerFranchise: $maxPlayersPerFranchise, waitingListMode: $waitingListMode)';
}


}

/// @nodoc
abstract mixin class _$LeagueCreateRequestCopyWith<$Res> implements $LeagueCreateRequestCopyWith<$Res> {
  factory _$LeagueCreateRequestCopyWith(_LeagueCreateRequest value, $Res Function(_LeagueCreateRequest) _then) = __$LeagueCreateRequestCopyWithImpl;
@override @useResult
$Res call({
 String name, String format, int basePrice, int purseAmount, int maxPlayersPerFranchise, String waitingListMode
});




}
/// @nodoc
class __$LeagueCreateRequestCopyWithImpl<$Res>
    implements _$LeagueCreateRequestCopyWith<$Res> {
  __$LeagueCreateRequestCopyWithImpl(this._self, this._then);

  final _LeagueCreateRequest _self;
  final $Res Function(_LeagueCreateRequest) _then;

/// Create a copy of LeagueCreateRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? format = null,Object? basePrice = null,Object? purseAmount = null,Object? maxPlayersPerFranchise = null,Object? waitingListMode = null,}) {
  return _then(_LeagueCreateRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,basePrice: null == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as int,purseAmount: null == purseAmount ? _self.purseAmount : purseAmount // ignore: cast_nullable_to_non_nullable
as int,maxPlayersPerFranchise: null == maxPlayersPerFranchise ? _self.maxPlayersPerFranchise : maxPlayersPerFranchise // ignore: cast_nullable_to_non_nullable
as int,waitingListMode: null == waitingListMode ? _self.waitingListMode : waitingListMode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
