// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'league.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$League {

 String get id; String get name; String? get format; String? get rulesUrl; bool get mustSellAll; String get playerOrderMode; String get waitingListMode; String? get logoUrl; String? get bannerUrl; String get status; DateTime? get auctionDate; String get createdBy; String? get auctionId;
/// Create a copy of League
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeagueCopyWith<League> get copyWith => _$LeagueCopyWithImpl<League>(this as League, _$identity);

  /// Serializes this League to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is League&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.format, format) || other.format == format)&&(identical(other.rulesUrl, rulesUrl) || other.rulesUrl == rulesUrl)&&(identical(other.mustSellAll, mustSellAll) || other.mustSellAll == mustSellAll)&&(identical(other.playerOrderMode, playerOrderMode) || other.playerOrderMode == playerOrderMode)&&(identical(other.waitingListMode, waitingListMode) || other.waitingListMode == waitingListMode)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.bannerUrl, bannerUrl) || other.bannerUrl == bannerUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.auctionDate, auctionDate) || other.auctionDate == auctionDate)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.auctionId, auctionId) || other.auctionId == auctionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,format,rulesUrl,mustSellAll,playerOrderMode,waitingListMode,logoUrl,bannerUrl,status,auctionDate,createdBy,auctionId);

@override
String toString() {
  return 'League(id: $id, name: $name, format: $format, rulesUrl: $rulesUrl, mustSellAll: $mustSellAll, playerOrderMode: $playerOrderMode, waitingListMode: $waitingListMode, logoUrl: $logoUrl, bannerUrl: $bannerUrl, status: $status, auctionDate: $auctionDate, createdBy: $createdBy, auctionId: $auctionId)';
}


}

/// @nodoc
abstract mixin class $LeagueCopyWith<$Res>  {
  factory $LeagueCopyWith(League value, $Res Function(League) _then) = _$LeagueCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? format, String? rulesUrl, bool mustSellAll, String playerOrderMode, String waitingListMode, String? logoUrl, String? bannerUrl, String status, DateTime? auctionDate, String createdBy, String? auctionId
});




}
/// @nodoc
class _$LeagueCopyWithImpl<$Res>
    implements $LeagueCopyWith<$Res> {
  _$LeagueCopyWithImpl(this._self, this._then);

  final League _self;
  final $Res Function(League) _then;

/// Create a copy of League
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? format = freezed,Object? rulesUrl = freezed,Object? mustSellAll = null,Object? playerOrderMode = null,Object? waitingListMode = null,Object? logoUrl = freezed,Object? bannerUrl = freezed,Object? status = null,Object? auctionDate = freezed,Object? createdBy = null,Object? auctionId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,format: freezed == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String?,rulesUrl: freezed == rulesUrl ? _self.rulesUrl : rulesUrl // ignore: cast_nullable_to_non_nullable
as String?,mustSellAll: null == mustSellAll ? _self.mustSellAll : mustSellAll // ignore: cast_nullable_to_non_nullable
as bool,playerOrderMode: null == playerOrderMode ? _self.playerOrderMode : playerOrderMode // ignore: cast_nullable_to_non_nullable
as String,waitingListMode: null == waitingListMode ? _self.waitingListMode : waitingListMode // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,bannerUrl: freezed == bannerUrl ? _self.bannerUrl : bannerUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,auctionDate: freezed == auctionDate ? _self.auctionDate : auctionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,auctionId: freezed == auctionId ? _self.auctionId : auctionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [League].
extension LeaguePatterns on League {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _League value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _League() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _League value)  $default,){
final _that = this;
switch (_that) {
case _League():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _League value)?  $default,){
final _that = this;
switch (_that) {
case _League() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? format,  String? rulesUrl,  bool mustSellAll,  String playerOrderMode,  String waitingListMode,  String? logoUrl,  String? bannerUrl,  String status,  DateTime? auctionDate,  String createdBy,  String? auctionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _League() when $default != null:
return $default(_that.id,_that.name,_that.format,_that.rulesUrl,_that.mustSellAll,_that.playerOrderMode,_that.waitingListMode,_that.logoUrl,_that.bannerUrl,_that.status,_that.auctionDate,_that.createdBy,_that.auctionId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? format,  String? rulesUrl,  bool mustSellAll,  String playerOrderMode,  String waitingListMode,  String? logoUrl,  String? bannerUrl,  String status,  DateTime? auctionDate,  String createdBy,  String? auctionId)  $default,) {final _that = this;
switch (_that) {
case _League():
return $default(_that.id,_that.name,_that.format,_that.rulesUrl,_that.mustSellAll,_that.playerOrderMode,_that.waitingListMode,_that.logoUrl,_that.bannerUrl,_that.status,_that.auctionDate,_that.createdBy,_that.auctionId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? format,  String? rulesUrl,  bool mustSellAll,  String playerOrderMode,  String waitingListMode,  String? logoUrl,  String? bannerUrl,  String status,  DateTime? auctionDate,  String createdBy,  String? auctionId)?  $default,) {final _that = this;
switch (_that) {
case _League() when $default != null:
return $default(_that.id,_that.name,_that.format,_that.rulesUrl,_that.mustSellAll,_that.playerOrderMode,_that.waitingListMode,_that.logoUrl,_that.bannerUrl,_that.status,_that.auctionDate,_that.createdBy,_that.auctionId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _League extends League {
  const _League({required this.id, required this.name, this.format, this.rulesUrl, this.mustSellAll = false, this.playerOrderMode = 'RANDOM', this.waitingListMode = 'ADMIN_PICKS', this.logoUrl, this.bannerUrl, required this.status, this.auctionDate, required this.createdBy, this.auctionId}): super._();
  factory _League.fromJson(Map<String, dynamic> json) => _$LeagueFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? format;
@override final  String? rulesUrl;
@override@JsonKey() final  bool mustSellAll;
@override@JsonKey() final  String playerOrderMode;
@override@JsonKey() final  String waitingListMode;
@override final  String? logoUrl;
@override final  String? bannerUrl;
@override final  String status;
@override final  DateTime? auctionDate;
@override final  String createdBy;
@override final  String? auctionId;

/// Create a copy of League
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeagueCopyWith<_League> get copyWith => __$LeagueCopyWithImpl<_League>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeagueToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _League&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.format, format) || other.format == format)&&(identical(other.rulesUrl, rulesUrl) || other.rulesUrl == rulesUrl)&&(identical(other.mustSellAll, mustSellAll) || other.mustSellAll == mustSellAll)&&(identical(other.playerOrderMode, playerOrderMode) || other.playerOrderMode == playerOrderMode)&&(identical(other.waitingListMode, waitingListMode) || other.waitingListMode == waitingListMode)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.bannerUrl, bannerUrl) || other.bannerUrl == bannerUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.auctionDate, auctionDate) || other.auctionDate == auctionDate)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.auctionId, auctionId) || other.auctionId == auctionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,format,rulesUrl,mustSellAll,playerOrderMode,waitingListMode,logoUrl,bannerUrl,status,auctionDate,createdBy,auctionId);

