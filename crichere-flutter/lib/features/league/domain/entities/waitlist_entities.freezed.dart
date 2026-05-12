// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'waitlist_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WaitlistEntry {

 String get id; String get leagueId; String get playerId; String get playerName; int get position; DateTime get createdAt;
/// Create a copy of WaitlistEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WaitlistEntryCopyWith<WaitlistEntry> get copyWith => _$WaitlistEntryCopyWithImpl<WaitlistEntry>(this as WaitlistEntry, _$identity);

  /// Serializes this WaitlistEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WaitlistEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.playerName, playerName) || other.playerName == playerName)&&(identical(other.position, position) || other.position == position)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,leagueId,playerId,playerName,position,createdAt);

@override
String toString() {
  return 'WaitlistEntry(id: $id, leagueId: $leagueId, playerId: $playerId, playerName: $playerName, position: $position, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $WaitlistEntryCopyWith<$Res>  {
  factory $WaitlistEntryCopyWith(WaitlistEntry value, $Res Function(WaitlistEntry) _then) = _$WaitlistEntryCopyWithImpl;
@useResult
$Res call({
 String id, String leagueId, String playerId, String playerName, int position, DateTime createdAt
});




}
/// @nodoc
class _$WaitlistEntryCopyWithImpl<$Res>
    implements $WaitlistEntryCopyWith<$Res> {
  _$WaitlistEntryCopyWithImpl(this._self, this._then);

  final WaitlistEntry _self;
  final $Res Function(WaitlistEntry) _then;

/// Create a copy of WaitlistEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? leagueId = null,Object? playerId = null,Object? playerName = null,Object? position = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,playerName: null == playerName ? _self.playerName : playerName // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [WaitlistEntry].
extension WaitlistEntryPatterns on WaitlistEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WaitlistEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WaitlistEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WaitlistEntry value)  $default,){
final _that = this;
switch (_that) {
case _WaitlistEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WaitlistEntry value)?  $default,){
final _that = this;
switch (_that) {
case _WaitlistEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String leagueId,  String playerId,  String playerName,  int position,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WaitlistEntry() when $default != null:
return $default(_that.id,_that.leagueId,_that.playerId,_that.playerName,_that.position,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String leagueId,  String playerId,  String playerName,  int position,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _WaitlistEntry():
return $default(_that.id,_that.leagueId,_that.playerId,_that.playerName,_that.position,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String leagueId,  String playerId,  String playerName,  int position,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _WaitlistEntry() when $default != null:
return $default(_that.id,_that.leagueId,_that.playerId,_that.playerName,_that.position,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WaitlistEntry implements WaitlistEntry {
  const _WaitlistEntry({required this.id, required this.leagueId, required this.playerId, required this.playerName, required this.position, required this.createdAt});
  factory _WaitlistEntry.fromJson(Map<String, dynamic> json) => _$WaitlistEntryFromJson(json);

@override final  String id;
@override final  String leagueId;
@override final  String playerId;
@override final  String playerName;
@override final  int position;
@override final  DateTime createdAt;

/// Create a copy of WaitlistEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WaitlistEntryCopyWith<_WaitlistEntry> get copyWith => __$WaitlistEntryCopyWithImpl<_WaitlistEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WaitlistEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WaitlistEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.playerName, playerName) || other.playerName == playerName)&&(identical(other.position, position) || other.position == position)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,leagueId,playerId,playerName,position,createdAt);

@override
String toString() {
  return 'WaitlistEntry(id: $id, leagueId: $leagueId, playerId: $playerId, playerName: $playerName, position: $position, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$WaitlistEntryCopyWith<$Res> implements $WaitlistEntryCopyWith<$Res> {
  factory _$WaitlistEntryCopyWith(_WaitlistEntry value, $Res Function(_WaitlistEntry) _then) = __$WaitlistEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String leagueId, String playerId, String playerName, int position, DateTime createdAt
});




}
/// @nodoc
class __$WaitlistEntryCopyWithImpl<$Res>
    implements _$WaitlistEntryCopyWith<$Res> {
  __$WaitlistEntryCopyWithImpl(this._self, this._then);

  final _WaitlistEntry _self;
  final $Res Function(_WaitlistEntry) _then;

/// Create a copy of WaitlistEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? leagueId = null,Object? playerId = null,Object? playerName = null,Object? position = null,Object? createdAt = null,}) {
  return _then(_WaitlistEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,playerName: null == playerName ? _self.playerName : playerName // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
