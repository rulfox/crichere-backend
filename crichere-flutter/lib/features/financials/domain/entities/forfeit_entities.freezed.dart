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

 String get id; String get leagueId; String get userId; String? get franchiseId; String get type;// PLAYER, FRANCHISE
 String get reason; String get status;// PENDING, APPROVED, REJECTED
 String? get feeRefundDecision; int? get feeRefundAmount; String? get adminNotes; DateTime get createdAt; DateTime? get resolvedAt;
/// Create a copy of ForfeitRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForfeitRequestCopyWith<ForfeitRequest> get copyWith => _$ForfeitRequestCopyWithImpl<ForfeitRequest>(this as ForfeitRequest, _$identity);

  /// Serializes this ForfeitRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForfeitRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.type, type) || other.type == type)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.feeRefundDecision, feeRefundDecision) || other.feeRefundDecision == feeRefundDecision)&&(identical(other.feeRefundAmount, feeRefundAmount) || other.feeRefundAmount == feeRefundAmount)&&(identical(other.adminNotes, adminNotes) || other.adminNotes == adminNotes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,leagueId,userId,franchiseId,type,reason,status,feeRefundDecision,feeRefundAmount,adminNotes,createdAt,resolvedAt);

@override
String toString() {
  return 'ForfeitRequest(id: $id, leagueId: $leagueId, userId: $userId, franchiseId: $franchiseId, type: $type, reason: $reason, status: $status, feeRefundDecision: $feeRefundDecision, feeRefundAmount: $feeRefundAmount, adminNotes: $adminNotes, createdAt: $createdAt, resolvedAt: $resolvedAt)';
}


}

