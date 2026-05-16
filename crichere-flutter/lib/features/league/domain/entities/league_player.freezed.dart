// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'league_player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeaguePlayer {

 String get id; String get leagueId;@JsonKey(name: 'userId') String get playerId; String? get playerName; String? get playerPhotoUrl; String get status; int? get basePriceOverride;@JsonKey(name: 'basePrice') int? get basePrice; int? get finalPrice; String? get franchiseId; String? get franchiseName; String? get category; String? get tag; bool get auctionEligible;
/// Create a copy of LeaguePlayer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaguePlayerCopyWith<LeaguePlayer> get copyWith => _$LeaguePlayerCopyWithImpl<LeaguePlayer>(this as LeaguePlayer, _$identity);

  /// Serializes this LeaguePlayer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaguePlayer&&(identical(other.id, id) || other.id == id)&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.playerName, playerName) || other.playerName == playerName)&&(identical(other.playerPhotoUrl, playerPhotoUrl) || other.playerPhotoUrl == playerPhotoUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.basePriceOverride, basePriceOverride) || other.basePriceOverride == basePriceOverride)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.finalPrice, finalPrice) || other.finalPrice == finalPrice)&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.franchiseName, franchiseName) || other.franchiseName == franchiseName)&&(identical(other.category, category) || other.category == category)&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.auctionEligible, auctionEligible) || other.auctionEligible == auctionEligible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,leagueId,playerId,playerName,playerPhotoUrl,status,basePriceOverride,basePrice,finalPrice,franchiseId,franchiseName,category,tag,auctionEligible);

@override
String toString() {
  return 'LeaguePlayer(id: $id, leagueId: $leagueId, playerId: $playerId, playerName: $playerName, playerPhotoUrl: $playerPhotoUrl, status: $status, basePriceOverride: $basePriceOverride, basePrice: $basePrice, finalPrice: $finalPrice, franchiseId: $franchiseId, franchiseName: $franchiseName, category: $category, tag: $tag, auctionEligible: $auctionEligible)';
}


}

