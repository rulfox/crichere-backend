// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'franchise_squad.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FranchiseSquad {

 String get franchiseId; String get franchiseName; int get purseRemaining; List<FranchisePlayer> get players;
/// Create a copy of FranchiseSquad
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FranchiseSquadCopyWith<FranchiseSquad> get copyWith => _$FranchiseSquadCopyWithImpl<FranchiseSquad>(this as FranchiseSquad, _$identity);

  /// Serializes this FranchiseSquad to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FranchiseSquad&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.franchiseName, franchiseName) || other.franchiseName == franchiseName)&&(identical(other.purseRemaining, purseRemaining) || other.purseRemaining == purseRemaining)&&const DeepCollectionEquality().equals(other.players, players));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,franchiseId,franchiseName,purseRemaining,const DeepCollectionEquality().hash(players));

@override
String toString() {
  return 'FranchiseSquad(franchiseId: $franchiseId, franchiseName: $franchiseName, purseRemaining: $purseRemaining, players: $players)';
}


}

/// @nodoc
abstract mixin class $FranchiseSquadCopyWith<$Res>  {
  factory $FranchiseSquadCopyWith(FranchiseSquad value, $Res Function(FranchiseSquad) _then) = _$FranchiseSquadCopyWithImpl;
@useResult
$Res call({
 String franchiseId, String franchiseName, int purseRemaining, List<FranchisePlayer> players
});




}
/// @nodoc
class _$FranchiseSquadCopyWithImpl<$Res>
    implements $FranchiseSquadCopyWith<$Res> {
  _$FranchiseSquadCopyWithImpl(this._self, this._then);

  final FranchiseSquad _self;
  final $Res Function(FranchiseSquad) _then;

/// Create a copy of FranchiseSquad
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? franchiseId = null,Object? franchiseName = null,Object? purseRemaining = null,Object? players = null,}) {
  return _then(_self.copyWith(
franchiseId: null == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String,franchiseName: null == franchiseName ? _self.franchiseName : franchiseName // ignore: cast_nullable_to_non_nullable
as String,purseRemaining: null == purseRemaining ? _self.purseRemaining : purseRemaining // ignore: cast_nullable_to_non_nullable
as int,players: null == players ? _self.players : players // ignore: cast_nullable_to_non_nullable
as List<FranchisePlayer>,
  ));
}

}


/// Adds pattern-matching-related methods to [FranchiseSquad].
extension FranchiseSquadPatterns on FranchiseSquad {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FranchiseSquad value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FranchiseSquad() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FranchiseSquad value)  $default,){
final _that = this;
switch (_that) {
case _FranchiseSquad():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FranchiseSquad value)?  $default,){
final _that = this;
switch (_that) {
case _FranchiseSquad() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String franchiseId,  String franchiseName,  int purseRemaining,  List<FranchisePlayer> players)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FranchiseSquad() when $default != null:
return $default(_that.franchiseId,_that.franchiseName,_that.purseRemaining,_that.players);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String franchiseId,  String franchiseName,  int purseRemaining,  List<FranchisePlayer> players)  $default,) {final _that = this;
switch (_that) {
case _FranchiseSquad():
return $default(_that.franchiseId,_that.franchiseName,_that.purseRemaining,_that.players);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String franchiseId,  String franchiseName,  int purseRemaining,  List<FranchisePlayer> players)?  $default,) {final _that = this;
switch (_that) {
case _FranchiseSquad() when $default != null:
return $default(_that.franchiseId,_that.franchiseName,_that.purseRemaining,_that.players);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FranchiseSquad implements FranchiseSquad {
  const _FranchiseSquad({required this.franchiseId, required this.franchiseName, required this.purseRemaining, required final  List<FranchisePlayer> players}): _players = players;
  factory _FranchiseSquad.fromJson(Map<String, dynamic> json) => _$FranchiseSquadFromJson(json);

@override final  String franchiseId;
@override final  String franchiseName;
@override final  int purseRemaining;
 final  List<FranchisePlayer> _players;
@override List<FranchisePlayer> get players {
  if (_players is EqualUnmodifiableListView) return _players;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_players);
}


/// Create a copy of FranchiseSquad
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FranchiseSquadCopyWith<_FranchiseSquad> get copyWith => __$FranchiseSquadCopyWithImpl<_FranchiseSquad>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FranchiseSquadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FranchiseSquad&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.franchiseName, franchiseName) || other.franchiseName == franchiseName)&&(identical(other.purseRemaining, purseRemaining) || other.purseRemaining == purseRemaining)&&const DeepCollectionEquality().equals(other._players, _players));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,franchiseId,franchiseName,purseRemaining,const DeepCollectionEquality().hash(_players));

@override
String toString() {
  return 'FranchiseSquad(franchiseId: $franchiseId, franchiseName: $franchiseName, purseRemaining: $purseRemaining, players: $players)';
}


}

/// @nodoc
abstract mixin class _$FranchiseSquadCopyWith<$Res> implements $FranchiseSquadCopyWith<$Res> {
  factory _$FranchiseSquadCopyWith(_FranchiseSquad value, $Res Function(_FranchiseSquad) _then) = __$FranchiseSquadCopyWithImpl;
@override @useResult
$Res call({
 String franchiseId, String franchiseName, int purseRemaining, List<FranchisePlayer> players
});




}
/// @nodoc
class __$FranchiseSquadCopyWithImpl<$Res>
    implements _$FranchiseSquadCopyWith<$Res> {
  __$FranchiseSquadCopyWithImpl(this._self, this._then);

  final _FranchiseSquad _self;
  final $Res Function(_FranchiseSquad) _then;

/// Create a copy of FranchiseSquad
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? franchiseId = null,Object? franchiseName = null,Object? purseRemaining = null,Object? players = null,}) {
  return _then(_FranchiseSquad(
franchiseId: null == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String,franchiseName: null == franchiseName ? _self.franchiseName : franchiseName // ignore: cast_nullable_to_non_nullable
as String,purseRemaining: null == purseRemaining ? _self.purseRemaining : purseRemaining // ignore: cast_nullable_to_non_nullable
as int,players: null == players ? _self._players : players // ignore: cast_nullable_to_non_nullable
as List<FranchisePlayer>,
  ));
}


}

// dart format on
