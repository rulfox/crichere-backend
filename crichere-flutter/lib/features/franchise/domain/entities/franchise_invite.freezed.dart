// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'franchise_invite.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InviteValidationResponse {

 String get franchiseId; String get franchiseName; String get leagueId; String get leagueName; String get invitedBy; DateTime get expiresAt;
/// Create a copy of InviteValidationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InviteValidationResponseCopyWith<InviteValidationResponse> get copyWith => _$InviteValidationResponseCopyWithImpl<InviteValidationResponse>(this as InviteValidationResponse, _$identity);

  /// Serializes this InviteValidationResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InviteValidationResponse&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.franchiseName, franchiseName) || other.franchiseName == franchiseName)&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.leagueName, leagueName) || other.leagueName == leagueName)&&(identical(other.invitedBy, invitedBy) || other.invitedBy == invitedBy)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,franchiseId,franchiseName,leagueId,leagueName,invitedBy,expiresAt);

@override
String toString() {
  return 'InviteValidationResponse(franchiseId: $franchiseId, franchiseName: $franchiseName, leagueId: $leagueId, leagueName: $leagueName, invitedBy: $invitedBy, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $InviteValidationResponseCopyWith<$Res>  {
  factory $InviteValidationResponseCopyWith(InviteValidationResponse value, $Res Function(InviteValidationResponse) _then) = _$InviteValidationResponseCopyWithImpl;
@useResult
$Res call({
 String franchiseId, String franchiseName, String leagueId, String leagueName, String invitedBy, DateTime expiresAt
});




}
/// @nodoc
class _$InviteValidationResponseCopyWithImpl<$Res>
    implements $InviteValidationResponseCopyWith<$Res> {
  _$InviteValidationResponseCopyWithImpl(this._self, this._then);

  final InviteValidationResponse _self;
  final $Res Function(InviteValidationResponse) _then;

/// Create a copy of InviteValidationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? franchiseId = null,Object? franchiseName = null,Object? leagueId = null,Object? leagueName = null,Object? invitedBy = null,Object? expiresAt = null,}) {
  return _then(_self.copyWith(
franchiseId: null == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String,franchiseName: null == franchiseName ? _self.franchiseName : franchiseName // ignore: cast_nullable_to_non_nullable
as String,leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,leagueName: null == leagueName ? _self.leagueName : leagueName // ignore: cast_nullable_to_non_nullable
as String,invitedBy: null == invitedBy ? _self.invitedBy : invitedBy // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [InviteValidationResponse].
extension InviteValidationResponsePatterns on InviteValidationResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InviteValidationResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InviteValidationResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InviteValidationResponse value)  $default,){
final _that = this;
switch (_that) {
case _InviteValidationResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InviteValidationResponse value)?  $default,){
final _that = this;
switch (_that) {
case _InviteValidationResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String franchiseId,  String franchiseName,  String leagueId,  String leagueName,  String invitedBy,  DateTime expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InviteValidationResponse() when $default != null:
return $default(_that.franchiseId,_that.franchiseName,_that.leagueId,_that.leagueName,_that.invitedBy,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String franchiseId,  String franchiseName,  String leagueId,  String leagueName,  String invitedBy,  DateTime expiresAt)  $default,) {final _that = this;
switch (_that) {
case _InviteValidationResponse():
return $default(_that.franchiseId,_that.franchiseName,_that.leagueId,_that.leagueName,_that.invitedBy,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String franchiseId,  String franchiseName,  String leagueId,  String leagueName,  String invitedBy,  DateTime expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _InviteValidationResponse() when $default != null:
return $default(_that.franchiseId,_that.franchiseName,_that.leagueId,_that.leagueName,_that.invitedBy,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InviteValidationResponse implements InviteValidationResponse {
  const _InviteValidationResponse({required this.franchiseId, required this.franchiseName, required this.leagueId, required this.leagueName, required this.invitedBy, required this.expiresAt});
  factory _InviteValidationResponse.fromJson(Map<String, dynamic> json) => _$InviteValidationResponseFromJson(json);

@override final  String franchiseId;
@override final  String franchiseName;
@override final  String leagueId;
@override final  String leagueName;
@override final  String invitedBy;
@override final  DateTime expiresAt;

/// Create a copy of InviteValidationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteValidationResponseCopyWith<_InviteValidationResponse> get copyWith => __$InviteValidationResponseCopyWithImpl<_InviteValidationResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InviteValidationResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteValidationResponse&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.franchiseName, franchiseName) || other.franchiseName == franchiseName)&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.leagueName, leagueName) || other.leagueName == leagueName)&&(identical(other.invitedBy, invitedBy) || other.invitedBy == invitedBy)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,franchiseId,franchiseName,leagueId,leagueName,invitedBy,expiresAt);

@override
String toString() {
  return 'InviteValidationResponse(franchiseId: $franchiseId, franchiseName: $franchiseName, leagueId: $leagueId, leagueName: $leagueName, invitedBy: $invitedBy, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$InviteValidationResponseCopyWith<$Res> implements $InviteValidationResponseCopyWith<$Res> {
  factory _$InviteValidationResponseCopyWith(_InviteValidationResponse value, $Res Function(_InviteValidationResponse) _then) = __$InviteValidationResponseCopyWithImpl;
@override @useResult
$Res call({
 String franchiseId, String franchiseName, String leagueId, String leagueName, String invitedBy, DateTime expiresAt
});




}
/// @nodoc
class __$InviteValidationResponseCopyWithImpl<$Res>
    implements _$InviteValidationResponseCopyWith<$Res> {
  __$InviteValidationResponseCopyWithImpl(this._self, this._then);

  final _InviteValidationResponse _self;
  final $Res Function(_InviteValidationResponse) _then;

/// Create a copy of InviteValidationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? franchiseId = null,Object? franchiseName = null,Object? leagueId = null,Object? leagueName = null,Object? invitedBy = null,Object? expiresAt = null,}) {
  return _then(_InviteValidationResponse(
franchiseId: null == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String,franchiseName: null == franchiseName ? _self.franchiseName : franchiseName // ignore: cast_nullable_to_non_nullable
as String,leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,leagueName: null == leagueName ? _self.leagueName : leagueName // ignore: cast_nullable_to_non_nullable
as String,invitedBy: null == invitedBy ? _self.invitedBy : invitedBy // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$InviteAcceptRequest {

 String get token;
/// Create a copy of InviteAcceptRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InviteAcceptRequestCopyWith<InviteAcceptRequest> get copyWith => _$InviteAcceptRequestCopyWithImpl<InviteAcceptRequest>(this as InviteAcceptRequest, _$identity);

  /// Serializes this InviteAcceptRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InviteAcceptRequest&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token);

@override
String toString() {
  return 'InviteAcceptRequest(token: $token)';
}


}

/// @nodoc
abstract mixin class $InviteAcceptRequestCopyWith<$Res>  {
  factory $InviteAcceptRequestCopyWith(InviteAcceptRequest value, $Res Function(InviteAcceptRequest) _then) = _$InviteAcceptRequestCopyWithImpl;
@useResult
$Res call({
 String token
});




}
/// @nodoc
class _$InviteAcceptRequestCopyWithImpl<$Res>
    implements $InviteAcceptRequestCopyWith<$Res> {
  _$InviteAcceptRequestCopyWithImpl(this._self, this._then);

  final InviteAcceptRequest _self;
  final $Res Function(InviteAcceptRequest) _then;

/// Create a copy of InviteAcceptRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,}) {
  return _then(_self.copyWith(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [InviteAcceptRequest].
extension InviteAcceptRequestPatterns on InviteAcceptRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InviteAcceptRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InviteAcceptRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InviteAcceptRequest value)  $default,){
final _that = this;
switch (_that) {
case _InviteAcceptRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InviteAcceptRequest value)?  $default,){
final _that = this;
switch (_that) {
case _InviteAcceptRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String token)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InviteAcceptRequest() when $default != null:
return $default(_that.token);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String token)  $default,) {final _that = this;
switch (_that) {
case _InviteAcceptRequest():
return $default(_that.token);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String token)?  $default,) {final _that = this;
switch (_that) {
case _InviteAcceptRequest() when $default != null:
return $default(_that.token);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InviteAcceptRequest implements InviteAcceptRequest {
  const _InviteAcceptRequest({required this.token});
  factory _InviteAcceptRequest.fromJson(Map<String, dynamic> json) => _$InviteAcceptRequestFromJson(json);

@override final  String token;

/// Create a copy of InviteAcceptRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteAcceptRequestCopyWith<_InviteAcceptRequest> get copyWith => __$InviteAcceptRequestCopyWithImpl<_InviteAcceptRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InviteAcceptRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteAcceptRequest&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token);

@override
String toString() {
  return 'InviteAcceptRequest(token: $token)';
}


}

/// @nodoc
abstract mixin class _$InviteAcceptRequestCopyWith<$Res> implements $InviteAcceptRequestCopyWith<$Res> {
  factory _$InviteAcceptRequestCopyWith(_InviteAcceptRequest value, $Res Function(_InviteAcceptRequest) _then) = __$InviteAcceptRequestCopyWithImpl;
@override @useResult
$Res call({
 String token
});




}
/// @nodoc
class __$InviteAcceptRequestCopyWithImpl<$Res>
    implements _$InviteAcceptRequestCopyWith<$Res> {
  __$InviteAcceptRequestCopyWithImpl(this._self, this._then);

  final _InviteAcceptRequest _self;
  final $Res Function(_InviteAcceptRequest) _then;

/// Create a copy of InviteAcceptRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,}) {
  return _then(_InviteAcceptRequest(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
