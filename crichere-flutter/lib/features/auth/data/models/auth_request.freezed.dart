// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginRequest {

 String get phone;
/// Create a copy of LoginRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginRequestCopyWith<LoginRequest> get copyWith => _$LoginRequestCopyWithImpl<LoginRequest>(this as LoginRequest, _$identity);

  /// Serializes this LoginRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginRequest&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phone);

@override
String toString() {
  return 'LoginRequest(phone: $phone)';
}


}

/// @nodoc
abstract mixin class $LoginRequestCopyWith<$Res>  {
  factory $LoginRequestCopyWith(LoginRequest value, $Res Function(LoginRequest) _then) = _$LoginRequestCopyWithImpl;
@useResult
$Res call({
 String phone
});




}
/// @nodoc
class _$LoginRequestCopyWithImpl<$Res>
    implements $LoginRequestCopyWith<$Res> {
  _$LoginRequestCopyWithImpl(this._self, this._then);

  final LoginRequest _self;
  final $Res Function(LoginRequest) _then;

/// Create a copy of LoginRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phone = null,}) {
  return _then(_self.copyWith(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginRequest].
extension LoginRequestPatterns on LoginRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginRequest value)  $default,){
final _that = this;
switch (_that) {
case _LoginRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginRequest value)?  $default,){
final _that = this;
switch (_that) {
case _LoginRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String phone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginRequest() when $default != null:
return $default(_that.phone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String phone)  $default,) {final _that = this;
switch (_that) {
case _LoginRequest():
return $default(_that.phone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String phone)?  $default,) {final _that = this;
switch (_that) {
case _LoginRequest() when $default != null:
return $default(_that.phone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginRequest implements LoginRequest {
  const _LoginRequest({required this.phone});
  factory _LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);

@override final  String phone;

/// Create a copy of LoginRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginRequestCopyWith<_LoginRequest> get copyWith => __$LoginRequestCopyWithImpl<_LoginRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginRequest&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phone);

@override
String toString() {
  return 'LoginRequest(phone: $phone)';
}


}

/// @nodoc
abstract mixin class _$LoginRequestCopyWith<$Res> implements $LoginRequestCopyWith<$Res> {
  factory _$LoginRequestCopyWith(_LoginRequest value, $Res Function(_LoginRequest) _then) = __$LoginRequestCopyWithImpl;
@override @useResult
$Res call({
 String phone
});




}
/// @nodoc
class __$LoginRequestCopyWithImpl<$Res>
    implements _$LoginRequestCopyWith<$Res> {
  __$LoginRequestCopyWithImpl(this._self, this._then);

  final _LoginRequest _self;
  final $Res Function(_LoginRequest) _then;

/// Create a copy of LoginRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phone = null,}) {
  return _then(_LoginRequest(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$VerifyRequest {

 String get phone; String get code;
/// Create a copy of VerifyRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyRequestCopyWith<VerifyRequest> get copyWith => _$VerifyRequestCopyWithImpl<VerifyRequest>(this as VerifyRequest, _$identity);

  /// Serializes this VerifyRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyRequest&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phone,code);

@override
String toString() {
  return 'VerifyRequest(phone: $phone, code: $code)';
}


}

/// @nodoc
abstract mixin class $VerifyRequestCopyWith<$Res>  {
  factory $VerifyRequestCopyWith(VerifyRequest value, $Res Function(VerifyRequest) _then) = _$VerifyRequestCopyWithImpl;
@useResult
$Res call({
 String phone, String code
});




}
/// @nodoc
class _$VerifyRequestCopyWithImpl<$Res>
    implements $VerifyRequestCopyWith<$Res> {
  _$VerifyRequestCopyWithImpl(this._self, this._then);

  final VerifyRequest _self;
  final $Res Function(VerifyRequest) _then;

/// Create a copy of VerifyRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phone = null,Object? code = null,}) {
  return _then(_self.copyWith(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyRequest].
extension VerifyRequestPatterns on VerifyRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyRequest value)  $default,){
final _that = this;
switch (_that) {
case _VerifyRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyRequest value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String phone,  String code)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyRequest() when $default != null:
return $default(_that.phone,_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String phone,  String code)  $default,) {final _that = this;
switch (_that) {
case _VerifyRequest():
return $default(_that.phone,_that.code);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String phone,  String code)?  $default,) {final _that = this;
switch (_that) {
case _VerifyRequest() when $default != null:
return $default(_that.phone,_that.code);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyRequest implements VerifyRequest {
  const _VerifyRequest({required this.phone, required this.code});
  factory _VerifyRequest.fromJson(Map<String, dynamic> json) => _$VerifyRequestFromJson(json);

@override final  String phone;
@override final  String code;

/// Create a copy of VerifyRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyRequestCopyWith<_VerifyRequest> get copyWith => __$VerifyRequestCopyWithImpl<_VerifyRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyRequest&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phone,code);

@override
String toString() {
  return 'VerifyRequest(phone: $phone, code: $code)';
}


}

/// @nodoc
abstract mixin class _$VerifyRequestCopyWith<$Res> implements $VerifyRequestCopyWith<$Res> {
  factory _$VerifyRequestCopyWith(_VerifyRequest value, $Res Function(_VerifyRequest) _then) = __$VerifyRequestCopyWithImpl;
@override @useResult
$Res call({
 String phone, String code
});




}
/// @nodoc
class __$VerifyRequestCopyWithImpl<$Res>
    implements _$VerifyRequestCopyWith<$Res> {
  __$VerifyRequestCopyWithImpl(this._self, this._then);

  final _VerifyRequest _self;
  final $Res Function(_VerifyRequest) _then;

/// Create a copy of VerifyRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phone = null,Object? code = null,}) {
  return _then(_VerifyRequest(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RefreshRequest {

 String get refreshToken;
/// Create a copy of RefreshRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RefreshRequestCopyWith<RefreshRequest> get copyWith => _$RefreshRequestCopyWithImpl<RefreshRequest>(this as RefreshRequest, _$identity);

  /// Serializes this RefreshRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshRequest&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,refreshToken);

@override
String toString() {
  return 'RefreshRequest(refreshToken: $refreshToken)';
}


}

/// @nodoc
abstract mixin class $RefreshRequestCopyWith<$Res>  {
  factory $RefreshRequestCopyWith(RefreshRequest value, $Res Function(RefreshRequest) _then) = _$RefreshRequestCopyWithImpl;
@useResult
$Res call({
 String refreshToken
});




}
/// @nodoc
class _$RefreshRequestCopyWithImpl<$Res>
    implements $RefreshRequestCopyWith<$Res> {
  _$RefreshRequestCopyWithImpl(this._self, this._then);

  final RefreshRequest _self;
  final $Res Function(RefreshRequest) _then;

/// Create a copy of RefreshRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? refreshToken = null,}) {
  return _then(_self.copyWith(
refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RefreshRequest].
extension RefreshRequestPatterns on RefreshRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RefreshRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RefreshRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RefreshRequest value)  $default,){
final _that = this;
switch (_that) {
case _RefreshRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RefreshRequest value)?  $default,){
final _that = this;
switch (_that) {
case _RefreshRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String refreshToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RefreshRequest() when $default != null:
return $default(_that.refreshToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String refreshToken)  $default,) {final _that = this;
switch (_that) {
case _RefreshRequest():
return $default(_that.refreshToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String refreshToken)?  $default,) {final _that = this;
switch (_that) {
case _RefreshRequest() when $default != null:
return $default(_that.refreshToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RefreshRequest implements RefreshRequest {
  const _RefreshRequest({required this.refreshToken});
  factory _RefreshRequest.fromJson(Map<String, dynamic> json) => _$RefreshRequestFromJson(json);

@override final  String refreshToken;

/// Create a copy of RefreshRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefreshRequestCopyWith<_RefreshRequest> get copyWith => __$RefreshRequestCopyWithImpl<_RefreshRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RefreshRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshRequest&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,refreshToken);

@override
String toString() {
  return 'RefreshRequest(refreshToken: $refreshToken)';
}


}

/// @nodoc
abstract mixin class _$RefreshRequestCopyWith<$Res> implements $RefreshRequestCopyWith<$Res> {
  factory _$RefreshRequestCopyWith(_RefreshRequest value, $Res Function(_RefreshRequest) _then) = __$RefreshRequestCopyWithImpl;
@override @useResult
$Res call({
 String refreshToken
});




}
/// @nodoc
class __$RefreshRequestCopyWithImpl<$Res>
    implements _$RefreshRequestCopyWith<$Res> {
  __$RefreshRequestCopyWithImpl(this._self, this._then);

  final _RefreshRequest _self;
  final $Res Function(_RefreshRequest) _then;

/// Create a copy of RefreshRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? refreshToken = null,}) {
  return _then(_RefreshRequest(
refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ClaimRequest {

 String get name; PlayingRole get playingRole; ExperienceLevel get experienceLevel; BattingStyle get battingStyle; BowlingType get bowlingType; String? get city; int? get jerseyNumber;
/// Create a copy of ClaimRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClaimRequestCopyWith<ClaimRequest> get copyWith => _$ClaimRequestCopyWithImpl<ClaimRequest>(this as ClaimRequest, _$identity);

  /// Serializes this ClaimRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClaimRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.playingRole, playingRole) || other.playingRole == playingRole)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&(identical(other.battingStyle, battingStyle) || other.battingStyle == battingStyle)&&(identical(other.bowlingType, bowlingType) || other.bowlingType == bowlingType)&&(identical(other.city, city) || other.city == city)&&(identical(other.jerseyNumber, jerseyNumber) || other.jerseyNumber == jerseyNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,playingRole,experienceLevel,battingStyle,bowlingType,city,jerseyNumber);

@override
String toString() {
  return 'ClaimRequest(name: $name, playingRole: $playingRole, experienceLevel: $experienceLevel, battingStyle: $battingStyle, bowlingType: $bowlingType, city: $city, jerseyNumber: $jerseyNumber)';
}


}

/// @nodoc
abstract mixin class $ClaimRequestCopyWith<$Res>  {
  factory $ClaimRequestCopyWith(ClaimRequest value, $Res Function(ClaimRequest) _then) = _$ClaimRequestCopyWithImpl;
@useResult
$Res call({
 String name, PlayingRole playingRole, ExperienceLevel experienceLevel, BattingStyle battingStyle, BowlingType bowlingType, String? city, int? jerseyNumber
});




}
/// @nodoc
class _$ClaimRequestCopyWithImpl<$Res>
    implements $ClaimRequestCopyWith<$Res> {
  _$ClaimRequestCopyWithImpl(this._self, this._then);

  final ClaimRequest _self;
  final $Res Function(ClaimRequest) _then;

/// Create a copy of ClaimRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? playingRole = null,Object? experienceLevel = null,Object? battingStyle = null,Object? bowlingType = null,Object? city = freezed,Object? jerseyNumber = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,playingRole: null == playingRole ? _self.playingRole : playingRole // ignore: cast_nullable_to_non_nullable
as PlayingRole,experienceLevel: null == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as ExperienceLevel,battingStyle: null == battingStyle ? _self.battingStyle : battingStyle // ignore: cast_nullable_to_non_nullable
as BattingStyle,bowlingType: null == bowlingType ? _self.bowlingType : bowlingType // ignore: cast_nullable_to_non_nullable
as BowlingType,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,jerseyNumber: freezed == jerseyNumber ? _self.jerseyNumber : jerseyNumber // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClaimRequest].
extension ClaimRequestPatterns on ClaimRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClaimRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClaimRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClaimRequest value)  $default,){
final _that = this;
switch (_that) {
case _ClaimRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClaimRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ClaimRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  PlayingRole playingRole,  ExperienceLevel experienceLevel,  BattingStyle battingStyle,  BowlingType bowlingType,  String? city,  int? jerseyNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClaimRequest() when $default != null:
return $default(_that.name,_that.playingRole,_that.experienceLevel,_that.battingStyle,_that.bowlingType,_that.city,_that.jerseyNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  PlayingRole playingRole,  ExperienceLevel experienceLevel,  BattingStyle battingStyle,  BowlingType bowlingType,  String? city,  int? jerseyNumber)  $default,) {final _that = this;
switch (_that) {
case _ClaimRequest():
return $default(_that.name,_that.playingRole,_that.experienceLevel,_that.battingStyle,_that.bowlingType,_that.city,_that.jerseyNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  PlayingRole playingRole,  ExperienceLevel experienceLevel,  BattingStyle battingStyle,  BowlingType bowlingType,  String? city,  int? jerseyNumber)?  $default,) {final _that = this;
switch (_that) {
case _ClaimRequest() when $default != null:
return $default(_that.name,_that.playingRole,_that.experienceLevel,_that.battingStyle,_that.bowlingType,_that.city,_that.jerseyNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClaimRequest implements ClaimRequest {
  const _ClaimRequest({required this.name, required this.playingRole, required this.experienceLevel, required this.battingStyle, required this.bowlingType, this.city, this.jerseyNumber});
  factory _ClaimRequest.fromJson(Map<String, dynamic> json) => _$ClaimRequestFromJson(json);

@override final  String name;
@override final  PlayingRole playingRole;
@override final  ExperienceLevel experienceLevel;
@override final  BattingStyle battingStyle;
@override final  BowlingType bowlingType;
@override final  String? city;
@override final  int? jerseyNumber;

/// Create a copy of ClaimRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClaimRequestCopyWith<_ClaimRequest> get copyWith => __$ClaimRequestCopyWithImpl<_ClaimRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClaimRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClaimRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.playingRole, playingRole) || other.playingRole == playingRole)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&(identical(other.battingStyle, battingStyle) || other.battingStyle == battingStyle)&&(identical(other.bowlingType, bowlingType) || other.bowlingType == bowlingType)&&(identical(other.city, city) || other.city == city)&&(identical(other.jerseyNumber, jerseyNumber) || other.jerseyNumber == jerseyNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,playingRole,experienceLevel,battingStyle,bowlingType,city,jerseyNumber);

@override
String toString() {
  return 'ClaimRequest(name: $name, playingRole: $playingRole, experienceLevel: $experienceLevel, battingStyle: $battingStyle, bowlingType: $bowlingType, city: $city, jerseyNumber: $jerseyNumber)';
}


}

/// @nodoc
abstract mixin class _$ClaimRequestCopyWith<$Res> implements $ClaimRequestCopyWith<$Res> {
  factory _$ClaimRequestCopyWith(_ClaimRequest value, $Res Function(_ClaimRequest) _then) = __$ClaimRequestCopyWithImpl;
@override @useResult
$Res call({
 String name, PlayingRole playingRole, ExperienceLevel experienceLevel, BattingStyle battingStyle, BowlingType bowlingType, String? city, int? jerseyNumber
});




}
/// @nodoc
class __$ClaimRequestCopyWithImpl<$Res>
    implements _$ClaimRequestCopyWith<$Res> {
  __$ClaimRequestCopyWithImpl(this._self, this._then);

  final _ClaimRequest _self;
  final $Res Function(_ClaimRequest) _then;

/// Create a copy of ClaimRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? playingRole = null,Object? experienceLevel = null,Object? battingStyle = null,Object? bowlingType = null,Object? city = freezed,Object? jerseyNumber = freezed,}) {
  return _then(_ClaimRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,playingRole: null == playingRole ? _self.playingRole : playingRole // ignore: cast_nullable_to_non_nullable
as PlayingRole,experienceLevel: null == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as ExperienceLevel,battingStyle: null == battingStyle ? _self.battingStyle : battingStyle // ignore: cast_nullable_to_non_nullable
as BattingStyle,bowlingType: null == bowlingType ? _self.bowlingType : bowlingType // ignore: cast_nullable_to_non_nullable
as BowlingType,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,jerseyNumber: freezed == jerseyNumber ? _self.jerseyNumber : jerseyNumber // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$UserBasicInfoRequest {

 String? get name; String? get email;
/// Create a copy of UserBasicInfoRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserBasicInfoRequestCopyWith<UserBasicInfoRequest> get copyWith => _$UserBasicInfoRequestCopyWithImpl<UserBasicInfoRequest>(this as UserBasicInfoRequest, _$identity);

  /// Serializes this UserBasicInfoRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserBasicInfoRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,email);

@override
String toString() {
  return 'UserBasicInfoRequest(name: $name, email: $email)';
}


}

/// @nodoc
abstract mixin class $UserBasicInfoRequestCopyWith<$Res>  {
  factory $UserBasicInfoRequestCopyWith(UserBasicInfoRequest value, $Res Function(UserBasicInfoRequest) _then) = _$UserBasicInfoRequestCopyWithImpl;
@useResult
$Res call({
 String? name, String? email
});




}
/// @nodoc
class _$UserBasicInfoRequestCopyWithImpl<$Res>
    implements $UserBasicInfoRequestCopyWith<$Res> {
  _$UserBasicInfoRequestCopyWithImpl(this._self, this._then);

  final UserBasicInfoRequest _self;
  final $Res Function(UserBasicInfoRequest) _then;

/// Create a copy of UserBasicInfoRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? email = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserBasicInfoRequest].
extension UserBasicInfoRequestPatterns on UserBasicInfoRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserBasicInfoRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserBasicInfoRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserBasicInfoRequest value)  $default,){
final _that = this;
switch (_that) {
case _UserBasicInfoRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserBasicInfoRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UserBasicInfoRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String? email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserBasicInfoRequest() when $default != null:
return $default(_that.name,_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String? email)  $default,) {final _that = this;
switch (_that) {
case _UserBasicInfoRequest():
return $default(_that.name,_that.email);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String? email)?  $default,) {final _that = this;
switch (_that) {
case _UserBasicInfoRequest() when $default != null:
return $default(_that.name,_that.email);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserBasicInfoRequest implements UserBasicInfoRequest {
  const _UserBasicInfoRequest({this.name, this.email});
  factory _UserBasicInfoRequest.fromJson(Map<String, dynamic> json) => _$UserBasicInfoRequestFromJson(json);

@override final  String? name;
@override final  String? email;

/// Create a copy of UserBasicInfoRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserBasicInfoRequestCopyWith<_UserBasicInfoRequest> get copyWith => __$UserBasicInfoRequestCopyWithImpl<_UserBasicInfoRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserBasicInfoRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserBasicInfoRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,email);

@override
String toString() {
  return 'UserBasicInfoRequest(name: $name, email: $email)';
}


}

/// @nodoc
abstract mixin class _$UserBasicInfoRequestCopyWith<$Res> implements $UserBasicInfoRequestCopyWith<$Res> {
  factory _$UserBasicInfoRequestCopyWith(_UserBasicInfoRequest value, $Res Function(_UserBasicInfoRequest) _then) = __$UserBasicInfoRequestCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? email
});




}
/// @nodoc
class __$UserBasicInfoRequestCopyWithImpl<$Res>
    implements _$UserBasicInfoRequestCopyWith<$Res> {
  __$UserBasicInfoRequestCopyWithImpl(this._self, this._then);

  final _UserBasicInfoRequest _self;
  final $Res Function(_UserBasicInfoRequest) _then;

/// Create a copy of UserBasicInfoRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? email = freezed,}) {
  return _then(_UserBasicInfoRequest(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CricketProfileRequest {

 PlayingRole? get playingRole; BattingStyle? get battingStyle; BowlingStyle? get bowlingStyle; BowlingType? get bowlingType; ExperienceLevel? get experienceLevel; int? get jerseyNumber; String? get dateOfBirth;// YYYY-MM-DD
 String? get gender; String? get city; String? get state;
/// Create a copy of CricketProfileRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CricketProfileRequestCopyWith<CricketProfileRequest> get copyWith => _$CricketProfileRequestCopyWithImpl<CricketProfileRequest>(this as CricketProfileRequest, _$identity);

  /// Serializes this CricketProfileRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CricketProfileRequest&&(identical(other.playingRole, playingRole) || other.playingRole == playingRole)&&(identical(other.battingStyle, battingStyle) || other.battingStyle == battingStyle)&&(identical(other.bowlingStyle, bowlingStyle) || other.bowlingStyle == bowlingStyle)&&(identical(other.bowlingType, bowlingType) || other.bowlingType == bowlingType)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&(identical(other.jerseyNumber, jerseyNumber) || other.jerseyNumber == jerseyNumber)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playingRole,battingStyle,bowlingStyle,bowlingType,experienceLevel,jerseyNumber,dateOfBirth,gender,city,state);

@override
String toString() {
  return 'CricketProfileRequest(playingRole: $playingRole, battingStyle: $battingStyle, bowlingStyle: $bowlingStyle, bowlingType: $bowlingType, experienceLevel: $experienceLevel, jerseyNumber: $jerseyNumber, dateOfBirth: $dateOfBirth, gender: $gender, city: $city, state: $state)';
}


}

/// @nodoc
abstract mixin class $CricketProfileRequestCopyWith<$Res>  {
  factory $CricketProfileRequestCopyWith(CricketProfileRequest value, $Res Function(CricketProfileRequest) _then) = _$CricketProfileRequestCopyWithImpl;
@useResult
$Res call({
 PlayingRole? playingRole, BattingStyle? battingStyle, BowlingStyle? bowlingStyle, BowlingType? bowlingType, ExperienceLevel? experienceLevel, int? jerseyNumber, String? dateOfBirth, String? gender, String? city, String? state
});




}
/// @nodoc
class _$CricketProfileRequestCopyWithImpl<$Res>
    implements $CricketProfileRequestCopyWith<$Res> {
  _$CricketProfileRequestCopyWithImpl(this._self, this._then);

  final CricketProfileRequest _self;
  final $Res Function(CricketProfileRequest) _then;

/// Create a copy of CricketProfileRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playingRole = freezed,Object? battingStyle = freezed,Object? bowlingStyle = freezed,Object? bowlingType = freezed,Object? experienceLevel = freezed,Object? jerseyNumber = freezed,Object? dateOfBirth = freezed,Object? gender = freezed,Object? city = freezed,Object? state = freezed,}) {
  return _then(_self.copyWith(
playingRole: freezed == playingRole ? _self.playingRole : playingRole // ignore: cast_nullable_to_non_nullable
as PlayingRole?,battingStyle: freezed == battingStyle ? _self.battingStyle : battingStyle // ignore: cast_nullable_to_non_nullable
as BattingStyle?,bowlingStyle: freezed == bowlingStyle ? _self.bowlingStyle : bowlingStyle // ignore: cast_nullable_to_non_nullable
as BowlingStyle?,bowlingType: freezed == bowlingType ? _self.bowlingType : bowlingType // ignore: cast_nullable_to_non_nullable
as BowlingType?,experienceLevel: freezed == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as ExperienceLevel?,jerseyNumber: freezed == jerseyNumber ? _self.jerseyNumber : jerseyNumber // ignore: cast_nullable_to_non_nullable
as int?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CricketProfileRequest].
extension CricketProfileRequestPatterns on CricketProfileRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CricketProfileRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CricketProfileRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CricketProfileRequest value)  $default,){
final _that = this;
switch (_that) {
case _CricketProfileRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CricketProfileRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CricketProfileRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PlayingRole? playingRole,  BattingStyle? battingStyle,  BowlingStyle? bowlingStyle,  BowlingType? bowlingType,  ExperienceLevel? experienceLevel,  int? jerseyNumber,  String? dateOfBirth,  String? gender,  String? city,  String? state)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CricketProfileRequest() when $default != null:
return $default(_that.playingRole,_that.battingStyle,_that.bowlingStyle,_that.bowlingType,_that.experienceLevel,_that.jerseyNumber,_that.dateOfBirth,_that.gender,_that.city,_that.state);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PlayingRole? playingRole,  BattingStyle? battingStyle,  BowlingStyle? bowlingStyle,  BowlingType? bowlingType,  ExperienceLevel? experienceLevel,  int? jerseyNumber,  String? dateOfBirth,  String? gender,  String? city,  String? state)  $default,) {final _that = this;
switch (_that) {
case _CricketProfileRequest():
return $default(_that.playingRole,_that.battingStyle,_that.bowlingStyle,_that.bowlingType,_that.experienceLevel,_that.jerseyNumber,_that.dateOfBirth,_that.gender,_that.city,_that.state);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PlayingRole? playingRole,  BattingStyle? battingStyle,  BowlingStyle? bowlingStyle,  BowlingType? bowlingType,  ExperienceLevel? experienceLevel,  int? jerseyNumber,  String? dateOfBirth,  String? gender,  String? city,  String? state)?  $default,) {final _that = this;
switch (_that) {
case _CricketProfileRequest() when $default != null:
return $default(_that.playingRole,_that.battingStyle,_that.bowlingStyle,_that.bowlingType,_that.experienceLevel,_that.jerseyNumber,_that.dateOfBirth,_that.gender,_that.city,_that.state);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CricketProfileRequest implements CricketProfileRequest {
  const _CricketProfileRequest({this.playingRole, this.battingStyle, this.bowlingStyle, this.bowlingType, this.experienceLevel, this.jerseyNumber, this.dateOfBirth, this.gender, this.city, this.state});
  factory _CricketProfileRequest.fromJson(Map<String, dynamic> json) => _$CricketProfileRequestFromJson(json);

@override final  PlayingRole? playingRole;
@override final  BattingStyle? battingStyle;
@override final  BowlingStyle? bowlingStyle;
@override final  BowlingType? bowlingType;
@override final  ExperienceLevel? experienceLevel;
@override final  int? jerseyNumber;
@override final  String? dateOfBirth;
// YYYY-MM-DD
@override final  String? gender;
@override final  String? city;
@override final  String? state;

/// Create a copy of CricketProfileRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CricketProfileRequestCopyWith<_CricketProfileRequest> get copyWith => __$CricketProfileRequestCopyWithImpl<_CricketProfileRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CricketProfileRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CricketProfileRequest&&(identical(other.playingRole, playingRole) || other.playingRole == playingRole)&&(identical(other.battingStyle, battingStyle) || other.battingStyle == battingStyle)&&(identical(other.bowlingStyle, bowlingStyle) || other.bowlingStyle == bowlingStyle)&&(identical(other.bowlingType, bowlingType) || other.bowlingType == bowlingType)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&(identical(other.jerseyNumber, jerseyNumber) || other.jerseyNumber == jerseyNumber)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playingRole,battingStyle,bowlingStyle,bowlingType,experienceLevel,jerseyNumber,dateOfBirth,gender,city,state);

@override
String toString() {
  return 'CricketProfileRequest(playingRole: $playingRole, battingStyle: $battingStyle, bowlingStyle: $bowlingStyle, bowlingType: $bowlingType, experienceLevel: $experienceLevel, jerseyNumber: $jerseyNumber, dateOfBirth: $dateOfBirth, gender: $gender, city: $city, state: $state)';
}


}

/// @nodoc
abstract mixin class _$CricketProfileRequestCopyWith<$Res> implements $CricketProfileRequestCopyWith<$Res> {
  factory _$CricketProfileRequestCopyWith(_CricketProfileRequest value, $Res Function(_CricketProfileRequest) _then) = __$CricketProfileRequestCopyWithImpl;
@override @useResult
$Res call({
 PlayingRole? playingRole, BattingStyle? battingStyle, BowlingStyle? bowlingStyle, BowlingType? bowlingType, ExperienceLevel? experienceLevel, int? jerseyNumber, String? dateOfBirth, String? gender, String? city, String? state
});




}
/// @nodoc
class __$CricketProfileRequestCopyWithImpl<$Res>
    implements _$CricketProfileRequestCopyWith<$Res> {
  __$CricketProfileRequestCopyWithImpl(this._self, this._then);

  final _CricketProfileRequest _self;
  final $Res Function(_CricketProfileRequest) _then;

/// Create a copy of CricketProfileRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playingRole = freezed,Object? battingStyle = freezed,Object? bowlingStyle = freezed,Object? bowlingType = freezed,Object? experienceLevel = freezed,Object? jerseyNumber = freezed,Object? dateOfBirth = freezed,Object? gender = freezed,Object? city = freezed,Object? state = freezed,}) {
  return _then(_CricketProfileRequest(
playingRole: freezed == playingRole ? _self.playingRole : playingRole // ignore: cast_nullable_to_non_nullable
as PlayingRole?,battingStyle: freezed == battingStyle ? _self.battingStyle : battingStyle // ignore: cast_nullable_to_non_nullable
as BattingStyle?,bowlingStyle: freezed == bowlingStyle ? _self.bowlingStyle : bowlingStyle // ignore: cast_nullable_to_non_nullable
as BowlingStyle?,bowlingType: freezed == bowlingType ? _self.bowlingType : bowlingType // ignore: cast_nullable_to_non_nullable
as BowlingType?,experienceLevel: freezed == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as ExperienceLevel?,jerseyNumber: freezed == jerseyNumber ? _self.jerseyNumber : jerseyNumber // ignore: cast_nullable_to_non_nullable
as int?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
