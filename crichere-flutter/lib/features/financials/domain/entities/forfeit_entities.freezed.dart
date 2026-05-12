// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forfeit_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ForfeitRequest {

 String get id; String get leagueId; String get entityId; String get entityName; String get type;// PLAYER, FRANCHISE
 String get reason; String get status;// PENDING, APPROVED, REJECTED
 DateTime get createdAt; int? get refundAmount; bool? get promoteNext;
/// Create a copy of ForfeitRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForfeitRequestCopyWith<ForfeitRequest> get copyWith => _$ForfeitRequestCopyWithImpl<ForfeitRequest>(this as ForfeitRequest, _$identity);

  /// Serializes this ForfeitRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForfeitRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.entityName, entityName) || other.entityName == entityName)&&(identical(other.type, type) || other.type == type)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.refundAmount, refundAmount) || other.refundAmount == refundAmount)&&(identical(other.promoteNext, promoteNext) || other.promoteNext == promoteNext));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,leagueId,entityId,entityName,type,reason,status,createdAt,refundAmount,promoteNext);

@override
String toString() {
  return 'ForfeitRequest(id: $id, leagueId: $leagueId, entityId: $entityId, entityName: $entityName, type: $type, reason: $reason, status: $status, createdAt: $createdAt, refundAmount: $refundAmount, promoteNext: $promoteNext)';
}


}

/// @nodoc
abstract mixin class $ForfeitRequestCopyWith<$Res>  {
  factory $ForfeitRequestCopyWith(ForfeitRequest value, $Res Function(ForfeitRequest) _then) = _$ForfeitRequestCopyWithImpl;
@useResult
$Res call({
 String id, String leagueId, String entityId, String entityName, String type, String reason, String status, DateTime createdAt, int? refundAmount, bool? promoteNext
});




}
/// @nodoc
class _$ForfeitRequestCopyWithImpl<$Res>
    implements $ForfeitRequestCopyWith<$Res> {
  _$ForfeitRequestCopyWithImpl(this._self, this._then);

  final ForfeitRequest _self;
  final $Res Function(ForfeitRequest) _then;

/// Create a copy of ForfeitRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? leagueId = null,Object? entityId = null,Object? entityName = null,Object? type = null,Object? reason = null,Object? status = null,Object? createdAt = null,Object? refundAmount = freezed,Object? promoteNext = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,entityName: null == entityName ? _self.entityName : entityName // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,refundAmount: freezed == refundAmount ? _self.refundAmount : refundAmount // ignore: cast_nullable_to_non_nullable
as int?,promoteNext: freezed == promoteNext ? _self.promoteNext : promoteNext // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [ForfeitRequest].
extension ForfeitRequestPatterns on ForfeitRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ForfeitRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ForfeitRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ForfeitRequest value)  $default,){
final _that = this;
switch (_that) {
case _ForfeitRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ForfeitRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ForfeitRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String leagueId,  String entityId,  String entityName,  String type,  String reason,  String status,  DateTime createdAt,  int? refundAmount,  bool? promoteNext)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ForfeitRequest() when $default != null:
return $default(_that.id,_that.leagueId,_that.entityId,_that.entityName,_that.type,_that.reason,_that.status,_that.createdAt,_that.refundAmount,_that.promoteNext);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String leagueId,  String entityId,  String entityName,  String type,  String reason,  String status,  DateTime createdAt,  int? refundAmount,  bool? promoteNext)  $default,) {final _that = this;
switch (_that) {
case _ForfeitRequest():
return $default(_that.id,_that.leagueId,_that.entityId,_that.entityName,_that.type,_that.reason,_that.status,_that.createdAt,_that.refundAmount,_that.promoteNext);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String leagueId,  String entityId,  String entityName,  String type,  String reason,  String status,  DateTime createdAt,  int? refundAmount,  bool? promoteNext)?  $default,) {final _that = this;
switch (_that) {
case _ForfeitRequest() when $default != null:
return $default(_that.id,_that.leagueId,_that.entityId,_that.entityName,_that.type,_that.reason,_that.status,_that.createdAt,_that.refundAmount,_that.promoteNext);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ForfeitRequest implements ForfeitRequest {
  const _ForfeitRequest({required this.id, required this.leagueId, required this.entityId, required this.entityName, required this.type, required this.reason, required this.status, required this.createdAt, this.refundAmount, this.promoteNext});
  factory _ForfeitRequest.fromJson(Map<String, dynamic> json) => _$ForfeitRequestFromJson(json);

@override final  String id;
@override final  String leagueId;
@override final  String entityId;
@override final  String entityName;
@override final  String type;
// PLAYER, FRANCHISE
@override final  String reason;
@override final  String status;
// PENDING, APPROVED, REJECTED
@override final  DateTime createdAt;
@override final  int? refundAmount;
@override final  bool? promoteNext;

/// Create a copy of ForfeitRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForfeitRequestCopyWith<_ForfeitRequest> get copyWith => __$ForfeitRequestCopyWithImpl<_ForfeitRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ForfeitRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForfeitRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.entityName, entityName) || other.entityName == entityName)&&(identical(other.type, type) || other.type == type)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.refundAmount, refundAmount) || other.refundAmount == refundAmount)&&(identical(other.promoteNext, promoteNext) || other.promoteNext == promoteNext));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,leagueId,entityId,entityName,type,reason,status,createdAt,refundAmount,promoteNext);

@override
String toString() {
  return 'ForfeitRequest(id: $id, leagueId: $leagueId, entityId: $entityId, entityName: $entityName, type: $type, reason: $reason, status: $status, createdAt: $createdAt, refundAmount: $refundAmount, promoteNext: $promoteNext)';
}


}

/// @nodoc
abstract mixin class _$ForfeitRequestCopyWith<$Res> implements $ForfeitRequestCopyWith<$Res> {
  factory _$ForfeitRequestCopyWith(_ForfeitRequest value, $Res Function(_ForfeitRequest) _then) = __$ForfeitRequestCopyWithImpl;
@override @useResult
$Res call({
 String id, String leagueId, String entityId, String entityName, String type, String reason, String status, DateTime createdAt, int? refundAmount, bool? promoteNext
});




}
/// @nodoc
class __$ForfeitRequestCopyWithImpl<$Res>
    implements _$ForfeitRequestCopyWith<$Res> {
  __$ForfeitRequestCopyWithImpl(this._self, this._then);

  final _ForfeitRequest _self;
  final $Res Function(_ForfeitRequest) _then;

/// Create a copy of ForfeitRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? leagueId = null,Object? entityId = null,Object? entityName = null,Object? type = null,Object? reason = null,Object? status = null,Object? createdAt = null,Object? refundAmount = freezed,Object? promoteNext = freezed,}) {
  return _then(_ForfeitRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,entityName: null == entityName ? _self.entityName : entityName // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,refundAmount: freezed == refundAmount ? _self.refundAmount : refundAmount // ignore: cast_nullable_to_non_nullable
as int?,promoteNext: freezed == promoteNext ? _self.promoteNext : promoteNext // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