/// @nodoc
abstract mixin class $ForfeitRequestCopyWith<$Res>  {
  factory $ForfeitRequestCopyWith(ForfeitRequest value, $Res Function(ForfeitRequest) _then) = _$ForfeitRequestCopyWithImpl;
@useResult
$Res call({
 String id, String leagueId, String userId, String? franchiseId, String type, String reason, String status, String? feeRefundDecision, int? feeRefundAmount, String? adminNotes, DateTime createdAt, DateTime? resolvedAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? leagueId = null,Object? userId = null,Object? franchiseId = freezed,Object? type = null,Object? reason = null,Object? status = null,Object? feeRefundDecision = freezed,Object? feeRefundAmount = freezed,Object? adminNotes = freezed,Object? createdAt = null,Object? resolvedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,franchiseId: freezed == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,feeRefundDecision: freezed == feeRefundDecision ? _self.feeRefundDecision : feeRefundDecision // ignore: cast_nullable_to_non_nullable
as String?,feeRefundAmount: freezed == feeRefundAmount ? _self.feeRefundAmount : feeRefundAmount // ignore: cast_nullable_to_non_nullable
as int?,adminNotes: freezed == adminNotes ? _self.adminNotes : adminNotes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String leagueId,  String userId,  String? franchiseId,  String type,  String reason,  String status,  String? feeRefundDecision,  int? feeRefundAmount,  String? adminNotes,  DateTime createdAt,  DateTime? resolvedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ForfeitRequest() when $default != null:
return $default(_that.id,_that.leagueId,_that.userId,_that.franchiseId,_that.type,_that.reason,_that.status,_that.feeRefundDecision,_that.feeRefundAmount,_that.adminNotes,_that.createdAt,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String leagueId,  String userId,  String? franchiseId,  String type,  String reason,  String status,  String? feeRefundDecision,  int? feeRefundAmount,  String? adminNotes,  DateTime createdAt,  DateTime? resolvedAt)  $default,) {final _that = this;
switch (_that) {
case _ForfeitRequest():
return $default(_that.id,_that.leagueId,_that.userId,_that.franchiseId,_that.type,_that.reason,_that.status,_that.feeRefundDecision,_that.feeRefundAmount,_that.adminNotes,_that.createdAt,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String leagueId,  String userId,  String? franchiseId,  String type,  String reason,  String status,  String? feeRefundDecision,  int? feeRefundAmount,  String? adminNotes,  DateTime createdAt,  DateTime? resolvedAt)?  $default,) {final _that = this;
switch (_that) {
case _ForfeitRequest() when $default != null:
return $default(_that.id,_that.leagueId,_that.userId,_that.franchiseId,_that.type,_that.reason,_that.status,_that.feeRefundDecision,_that.feeRefundAmount,_that.adminNotes,_that.createdAt,_that.resolvedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ForfeitRequest implements ForfeitRequest {
  const _ForfeitRequest({required this.id, required this.leagueId, required this.userId, this.franchiseId, required this.type, required this.reason, required this.status, this.feeRefundDecision, this.feeRefundAmount, this.adminNotes, required this.createdAt, this.resolvedAt});
  factory _ForfeitRequest.fromJson(Map<String, dynamic> json) => _$ForfeitRequestFromJson(json);

@override final  String id;
@override final  String leagueId;
@override final  String userId;
@override final  String? franchiseId;
@override final  String type;
// PLAYER, FRANCHISE
@override final  String reason;
@override final  String status;
// PENDING, APPROVED, REJECTED
@override final  String? feeRefundDecision;
@override final  int? feeRefundAmount;
@override final  String? adminNotes;
@override final  DateTime createdAt;
@override final  DateTime? resolvedAt;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForfeitRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.type, type) || other.type == type)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.feeRefundDecision, feeRefundDecision) || other.feeRefundDecision == feeRefundDecision)&&(identical(other.feeRefundAmount, feeRefundAmount) || other.feeRefundAmount == feeRefundAmount)&&(identical(other.adminNotes, adminNotes) || other.adminNotes == adminNotes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,leagueId,userId,franchiseId,type,reason,status,feeRefundDecision,feeRefundAmount,adminNotes,createdAt,resolvedAt);

@override
String toString() {
  return 'ForfeitRequest(id: $id, leagueId: $leagueId, userId: $userId, franchiseId: $franchiseId, type: $type, reason: $reason, status: $status, feeRefundDecision: $feeRefundDecision, feeRefundAmount: $feeRefundAmount, adminNotes: $adminNotes, createdAt: $createdAt, resolvedAt: $resolvedAt)';
}


}

/// @nodoc
abstract mixin class _$ForfeitRequestCopyWith<$Res> implements $ForfeitRequestCopyWith<$Res> {
  factory _$ForfeitRequestCopyWith(_ForfeitRequest value, $Res Function(_ForfeitRequest) _then) = __$ForfeitRequestCopyWithImpl;
@override @useResult
$Res call({
 String id, String leagueId, String userId, String? franchiseId, String type, String reason, String status, String? feeRefundDecision, int? feeRefundAmount, String? adminNotes, DateTime createdAt, DateTime? resolvedAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? leagueId = null,Object? userId = null,Object? franchiseId = freezed,Object? type = null,Object? reason = null,Object? status = null,Object? feeRefundDecision = freezed,Object? feeRefundAmount = freezed,Object? adminNotes = freezed,Object? createdAt = null,Object? resolvedAt = freezed,}) {
  return _then(_ForfeitRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,franchiseId: freezed == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,feeRefundDecision: freezed == feeRefundDecision ? _self.feeRefundDecision : feeRefundDecision // ignore: cast_nullable_to_non_nullable
as String?,feeRefundAmount: freezed == feeRefundAmount ? _self.feeRefundAmount : feeRefundAmount // ignore: cast_nullable_to_non_nullable
as int?,adminNotes: freezed == adminNotes ? _self.adminNotes : adminNotes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$ForfeitRequestListResponse {

 List<ForfeitRequest> get requests; int get totalElements; int get totalPages; int get pageNumber; int get pageSize;
/// Create a copy of ForfeitRequestListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForfeitRequestListResponseCopyWith<ForfeitRequestListResponse> get copyWith => _$ForfeitRequestListResponseCopyWithImpl<ForfeitRequestListResponse>(this as ForfeitRequestListResponse, _$identity);

  /// Serializes this ForfeitRequestListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForfeitRequestListResponse&&const DeepCollectionEquality().equals(other.requests, requests)&&(identical(other.totalElements, totalElements) || other.totalElements == totalElements)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(requests),totalElements,totalPages,pageNumber,pageSize);

@override
String toString() {
  return 'ForfeitRequestListResponse(requests: $requests, totalElements: $totalElements, totalPages: $totalPages, pageNumber: $pageNumber, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class $ForfeitRequestListResponseCopyWith<$Res>  {
  factory $ForfeitRequestListResponseCopyWith(ForfeitRequestListResponse value, $Res Function(ForfeitRequestListResponse) _then) = _$ForfeitRequestListResponseCopyWithImpl;
@useResult
$Res call({
 List<ForfeitRequest> requests, int totalElements, int totalPages, int pageNumber, int pageSize
});




}
/// @nodoc
class _$ForfeitRequestListResponseCopyWithImpl<$Res>
    implements $ForfeitRequestListResponseCopyWith<$Res> {
  _$ForfeitRequestListResponseCopyWithImpl(this._self, this._then);

  final ForfeitRequestListResponse _self;
  final $Res Function(ForfeitRequestListResponse) _then;

/// Create a copy of ForfeitRequestListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? requests = null,Object? totalElements = null,Object? totalPages = null,Object? pageNumber = null,Object? pageSize = null,}) {
  return _then(_self.copyWith(
requests: null == requests ? _self.requests : requests // ignore: cast_nullable_to_non_nullable
as List<ForfeitRequest>,totalElements: null == totalElements ? _self.totalElements : totalElements // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ForfeitRequestListResponse].
extension ForfeitRequestListResponsePatterns on ForfeitRequestListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ForfeitRequestListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ForfeitRequestListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ForfeitRequestListResponse value)  $default,){
final _that = this;
switch (_that) {
case _ForfeitRequestListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ForfeitRequestListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ForfeitRequestListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ForfeitRequest> requests,  int totalElements,  int totalPages,  int pageNumber,  int pageSize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ForfeitRequestListResponse() when $default != null:
return $default(_that.requests,_that.totalElements,_that.totalPages,_that.pageNumber,_that.pageSize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ForfeitRequest> requests,  int totalElements,  int totalPages,  int pageNumber,  int pageSize)  $default,) {final _that = this;
switch (_that) {
case _ForfeitRequestListResponse():
return $default(_that.requests,_that.totalElements,_that.totalPages,_that.pageNumber,_that.pageSize);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ForfeitRequest> requests,  int totalElements,  int totalPages,  int pageNumber,  int pageSize)?  $default,) {final _that = this;
switch (_that) {
case _ForfeitRequestListResponse() when $default != null:
return $default(_that.requests,_that.totalElements,_that.totalPages,_that.pageNumber,_that.pageSize);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ForfeitRequestListResponse implements ForfeitRequestListResponse {
  const _ForfeitRequestListResponse({required final  List<ForfeitRequest> requests, required this.totalElements, required this.totalPages, required this.pageNumber, required this.pageSize}): _requests = requests;
  factory _ForfeitRequestListResponse.fromJson(Map<String, dynamic> json) => _$ForfeitRequestListResponseFromJson(json);

 final  List<ForfeitRequest> _requests;
@override List<ForfeitRequest> get requests {
  if (_requests is EqualUnmodifiableListView) return _requests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requests);
}

@override final  int totalElements;
@override final  int totalPages;
@override final  int pageNumber;
@override final  int pageSize;

/// Create a copy of ForfeitRequestListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForfeitRequestListResponseCopyWith<_ForfeitRequestListResponse> get copyWith => __$ForfeitRequestListResponseCopyWithImpl<_ForfeitRequestListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ForfeitRequestListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForfeitRequestListResponse&&const DeepCollectionEquality().equals(other._requests, _requests)&&(identical(other.totalElements, totalElements) || other.totalElements == totalElements)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_requests),totalElements,totalPages,pageNumber,pageSize);

@override
String toString() {
  return 'ForfeitRequestListResponse(requests: $requests, totalElements: $totalElements, totalPages: $totalPages, pageNumber: $pageNumber, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class _$ForfeitRequestListResponseCopyWith<$Res> implements $ForfeitRequestListResponseCopyWith<$Res> {
  factory _$ForfeitRequestListResponseCopyWith(_ForfeitRequestListResponse value, $Res Function(_ForfeitRequestListResponse) _then) = __$ForfeitRequestListResponseCopyWithImpl;
@override @useResult
$Res call({
 List<ForfeitRequest> requests, int totalElements, int totalPages, int pageNumber, int pageSize
});




}
/// @nodoc
class __$ForfeitRequestListResponseCopyWithImpl<$Res>
    implements _$ForfeitRequestListResponseCopyWith<$Res> {
  __$ForfeitRequestListResponseCopyWithImpl(this._self, this._then);

  final _ForfeitRequestListResponse _self;
  final $Res Function(_ForfeitRequestListResponse) _then;

/// Create a copy of ForfeitRequestListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? requests = null,Object? totalElements = null,Object? totalPages = null,Object? pageNumber = null,Object? pageSize = null,}) {
  return _then(_ForfeitRequestListResponse(
requests: null == requests ? _self._requests : requests // ignore: cast_nullable_to_non_nullable
as List<ForfeitRequest>,totalElements: null == totalElements ? _self.totalElements : totalElements // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