/// @nodoc
abstract mixin class $LeaguePlayerCopyWith<$Res>  {
  factory $LeaguePlayerCopyWith(LeaguePlayer value, $Res Function(LeaguePlayer) _then) = _$LeaguePlayerCopyWithImpl;
@useResult
$Res call({
 String id, String leagueId,@JsonKey(name: 'userId') String playerId, String? playerName, String? playerPhotoUrl, String status, int? basePriceOverride,@JsonKey(name: 'basePrice') int? basePrice, int? finalPrice, String? franchiseId, String? franchiseName, String? category, String? tag, bool auctionEligible
});




}
/// @nodoc
class _$LeaguePlayerCopyWithImpl<$Res>
    implements $LeaguePlayerCopyWith<$Res> {
  _$LeaguePlayerCopyWithImpl(this._self, this._then);

  final LeaguePlayer _self;
  final $Res Function(LeaguePlayer) _then;

/// Create a copy of LeaguePlayer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? leagueId = null,Object? playerId = null,Object? playerName = freezed,Object? playerPhotoUrl = freezed,Object? status = null,Object? basePriceOverride = freezed,Object? basePrice = freezed,Object? finalPrice = freezed,Object? franchiseId = freezed,Object? franchiseName = freezed,Object? category = freezed,Object? tag = freezed,Object? auctionEligible = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,playerName: freezed == playerName ? _self.playerName : playerName // ignore: cast_nullable_to_non_nullable
as String?,playerPhotoUrl: freezed == playerPhotoUrl ? _self.playerPhotoUrl : playerPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,basePriceOverride: freezed == basePriceOverride ? _self.basePriceOverride : basePriceOverride // ignore: cast_nullable_to_non_nullable
as int?,basePrice: freezed == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as int?,finalPrice: freezed == finalPrice ? _self.finalPrice : finalPrice // ignore: cast_nullable_to_non_nullable
as int?,franchiseId: freezed == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String?,franchiseName: freezed == franchiseName ? _self.franchiseName : franchiseName // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,tag: freezed == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String?,auctionEligible: null == auctionEligible ? _self.auctionEligible : auctionEligible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaguePlayer].
extension LeaguePlayerPatterns on LeaguePlayer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaguePlayer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaguePlayer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaguePlayer value)  $default,){
final _that = this;
switch (_that) {
case _LeaguePlayer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaguePlayer value)?  $default,){
final _that = this;
switch (_that) {
case _LeaguePlayer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String leagueId, @JsonKey(name: 'userId')  String playerId,  String? playerName,  String? playerPhotoUrl,  String status,  int? basePriceOverride, @JsonKey(name: 'basePrice')  int? basePrice,  int? finalPrice,  String? franchiseId,  String? franchiseName,  String? category,  String? tag,  bool auctionEligible)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaguePlayer() when $default != null:
return $default(_that.id,_that.leagueId,_that.playerId,_that.playerName,_that.playerPhotoUrl,_that.status,_that.basePriceOverride,_that.basePrice,_that.finalPrice,_that.franchiseId,_that.franchiseName,_that.category,_that.tag,_that.auctionEligible);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String leagueId, @JsonKey(name: 'userId')  String playerId,  String? playerName,  String? playerPhotoUrl,  String status,  int? basePriceOverride, @JsonKey(name: 'basePrice')  int? basePrice,  int? finalPrice,  String? franchiseId,  String? franchiseName,  String? category,  String? tag,  bool auctionEligible)  $default,) {final _that = this;
switch (_that) {
case _LeaguePlayer():
return $default(_that.id,_that.leagueId,_that.playerId,_that.playerName,_that.playerPhotoUrl,_that.status,_that.basePriceOverride,_that.basePrice,_that.finalPrice,_that.franchiseId,_that.franchiseName,_that.category,_that.tag,_that.auctionEligible);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String leagueId, @JsonKey(name: 'userId')  String playerId,  String? playerName,  String? playerPhotoUrl,  String status,  int? basePriceOverride, @JsonKey(name: 'basePrice')  int? basePrice,  int? finalPrice,  String? franchiseId,  String? franchiseName,  String? category,  String? tag,  bool auctionEligible)?  $default,) {final _that = this;
switch (_that) {
case _LeaguePlayer() when $default != null:
return $default(_that.id,_that.leagueId,_that.playerId,_that.playerName,_that.playerPhotoUrl,_that.status,_that.basePriceOverride,_that.basePrice,_that.finalPrice,_that.franchiseId,_that.franchiseName,_that.category,_that.tag,_that.auctionEligible);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaguePlayer extends LeaguePlayer {
  const _LeaguePlayer({required this.id, required this.leagueId, @JsonKey(name: 'userId') required this.playerId, this.playerName, this.playerPhotoUrl, required this.status, this.basePriceOverride, @JsonKey(name: 'basePrice') this.basePrice, this.finalPrice, this.franchiseId, this.franchiseName, this.category, this.tag, this.auctionEligible = false}): super._();
  factory _LeaguePlayer.fromJson(Map<String, dynamic> json) => _$LeaguePlayerFromJson(json);

@override final  String id;
@override final  String leagueId;
@override@JsonKey(name: 'userId') final  String playerId;
@override final  String? playerName;
@override final  String? playerPhotoUrl;
@override final  String status;
@override final  int? basePriceOverride;
@override@JsonKey(name: 'basePrice') final  int? basePrice;
@override final  int? finalPrice;
@override final  String? franchiseId;
@override final  String? franchiseName;
@override final  String? category;
@override final  String? tag;
@override@JsonKey() final  bool auctionEligible;

/// Create a copy of LeaguePlayer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaguePlayerCopyWith<_LeaguePlayer> get copyWith => __$LeaguePlayerCopyWithImpl<_LeaguePlayer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaguePlayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaguePlayer&&(identical(other.id, id) || other.id == id)&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.playerName, playerName) || other.playerName == playerName)&&(identical(other.playerPhotoUrl, playerPhotoUrl) || other.playerPhotoUrl == playerPhotoUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.basePriceOverride, basePriceOverride) || other.basePriceOverride == basePriceOverride)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.finalPrice, finalPrice) || other.finalPrice == finalPrice)&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.franchiseName, franchiseName) || other.franchiseName == franchiseName)&&(identical(other.category, category) || other.category == category)&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.auctionEligible, auctionEligible) || other.auctionEligible == auctionEligible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,leagueId,playerId,playerName,playerPhotoUrl,status,basePriceOverride,basePrice,finalPrice,franchiseId,franchiseName,category,tag,auctionEligible);

@override
String toString() {
  return 'LeaguePlayer(id: $id, leagueId: $leagueId, playerId: $playerId, playerName: $playerName, playerPhotoUrl: $playerPhotoUrl, status: $status, basePriceOverride: $basePriceOverride, basePrice: $basePrice, finalPrice: $finalPrice, franchiseId: $franchiseId, franchiseName: $franchiseName, category: $category, tag: $tag, auctionEligible: $auctionEligible)';
}


}

/// @nodoc
abstract mixin class _$LeaguePlayerCopyWith<$Res> implements $LeaguePlayerCopyWith<$Res> {
  factory _$LeaguePlayerCopyWith(_LeaguePlayer value, $Res Function(_LeaguePlayer) _then) = __$LeaguePlayerCopyWithImpl;
@override @useResult
$Res call({
 String id, String leagueId,@JsonKey(name: 'userId') String playerId, String? playerName, String? playerPhotoUrl, String status, int? basePriceOverride,@JsonKey(name: 'basePrice') int? basePrice, int? finalPrice, String? franchiseId, String? franchiseName, String? category, String? tag, bool auctionEligible
});




}
/// @nodoc
class __$LeaguePlayerCopyWithImpl<$Res>
    implements _$LeaguePlayerCopyWith<$Res> {
  __$LeaguePlayerCopyWithImpl(this._self, this._then);

  final _LeaguePlayer _self;
  final $Res Function(_LeaguePlayer) _then;

/// Create a copy of LeaguePlayer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? leagueId = null,Object? playerId = null,Object? playerName = freezed,Object? playerPhotoUrl = freezed,Object? status = null,Object? basePriceOverride = freezed,Object? basePrice = freezed,Object? finalPrice = freezed,Object? franchiseId = freezed,Object? franchiseName = freezed,Object? category = freezed,Object? tag = freezed,Object? auctionEligible = null,}) {
  return _then(_LeaguePlayer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,playerName: freezed == playerName ? _self.playerName : playerName // ignore: cast_nullable_to_non_nullable
as String?,playerPhotoUrl: freezed == playerPhotoUrl ? _self.playerPhotoUrl : playerPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,basePriceOverride: freezed == basePriceOverride ? _self.basePriceOverride : basePriceOverride // ignore: cast_nullable_to_non_nullable
as int?,basePrice: freezed == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as int?,finalPrice: freezed == finalPrice ? _self.finalPrice : finalPrice // ignore: cast_nullable_to_non_nullable
as int?,franchiseId: freezed == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String?,franchiseName: freezed == franchiseName ? _self.franchiseName : franchiseName // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,tag: freezed == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String?,auctionEligible: null == auctionEligible ? _self.auctionEligible : auctionEligible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