@override
String toString() {
  return 'League(id: $id, name: $name, format: $format, rulesUrl: $rulesUrl, mustSellAll: $mustSellAll, playerOrderMode: $playerOrderMode, waitingListMode: $waitingListMode, logoUrl: $logoUrl, bannerUrl: $bannerUrl, status: $status, auctionDate: $auctionDate, createdBy: $createdBy, auctionId: $auctionId)';
}


}

/// @nodoc
abstract mixin class _$LeagueCopyWith<$Res> implements $LeagueCopyWith<$Res> {
  factory _$LeagueCopyWith(_League value, $Res Function(_League) _then) = __$LeagueCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? format, String? rulesUrl, bool mustSellAll, String playerOrderMode, String waitingListMode, String? logoUrl, String? bannerUrl, String status, DateTime? auctionDate, String createdBy, String? auctionId
});




}
/// @nodoc
class __$LeagueCopyWithImpl<$Res>
    implements _$LeagueCopyWith<$Res> {
  __$LeagueCopyWithImpl(this._self, this._then);

  final _League _self;
  final $Res Function(_League) _then;

/// Create a copy of League
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? format = freezed,Object? rulesUrl = freezed,Object? mustSellAll = null,Object? playerOrderMode = null,Object? waitingListMode = null,Object? logoUrl = freezed,Object? bannerUrl = freezed,Object? status = null,Object? auctionDate = freezed,Object? createdBy = null,Object? auctionId = freezed,}) {
  return _then(_League(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,format: freezed == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String?,rulesUrl: freezed == rulesUrl ? _self.rulesUrl : rulesUrl // ignore: cast_nullable_to_non_nullable
as String?,mustSellAll: null == mustSellAll ? _self.mustSellAll : mustSellAll // ignore: cast_nullable_to_non_nullable
as bool,playerOrderMode: null == playerOrderMode ? _self.playerOrderMode : playerOrderMode // ignore: cast_nullable_to_non_nullable
as String,waitingListMode: null == waitingListMode ? _self.waitingListMode : waitingListMode // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,bannerUrl: freezed == bannerUrl ? _self.bannerUrl : bannerUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,auctionDate: freezed == auctionDate ? _self.auctionDate : auctionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,auctionId: freezed == auctionId ? _self.auctionId : auctionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
