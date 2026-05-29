// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auction_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuctionResponse {

 String get id; String get leagueId; String? get auctioneerId;@JsonKey(unknownEnumValue: AuctionStatus.unknown) AuctionStatus get status; String? get currentRoundId; String? get currentLeaguePlayerId; DateTime? get startedAt; DateTime? get completedAt; String? get displayUrl; String? get publicViewUrl; String? get publicViewToken;
/// Create a copy of AuctionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuctionResponseCopyWith<AuctionResponse> get copyWith => _$AuctionResponseCopyWithImpl<AuctionResponse>(this as AuctionResponse, _$identity);

  /// Serializes this AuctionResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuctionResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.auctioneerId, auctioneerId) || other.auctioneerId == auctioneerId)&&(identical(other.status, status) || other.status == status)&&(identical(other.currentRoundId, currentRoundId) || other.currentRoundId == currentRoundId)&&(identical(other.currentLeaguePlayerId, currentLeaguePlayerId) || other.currentLeaguePlayerId == currentLeaguePlayerId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.displayUrl, displayUrl) || other.displayUrl == displayUrl)&&(identical(other.publicViewUrl, publicViewUrl) || other.publicViewUrl == publicViewUrl)&&(identical(other.publicViewToken, publicViewToken) || other.publicViewToken == publicViewToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,leagueId,auctioneerId,status,currentRoundId,currentLeaguePlayerId,startedAt,completedAt,displayUrl,publicViewUrl,publicViewToken);

@override
String toString() {
  return 'AuctionResponse(id: $id, leagueId: $leagueId, auctioneerId: $auctioneerId, status: $status, currentRoundId: $currentRoundId, currentLeaguePlayerId: $currentLeaguePlayerId, startedAt: $startedAt, completedAt: $completedAt, displayUrl: $displayUrl, publicViewUrl: $publicViewUrl, publicViewToken: $publicViewToken)';
}


}

/// @nodoc
abstract mixin class $AuctionResponseCopyWith<$Res>  {
  factory $AuctionResponseCopyWith(AuctionResponse value, $Res Function(AuctionResponse) _then) = _$AuctionResponseCopyWithImpl;
@useResult
$Res call({
 String id, String leagueId, String? auctioneerId,@JsonKey(unknownEnumValue: AuctionStatus.unknown) AuctionStatus status, String? currentRoundId, String? currentLeaguePlayerId, DateTime? startedAt, DateTime? completedAt, String? displayUrl, String? publicViewUrl, String? publicViewToken
});




}
/// @nodoc
class _$AuctionResponseCopyWithImpl<$Res>
    implements $AuctionResponseCopyWith<$Res> {
  _$AuctionResponseCopyWithImpl(this._self, this._then);

  final AuctionResponse _self;
  final $Res Function(AuctionResponse) _then;

/// Create a copy of AuctionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? leagueId = null,Object? auctioneerId = freezed,Object? status = null,Object? currentRoundId = freezed,Object? currentLeaguePlayerId = freezed,Object? startedAt = freezed,Object? completedAt = freezed,Object? displayUrl = freezed,Object? publicViewUrl = freezed,Object? publicViewToken = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,auctioneerId: freezed == auctioneerId ? _self.auctioneerId : auctioneerId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuctionStatus,currentRoundId: freezed == currentRoundId ? _self.currentRoundId : currentRoundId // ignore: cast_nullable_to_non_nullable
as String?,currentLeaguePlayerId: freezed == currentLeaguePlayerId ? _self.currentLeaguePlayerId : currentLeaguePlayerId // ignore: cast_nullable_to_non_nullable
as String?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,displayUrl: freezed == displayUrl ? _self.displayUrl : displayUrl // ignore: cast_nullable_to_non_nullable
as String?,publicViewUrl: freezed == publicViewUrl ? _self.publicViewUrl : publicViewUrl // ignore: cast_nullable_to_non_nullable
as String?,publicViewToken: freezed == publicViewToken ? _self.publicViewToken : publicViewToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AuctionResponse].
extension AuctionResponsePatterns on AuctionResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuctionResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuctionResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuctionResponse value)  $default,){
final _that = this;
switch (_that) {
case _AuctionResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuctionResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AuctionResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String leagueId,  String? auctioneerId, @JsonKey(unknownEnumValue: AuctionStatus.unknown)  AuctionStatus status,  String? currentRoundId,  String? currentLeaguePlayerId,  DateTime? startedAt,  DateTime? completedAt,  String? displayUrl,  String? publicViewUrl,  String? publicViewToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuctionResponse() when $default != null:
return $default(_that.id,_that.leagueId,_that.auctioneerId,_that.status,_that.currentRoundId,_that.currentLeaguePlayerId,_that.startedAt,_that.completedAt,_that.displayUrl,_that.publicViewUrl,_that.publicViewToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String leagueId,  String? auctioneerId, @JsonKey(unknownEnumValue: AuctionStatus.unknown)  AuctionStatus status,  String? currentRoundId,  String? currentLeaguePlayerId,  DateTime? startedAt,  DateTime? completedAt,  String? displayUrl,  String? publicViewUrl,  String? publicViewToken)  $default,) {final _that = this;
switch (_that) {
case _AuctionResponse():
return $default(_that.id,_that.leagueId,_that.auctioneerId,_that.status,_that.currentRoundId,_that.currentLeaguePlayerId,_that.startedAt,_that.completedAt,_that.displayUrl,_that.publicViewUrl,_that.publicViewToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String leagueId,  String? auctioneerId, @JsonKey(unknownEnumValue: AuctionStatus.unknown)  AuctionStatus status,  String? currentRoundId,  String? currentLeaguePlayerId,  DateTime? startedAt,  DateTime? completedAt,  String? displayUrl,  String? publicViewUrl,  String? publicViewToken)?  $default,) {final _that = this;
switch (_that) {
case _AuctionResponse() when $default != null:
return $default(_that.id,_that.leagueId,_that.auctioneerId,_that.status,_that.currentRoundId,_that.currentLeaguePlayerId,_that.startedAt,_that.completedAt,_that.displayUrl,_that.publicViewUrl,_that.publicViewToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuctionResponse implements AuctionResponse {
  const _AuctionResponse({required this.id, required this.leagueId, this.auctioneerId, @JsonKey(unknownEnumValue: AuctionStatus.unknown) required this.status, this.currentRoundId, this.currentLeaguePlayerId, this.startedAt, this.completedAt, this.displayUrl, this.publicViewUrl, this.publicViewToken});
  factory _AuctionResponse.fromJson(Map<String, dynamic> json) => _$AuctionResponseFromJson(json);

@override final  String id;
@override final  String leagueId;
@override final  String? auctioneerId;
@override@JsonKey(unknownEnumValue: AuctionStatus.unknown) final  AuctionStatus status;
@override final  String? currentRoundId;
@override final  String? currentLeaguePlayerId;
@override final  DateTime? startedAt;
@override final  DateTime? completedAt;
@override final  String? displayUrl;
@override final  String? publicViewUrl;
@override final  String? publicViewToken;

/// Create a copy of AuctionResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuctionResponseCopyWith<_AuctionResponse> get copyWith => __$AuctionResponseCopyWithImpl<_AuctionResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuctionResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuctionResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.auctioneerId, auctioneerId) || other.auctioneerId == auctioneerId)&&(identical(other.status, status) || other.status == status)&&(identical(other.currentRoundId, currentRoundId) || other.currentRoundId == currentRoundId)&&(identical(other.currentLeaguePlayerId, currentLeaguePlayerId) || other.currentLeaguePlayerId == currentLeaguePlayerId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.displayUrl, displayUrl) || other.displayUrl == displayUrl)&&(identical(other.publicViewUrl, publicViewUrl) || other.publicViewUrl == publicViewUrl)&&(identical(other.publicViewToken, publicViewToken) || other.publicViewToken == publicViewToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,leagueId,auctioneerId,status,currentRoundId,currentLeaguePlayerId,startedAt,completedAt,displayUrl,publicViewUrl,publicViewToken);

@override
String toString() {
  return 'AuctionResponse(id: $id, leagueId: $leagueId, auctioneerId: $auctioneerId, status: $status, currentRoundId: $currentRoundId, currentLeaguePlayerId: $currentLeaguePlayerId, startedAt: $startedAt, completedAt: $completedAt, displayUrl: $displayUrl, publicViewUrl: $publicViewUrl, publicViewToken: $publicViewToken)';
}


}

/// @nodoc
abstract mixin class _$AuctionResponseCopyWith<$Res> implements $AuctionResponseCopyWith<$Res> {
  factory _$AuctionResponseCopyWith(_AuctionResponse value, $Res Function(_AuctionResponse) _then) = __$AuctionResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String leagueId, String? auctioneerId,@JsonKey(unknownEnumValue: AuctionStatus.unknown) AuctionStatus status, String? currentRoundId, String? currentLeaguePlayerId, DateTime? startedAt, DateTime? completedAt, String? displayUrl, String? publicViewUrl, String? publicViewToken
});




}
/// @nodoc
class __$AuctionResponseCopyWithImpl<$Res>
    implements _$AuctionResponseCopyWith<$Res> {
  __$AuctionResponseCopyWithImpl(this._self, this._then);

  final _AuctionResponse _self;
  final $Res Function(_AuctionResponse) _then;

/// Create a copy of AuctionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? leagueId = null,Object? auctioneerId = freezed,Object? status = null,Object? currentRoundId = freezed,Object? currentLeaguePlayerId = freezed,Object? startedAt = freezed,Object? completedAt = freezed,Object? displayUrl = freezed,Object? publicViewUrl = freezed,Object? publicViewToken = freezed,}) {
  return _then(_AuctionResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,auctioneerId: freezed == auctioneerId ? _self.auctioneerId : auctioneerId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuctionStatus,currentRoundId: freezed == currentRoundId ? _self.currentRoundId : currentRoundId // ignore: cast_nullable_to_non_nullable
as String?,currentLeaguePlayerId: freezed == currentLeaguePlayerId ? _self.currentLeaguePlayerId : currentLeaguePlayerId // ignore: cast_nullable_to_non_nullable
as String?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,displayUrl: freezed == displayUrl ? _self.displayUrl : displayUrl // ignore: cast_nullable_to_non_nullable
as String?,publicViewUrl: freezed == publicViewUrl ? _self.publicViewUrl : publicViewUrl // ignore: cast_nullable_to_non_nullable
as String?,publicViewToken: freezed == publicViewToken ? _self.publicViewToken : publicViewToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$BidResponse {

 String get id; String get auctionId; String get roundId; String get leaguePlayerId; String get franchiseId; int get bidAmount;@JsonKey(unknownEnumValue: BidStatus.unknown) BidStatus get status; String? get recordedBy; DateTime? get bidAt;
/// Create a copy of BidResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BidResponseCopyWith<BidResponse> get copyWith => _$BidResponseCopyWithImpl<BidResponse>(this as BidResponse, _$identity);

  /// Serializes this BidResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BidResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.auctionId, auctionId) || other.auctionId == auctionId)&&(identical(other.roundId, roundId) || other.roundId == roundId)&&(identical(other.leaguePlayerId, leaguePlayerId) || other.leaguePlayerId == leaguePlayerId)&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.bidAmount, bidAmount) || other.bidAmount == bidAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.recordedBy, recordedBy) || other.recordedBy == recordedBy)&&(identical(other.bidAt, bidAt) || other.bidAt == bidAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,auctionId,roundId,leaguePlayerId,franchiseId,bidAmount,status,recordedBy,bidAt);

@override
String toString() {
  return 'BidResponse(id: $id, auctionId: $auctionId, roundId: $roundId, leaguePlayerId: $leaguePlayerId, franchiseId: $franchiseId, bidAmount: $bidAmount, status: $status, recordedBy: $recordedBy, bidAt: $bidAt)';
}


}

/// @nodoc
abstract mixin class $BidResponseCopyWith<$Res>  {
  factory $BidResponseCopyWith(BidResponse value, $Res Function(BidResponse) _then) = _$BidResponseCopyWithImpl;
@useResult
$Res call({
 String id, String auctionId, String roundId, String leaguePlayerId, String franchiseId, int bidAmount,@JsonKey(unknownEnumValue: BidStatus.unknown) BidStatus status, String? recordedBy, DateTime? bidAt
});




}
/// @nodoc
class _$BidResponseCopyWithImpl<$Res>
    implements $BidResponseCopyWith<$Res> {
  _$BidResponseCopyWithImpl(this._self, this._then);

  final BidResponse _self;
  final $Res Function(BidResponse) _then;

/// Create a copy of BidResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? auctionId = null,Object? roundId = null,Object? leaguePlayerId = null,Object? franchiseId = null,Object? bidAmount = null,Object? status = null,Object? recordedBy = freezed,Object? bidAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,auctionId: null == auctionId ? _self.auctionId : auctionId // ignore: cast_nullable_to_non_nullable
as String,roundId: null == roundId ? _self.roundId : roundId // ignore: cast_nullable_to_non_nullable
as String,leaguePlayerId: null == leaguePlayerId ? _self.leaguePlayerId : leaguePlayerId // ignore: cast_nullable_to_non_nullable
as String,franchiseId: null == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String,bidAmount: null == bidAmount ? _self.bidAmount : bidAmount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BidStatus,recordedBy: freezed == recordedBy ? _self.recordedBy : recordedBy // ignore: cast_nullable_to_non_nullable
as String?,bidAt: freezed == bidAt ? _self.bidAt : bidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [BidResponse].
extension BidResponsePatterns on BidResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BidResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BidResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BidResponse value)  $default,){
final _that = this;
switch (_that) {
case _BidResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BidResponse value)?  $default,){
final _that = this;
switch (_that) {
case _BidResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String auctionId,  String roundId,  String leaguePlayerId,  String franchiseId,  int bidAmount, @JsonKey(unknownEnumValue: BidStatus.unknown)  BidStatus status,  String? recordedBy,  DateTime? bidAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BidResponse() when $default != null:
return $default(_that.id,_that.auctionId,_that.roundId,_that.leaguePlayerId,_that.franchiseId,_that.bidAmount,_that.status,_that.recordedBy,_that.bidAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String auctionId,  String roundId,  String leaguePlayerId,  String franchiseId,  int bidAmount, @JsonKey(unknownEnumValue: BidStatus.unknown)  BidStatus status,  String? recordedBy,  DateTime? bidAt)  $default,) {final _that = this;
switch (_that) {
case _BidResponse():
return $default(_that.id,_that.auctionId,_that.roundId,_that.leaguePlayerId,_that.franchiseId,_that.bidAmount,_that.status,_that.recordedBy,_that.bidAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String auctionId,  String roundId,  String leaguePlayerId,  String franchiseId,  int bidAmount, @JsonKey(unknownEnumValue: BidStatus.unknown)  BidStatus status,  String? recordedBy,  DateTime? bidAt)?  $default,) {final _that = this;
switch (_that) {
case _BidResponse() when $default != null:
return $default(_that.id,_that.auctionId,_that.roundId,_that.leaguePlayerId,_that.franchiseId,_that.bidAmount,_that.status,_that.recordedBy,_that.bidAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BidResponse implements BidResponse {
  const _BidResponse({required this.id, required this.auctionId, required this.roundId, required this.leaguePlayerId, required this.franchiseId, required this.bidAmount, @JsonKey(unknownEnumValue: BidStatus.unknown) required this.status, this.recordedBy, this.bidAt});
  factory _BidResponse.fromJson(Map<String, dynamic> json) => _$BidResponseFromJson(json);

@override final  String id;
@override final  String auctionId;
@override final  String roundId;
@override final  String leaguePlayerId;
@override final  String franchiseId;
@override final  int bidAmount;
@override@JsonKey(unknownEnumValue: BidStatus.unknown) final  BidStatus status;
@override final  String? recordedBy;
@override final  DateTime? bidAt;

/// Create a copy of BidResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BidResponseCopyWith<_BidResponse> get copyWith => __$BidResponseCopyWithImpl<_BidResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BidResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BidResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.auctionId, auctionId) || other.auctionId == auctionId)&&(identical(other.roundId, roundId) || other.roundId == roundId)&&(identical(other.leaguePlayerId, leaguePlayerId) || other.leaguePlayerId == leaguePlayerId)&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.bidAmount, bidAmount) || other.bidAmount == bidAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.recordedBy, recordedBy) || other.recordedBy == recordedBy)&&(identical(other.bidAt, bidAt) || other.bidAt == bidAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,auctionId,roundId,leaguePlayerId,franchiseId,bidAmount,status,recordedBy,bidAt);

@override
String toString() {
  return 'BidResponse(id: $id, auctionId: $auctionId, roundId: $roundId, leaguePlayerId: $leaguePlayerId, franchiseId: $franchiseId, bidAmount: $bidAmount, status: $status, recordedBy: $recordedBy, bidAt: $bidAt)';
}


}

/// @nodoc
abstract mixin class _$BidResponseCopyWith<$Res> implements $BidResponseCopyWith<$Res> {
  factory _$BidResponseCopyWith(_BidResponse value, $Res Function(_BidResponse) _then) = __$BidResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String auctionId, String roundId, String leaguePlayerId, String franchiseId, int bidAmount,@JsonKey(unknownEnumValue: BidStatus.unknown) BidStatus status, String? recordedBy, DateTime? bidAt
});




}
/// @nodoc
class __$BidResponseCopyWithImpl<$Res>
    implements _$BidResponseCopyWith<$Res> {
  __$BidResponseCopyWithImpl(this._self, this._then);

  final _BidResponse _self;
  final $Res Function(_BidResponse) _then;

/// Create a copy of BidResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? auctionId = null,Object? roundId = null,Object? leaguePlayerId = null,Object? franchiseId = null,Object? bidAmount = null,Object? status = null,Object? recordedBy = freezed,Object? bidAt = freezed,}) {
  return _then(_BidResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,auctionId: null == auctionId ? _self.auctionId : auctionId // ignore: cast_nullable_to_non_nullable
as String,roundId: null == roundId ? _self.roundId : roundId // ignore: cast_nullable_to_non_nullable
as String,leaguePlayerId: null == leaguePlayerId ? _self.leaguePlayerId : leaguePlayerId // ignore: cast_nullable_to_non_nullable
as String,franchiseId: null == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String,bidAmount: null == bidAmount ? _self.bidAmount : bidAmount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BidStatus,recordedBy: freezed == recordedBy ? _self.recordedBy : recordedBy // ignore: cast_nullable_to_non_nullable
as String?,bidAt: freezed == bidAt ? _self.bidAt : bidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$CategoryIncrement {

 String get id; String get roundId; String? get category; String? get tag; int get bidIncrement;
/// Create a copy of CategoryIncrement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryIncrementCopyWith<CategoryIncrement> get copyWith => _$CategoryIncrementCopyWithImpl<CategoryIncrement>(this as CategoryIncrement, _$identity);

  /// Serializes this CategoryIncrement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryIncrement&&(identical(other.id, id) || other.id == id)&&(identical(other.roundId, roundId) || other.roundId == roundId)&&(identical(other.category, category) || other.category == category)&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.bidIncrement, bidIncrement) || other.bidIncrement == bidIncrement));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,roundId,category,tag,bidIncrement);

@override
String toString() {
  return 'CategoryIncrement(id: $id, roundId: $roundId, category: $category, tag: $tag, bidIncrement: $bidIncrement)';
}


}

/// @nodoc
abstract mixin class $CategoryIncrementCopyWith<$Res>  {
  factory $CategoryIncrementCopyWith(CategoryIncrement value, $Res Function(CategoryIncrement) _then) = _$CategoryIncrementCopyWithImpl;
@useResult
$Res call({
 String id, String roundId, String? category, String? tag, int bidIncrement
});




}
/// @nodoc
class _$CategoryIncrementCopyWithImpl<$Res>
    implements $CategoryIncrementCopyWith<$Res> {
  _$CategoryIncrementCopyWithImpl(this._self, this._then);

  final CategoryIncrement _self;
  final $Res Function(CategoryIncrement) _then;

/// Create a copy of CategoryIncrement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? roundId = null,Object? category = freezed,Object? tag = freezed,Object? bidIncrement = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roundId: null == roundId ? _self.roundId : roundId // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,tag: freezed == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String?,bidIncrement: null == bidIncrement ? _self.bidIncrement : bidIncrement // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryIncrement].
extension CategoryIncrementPatterns on CategoryIncrement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryIncrement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryIncrement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryIncrement value)  $default,){
final _that = this;
switch (_that) {
case _CategoryIncrement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryIncrement value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryIncrement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String roundId,  String? category,  String? tag,  int bidIncrement)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryIncrement() when $default != null:
return $default(_that.id,_that.roundId,_that.category,_that.tag,_that.bidIncrement);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String roundId,  String? category,  String? tag,  int bidIncrement)  $default,) {final _that = this;
switch (_that) {
case _CategoryIncrement():
return $default(_that.id,_that.roundId,_that.category,_that.tag,_that.bidIncrement);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String roundId,  String? category,  String? tag,  int bidIncrement)?  $default,) {final _that = this;
switch (_that) {
case _CategoryIncrement() when $default != null:
return $default(_that.id,_that.roundId,_that.category,_that.tag,_that.bidIncrement);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CategoryIncrement implements CategoryIncrement {
  const _CategoryIncrement({required this.id, required this.roundId, this.category, this.tag, required this.bidIncrement});
  factory _CategoryIncrement.fromJson(Map<String, dynamic> json) => _$CategoryIncrementFromJson(json);

@override final  String id;
@override final  String roundId;
@override final  String? category;
@override final  String? tag;
@override final  int bidIncrement;

/// Create a copy of CategoryIncrement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryIncrementCopyWith<_CategoryIncrement> get copyWith => __$CategoryIncrementCopyWithImpl<_CategoryIncrement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategoryIncrementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryIncrement&&(identical(other.id, id) || other.id == id)&&(identical(other.roundId, roundId) || other.roundId == roundId)&&(identical(other.category, category) || other.category == category)&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.bidIncrement, bidIncrement) || other.bidIncrement == bidIncrement));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,roundId,category,tag,bidIncrement);

@override
String toString() {
  return 'CategoryIncrement(id: $id, roundId: $roundId, category: $category, tag: $tag, bidIncrement: $bidIncrement)';
}


}

/// @nodoc
abstract mixin class _$CategoryIncrementCopyWith<$Res> implements $CategoryIncrementCopyWith<$Res> {
  factory _$CategoryIncrementCopyWith(_CategoryIncrement value, $Res Function(_CategoryIncrement) _then) = __$CategoryIncrementCopyWithImpl;
@override @useResult
$Res call({
 String id, String roundId, String? category, String? tag, int bidIncrement
});




}
/// @nodoc
class __$CategoryIncrementCopyWithImpl<$Res>
    implements _$CategoryIncrementCopyWith<$Res> {
  __$CategoryIncrementCopyWithImpl(this._self, this._then);

  final _CategoryIncrement _self;
  final $Res Function(_CategoryIncrement) _then;

/// Create a copy of CategoryIncrement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? roundId = null,Object? category = freezed,Object? tag = freezed,Object? bidIncrement = null,}) {
  return _then(_CategoryIncrement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roundId: null == roundId ? _self.roundId : roundId // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,tag: freezed == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String?,bidIncrement: null == bidIncrement ? _self.bidIncrement : bidIncrement // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$AuditLogResponse {

 String get id; String get auctionId; int get sequenceNumber;@JsonKey(unknownEnumValue: AuctionAction.unknown) AuctionAction get action; Map<String, dynamic> get payload; String? get actorId; DateTime? get createdAt;
/// Create a copy of AuditLogResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuditLogResponseCopyWith<AuditLogResponse> get copyWith => _$AuditLogResponseCopyWithImpl<AuditLogResponse>(this as AuditLogResponse, _$identity);

  /// Serializes this AuditLogResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuditLogResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.auctionId, auctionId) || other.auctionId == auctionId)&&(identical(other.sequenceNumber, sequenceNumber) || other.sequenceNumber == sequenceNumber)&&(identical(other.action, action) || other.action == action)&&const DeepCollectionEquality().equals(other.payload, payload)&&(identical(other.actorId, actorId) || other.actorId == actorId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,auctionId,sequenceNumber,action,const DeepCollectionEquality().hash(payload),actorId,createdAt);

@override
String toString() {
  return 'AuditLogResponse(id: $id, auctionId: $auctionId, sequenceNumber: $sequenceNumber, action: $action, payload: $payload, actorId: $actorId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AuditLogResponseCopyWith<$Res>  {
  factory $AuditLogResponseCopyWith(AuditLogResponse value, $Res Function(AuditLogResponse) _then) = _$AuditLogResponseCopyWithImpl;
@useResult
$Res call({
 String id, String auctionId, int sequenceNumber,@JsonKey(unknownEnumValue: AuctionAction.unknown) AuctionAction action, Map<String, dynamic> payload, String? actorId, DateTime? createdAt
});




}
/// @nodoc
class _$AuditLogResponseCopyWithImpl<$Res>
    implements $AuditLogResponseCopyWith<$Res> {
  _$AuditLogResponseCopyWithImpl(this._self, this._then);

  final AuditLogResponse _self;
  final $Res Function(AuditLogResponse) _then;

/// Create a copy of AuditLogResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? auctionId = null,Object? sequenceNumber = null,Object? action = null,Object? payload = null,Object? actorId = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,auctionId: null == auctionId ? _self.auctionId : auctionId // ignore: cast_nullable_to_non_nullable
as String,sequenceNumber: null == sequenceNumber ? _self.sequenceNumber : sequenceNumber // ignore: cast_nullable_to_non_nullable
as int,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as AuctionAction,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,actorId: freezed == actorId ? _self.actorId : actorId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AuditLogResponse].
extension AuditLogResponsePatterns on AuditLogResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuditLogResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuditLogResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuditLogResponse value)  $default,){
final _that = this;
switch (_that) {
case _AuditLogResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuditLogResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AuditLogResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String auctionId,  int sequenceNumber, @JsonKey(unknownEnumValue: AuctionAction.unknown)  AuctionAction action,  Map<String, dynamic> payload,  String? actorId,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuditLogResponse() when $default != null:
return $default(_that.id,_that.auctionId,_that.sequenceNumber,_that.action,_that.payload,_that.actorId,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String auctionId,  int sequenceNumber, @JsonKey(unknownEnumValue: AuctionAction.unknown)  AuctionAction action,  Map<String, dynamic> payload,  String? actorId,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _AuditLogResponse():
return $default(_that.id,_that.auctionId,_that.sequenceNumber,_that.action,_that.payload,_that.actorId,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String auctionId,  int sequenceNumber, @JsonKey(unknownEnumValue: AuctionAction.unknown)  AuctionAction action,  Map<String, dynamic> payload,  String? actorId,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AuditLogResponse() when $default != null:
return $default(_that.id,_that.auctionId,_that.sequenceNumber,_that.action,_that.payload,_that.actorId,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuditLogResponse implements AuditLogResponse {
  const _AuditLogResponse({required this.id, required this.auctionId, required this.sequenceNumber, @JsonKey(unknownEnumValue: AuctionAction.unknown) required this.action, final  Map<String, dynamic> payload = const <String, dynamic>{}, this.actorId, this.createdAt}): _payload = payload;
  factory _AuditLogResponse.fromJson(Map<String, dynamic> json) => _$AuditLogResponseFromJson(json);

@override final  String id;
@override final  String auctionId;
@override final  int sequenceNumber;
@override@JsonKey(unknownEnumValue: AuctionAction.unknown) final  AuctionAction action;
 final  Map<String, dynamic> _payload;
@override@JsonKey() Map<String, dynamic> get payload {
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payload);
}

@override final  String? actorId;
@override final  DateTime? createdAt;

/// Create a copy of AuditLogResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuditLogResponseCopyWith<_AuditLogResponse> get copyWith => __$AuditLogResponseCopyWithImpl<_AuditLogResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuditLogResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuditLogResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.auctionId, auctionId) || other.auctionId == auctionId)&&(identical(other.sequenceNumber, sequenceNumber) || other.sequenceNumber == sequenceNumber)&&(identical(other.action, action) || other.action == action)&&const DeepCollectionEquality().equals(other._payload, _payload)&&(identical(other.actorId, actorId) || other.actorId == actorId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,auctionId,sequenceNumber,action,const DeepCollectionEquality().hash(_payload),actorId,createdAt);

@override
String toString() {
  return 'AuditLogResponse(id: $id, auctionId: $auctionId, sequenceNumber: $sequenceNumber, action: $action, payload: $payload, actorId: $actorId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AuditLogResponseCopyWith<$Res> implements $AuditLogResponseCopyWith<$Res> {
  factory _$AuditLogResponseCopyWith(_AuditLogResponse value, $Res Function(_AuditLogResponse) _then) = __$AuditLogResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String auctionId, int sequenceNumber,@JsonKey(unknownEnumValue: AuctionAction.unknown) AuctionAction action, Map<String, dynamic> payload, String? actorId, DateTime? createdAt
});




}
/// @nodoc
class __$AuditLogResponseCopyWithImpl<$Res>
    implements _$AuditLogResponseCopyWith<$Res> {
  __$AuditLogResponseCopyWithImpl(this._self, this._then);

  final _AuditLogResponse _self;
  final $Res Function(_AuditLogResponse) _then;

/// Create a copy of AuditLogResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? auctionId = null,Object? sequenceNumber = null,Object? action = null,Object? payload = null,Object? actorId = freezed,Object? createdAt = freezed,}) {
  return _then(_AuditLogResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,auctionId: null == auctionId ? _self.auctionId : auctionId // ignore: cast_nullable_to_non_nullable
as String,sequenceNumber: null == sequenceNumber ? _self.sequenceNumber : sequenceNumber // ignore: cast_nullable_to_non_nullable
as int,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as AuctionAction,payload: null == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,actorId: freezed == actorId ? _self.actorId : actorId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
