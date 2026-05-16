// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fee_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeeObligation {

 String get id; String get leagueId; String get userId; String? get franchiseId; String get feeType; int get totalAmount; int? get minimumToRegister; int get paidAmount; String get status; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of FeeObligation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeeObligationCopyWith<FeeObligation> get copyWith => _$FeeObligationCopyWithImpl<FeeObligation>(this as FeeObligation, _$identity);

  /// Serializes this FeeObligation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeeObligation&&(identical(other.id, id) || other.id == id)&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.feeType, feeType) || other.feeType == feeType)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.minimumToRegister, minimumToRegister) || other.minimumToRegister == minimumToRegister)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,leagueId,userId,franchiseId,feeType,totalAmount,minimumToRegister,paidAmount,status,createdAt,updatedAt);

@override
String toString() {
  return 'FeeObligation(id: $id, leagueId: $leagueId, userId: $userId, franchiseId: $franchiseId, feeType: $feeType, totalAmount: $totalAmount, minimumToRegister: $minimumToRegister, paidAmount: $paidAmount, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $FeeObligationCopyWith<$Res>  {
  factory $FeeObligationCopyWith(FeeObligation value, $Res Function(FeeObligation) _then) = _$FeeObligationCopyWithImpl;
@useResult
$Res call({
 String id, String leagueId, String userId, String? franchiseId, String feeType, int totalAmount, int? minimumToRegister, int paidAmount, String status, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$FeeObligationCopyWithImpl<$Res>
    implements $FeeObligationCopyWith<$Res> {
  _$FeeObligationCopyWithImpl(this._self, this._then);

  final FeeObligation _self;
  final $Res Function(FeeObligation) _then;

/// Create a copy of FeeObligation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? leagueId = null,Object? userId = null,Object? franchiseId = freezed,Object? feeType = null,Object? totalAmount = null,Object? minimumToRegister = freezed,Object? paidAmount = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,franchiseId: freezed == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String?,feeType: null == feeType ? _self.feeType : feeType // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,minimumToRegister: freezed == minimumToRegister ? _self.minimumToRegister : minimumToRegister // ignore: cast_nullable_to_non_nullable
as int?,paidAmount: null == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FeeObligation].
extension FeeObligationPatterns on FeeObligation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeeObligation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeeObligation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeeObligation value)  $default,){
final _that = this;
switch (_that) {
case _FeeObligation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeeObligation value)?  $default,){
final _that = this;
switch (_that) {
case _FeeObligation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String leagueId,  String userId,  String? franchiseId,  String feeType,  int totalAmount,  int? minimumToRegister,  int paidAmount,  String status,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeeObligation() when $default != null:
return $default(_that.id,_that.leagueId,_that.userId,_that.franchiseId,_that.feeType,_that.totalAmount,_that.minimumToRegister,_that.paidAmount,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String leagueId,  String userId,  String? franchiseId,  String feeType,  int totalAmount,  int? minimumToRegister,  int paidAmount,  String status,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _FeeObligation():
return $default(_that.id,_that.leagueId,_that.userId,_that.franchiseId,_that.feeType,_that.totalAmount,_that.minimumToRegister,_that.paidAmount,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String leagueId,  String userId,  String? franchiseId,  String feeType,  int totalAmount,  int? minimumToRegister,  int paidAmount,  String status,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _FeeObligation() when $default != null:
return $default(_that.id,_that.leagueId,_that.userId,_that.franchiseId,_that.feeType,_that.totalAmount,_that.minimumToRegister,_that.paidAmount,_that.status,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeeObligation implements FeeObligation {
  const _FeeObligation({required this.id, required this.leagueId, required this.userId, this.franchiseId, required this.feeType, required this.totalAmount, this.minimumToRegister, required this.paidAmount, required this.status, required this.createdAt, required this.updatedAt});
  factory _FeeObligation.fromJson(Map<String, dynamic> json) => _$FeeObligationFromJson(json);

@override final  String id;
@override final  String leagueId;
@override final  String userId;
@override final  String? franchiseId;
@override final  String feeType;
@override final  int totalAmount;
@override final  int? minimumToRegister;
@override final  int paidAmount;
@override final  String status;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of FeeObligation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeeObligationCopyWith<_FeeObligation> get copyWith => __$FeeObligationCopyWithImpl<_FeeObligation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeeObligationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeeObligation&&(identical(other.id, id) || other.id == id)&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.feeType, feeType) || other.feeType == feeType)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.minimumToRegister, minimumToRegister) || other.minimumToRegister == minimumToRegister)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,leagueId,userId,franchiseId,feeType,totalAmount,minimumToRegister,paidAmount,status,createdAt,updatedAt);

@override
String toString() {
  return 'FeeObligation(id: $id, leagueId: $leagueId, userId: $userId, franchiseId: $franchiseId, feeType: $feeType, totalAmount: $totalAmount, minimumToRegister: $minimumToRegister, paidAmount: $paidAmount, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$FeeObligationCopyWith<$Res> implements $FeeObligationCopyWith<$Res> {
  factory _$FeeObligationCopyWith(_FeeObligation value, $Res Function(_FeeObligation) _then) = __$FeeObligationCopyWithImpl;
@override @useResult
$Res call({
 String id, String leagueId, String userId, String? franchiseId, String feeType, int totalAmount, int? minimumToRegister, int paidAmount, String status, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$FeeObligationCopyWithImpl<$Res>
    implements _$FeeObligationCopyWith<$Res> {
  __$FeeObligationCopyWithImpl(this._self, this._then);

  final _FeeObligation _self;
  final $Res Function(_FeeObligation) _then;

/// Create a copy of FeeObligation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? leagueId = null,Object? userId = null,Object? franchiseId = freezed,Object? feeType = null,Object? totalAmount = null,Object? minimumToRegister = freezed,Object? paidAmount = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_FeeObligation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,franchiseId: freezed == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String?,feeType: null == feeType ? _self.feeType : feeType // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,minimumToRegister: freezed == minimumToRegister ? _self.minimumToRegister : minimumToRegister // ignore: cast_nullable_to_non_nullable
as int?,paidAmount: null == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$FeeObligationDetail {

 FeeObligation get obligation; List<FeePayment> get payments;
/// Create a copy of FeeObligationDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeeObligationDetailCopyWith<FeeObligationDetail> get copyWith => _$FeeObligationDetailCopyWithImpl<FeeObligationDetail>(this as FeeObligationDetail, _$identity);

  /// Serializes this FeeObligationDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeeObligationDetail&&(identical(other.obligation, obligation) || other.obligation == obligation)&&const DeepCollectionEquality().equals(other.payments, payments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,obligation,const DeepCollectionEquality().hash(payments));

@override
String toString() {
  return 'FeeObligationDetail(obligation: $obligation, payments: $payments)';
}


}

/// @nodoc
abstract mixin class $FeeObligationDetailCopyWith<$Res>  {
  factory $FeeObligationDetailCopyWith(FeeObligationDetail value, $Res Function(FeeObligationDetail) _then) = _$FeeObligationDetailCopyWithImpl;
@useResult
$Res call({
 FeeObligation obligation, List<FeePayment> payments
});


$FeeObligationCopyWith<$Res> get obligation;

}
/// @nodoc
class _$FeeObligationDetailCopyWithImpl<$Res>
    implements $FeeObligationDetailCopyWith<$Res> {
  _$FeeObligationDetailCopyWithImpl(this._self, this._then);

  final FeeObligationDetail _self;
  final $Res Function(FeeObligationDetail) _then;

/// Create a copy of FeeObligationDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? obligation = null,Object? payments = null,}) {
  return _then(_self.copyWith(
obligation: null == obligation ? _self.obligation : obligation // ignore: cast_nullable_to_non_nullable
as FeeObligation,payments: null == payments ? _self.payments : payments // ignore: cast_nullable_to_non_nullable
as List<FeePayment>,
  ));
}
/// Create a copy of FeeObligationDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeeObligationCopyWith<$Res> get obligation {
  
  return $FeeObligationCopyWith<$Res>(_self.obligation, (value) {
    return _then(_self.copyWith(obligation: value));
  });
}
}


/// Adds pattern-matching-related methods to [FeeObligationDetail].
extension FeeObligationDetailPatterns on FeeObligationDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeeObligationDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeeObligationDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeeObligationDetail value)  $default,){
final _that = this;
switch (_that) {
case _FeeObligationDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeeObligationDetail value)?  $default,){
final _that = this;
switch (_that) {
case _FeeObligationDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FeeObligation obligation,  List<FeePayment> payments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeeObligationDetail() when $default != null:
return $default(_that.obligation,_that.payments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FeeObligation obligation,  List<FeePayment> payments)  $default,) {final _that = this;
switch (_that) {
case _FeeObligationDetail():
return $default(_that.obligation,_that.payments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FeeObligation obligation,  List<FeePayment> payments)?  $default,) {final _that = this;
switch (_that) {
case _FeeObligationDetail() when $default != null:
return $default(_that.obligation,_that.payments);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeeObligationDetail implements FeeObligationDetail {
  const _FeeObligationDetail({required this.obligation, required final  List<FeePayment> payments}): _payments = payments;
  factory _FeeObligationDetail.fromJson(Map<String, dynamic> json) => _$FeeObligationDetailFromJson(json);

@override final  FeeObligation obligation;
 final  List<FeePayment> _payments;
@override List<FeePayment> get payments {
  if (_payments is EqualUnmodifiableListView) return _payments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_payments);
}


/// Create a copy of FeeObligationDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeeObligationDetailCopyWith<_FeeObligationDetail> get copyWith => __$FeeObligationDetailCopyWithImpl<_FeeObligationDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeeObligationDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeeObligationDetail&&(identical(other.obligation, obligation) || other.obligation == obligation)&&const DeepCollectionEquality().equals(other._payments, _payments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,obligation,const DeepCollectionEquality().hash(_payments));

@override
String toString() {
  return 'FeeObligationDetail(obligation: $obligation, payments: $payments)';
}


}

/// @nodoc
abstract mixin class _$FeeObligationDetailCopyWith<$Res> implements $FeeObligationDetailCopyWith<$Res> {
  factory _$FeeObligationDetailCopyWith(_FeeObligationDetail value, $Res Function(_FeeObligationDetail) _then) = __$FeeObligationDetailCopyWithImpl;
@override @useResult
$Res call({
 FeeObligation obligation, List<FeePayment> payments
});


@override $FeeObligationCopyWith<$Res> get obligation;

}
/// @nodoc
class __$FeeObligationDetailCopyWithImpl<$Res>
    implements _$FeeObligationDetailCopyWith<$Res> {
  __$FeeObligationDetailCopyWithImpl(this._self, this._then);

  final _FeeObligationDetail _self;
  final $Res Function(_FeeObligationDetail) _then;

/// Create a copy of FeeObligationDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? obligation = null,Object? payments = null,}) {
  return _then(_FeeObligationDetail(
obligation: null == obligation ? _self.obligation : obligation // ignore: cast_nullable_to_non_nullable
as FeeObligation,payments: null == payments ? _self._payments : payments // ignore: cast_nullable_to_non_nullable
as List<FeePayment>,
  ));
}

/// Create a copy of FeeObligationDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeeObligationCopyWith<$Res> get obligation {
  
  return $FeeObligationCopyWith<$Res>(_self.obligation, (value) {
    return _then(_self.copyWith(obligation: value));
  });
}
}


/// @nodoc
mixin _$FeeObligationListResponse {

 List<FeeObligationDetail> get obligations; int get totalElements; int get totalPages; int get pageNumber; int get pageSize;
/// Create a copy of FeeObligationListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeeObligationListResponseCopyWith<FeeObligationListResponse> get copyWith => _$FeeObligationListResponseCopyWithImpl<FeeObligationListResponse>(this as FeeObligationListResponse, _$identity);

  /// Serializes this FeeObligationListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeeObligationListResponse&&const DeepCollectionEquality().equals(other.obligations, obligations)&&(identical(other.totalElements, totalElements) || other.totalElements == totalElements)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(obligations),totalElements,totalPages,pageNumber,pageSize);

@override
String toString() {
  return 'FeeObligationListResponse(obligations: $obligations, totalElements: $totalElements, totalPages: $totalPages, pageNumber: $pageNumber, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class $FeeObligationListResponseCopyWith<$Res>  {
  factory $FeeObligationListResponseCopyWith(FeeObligationListResponse value, $Res Function(FeeObligationListResponse) _then) = _$FeeObligationListResponseCopyWithImpl;
@useResult
$Res call({
 List<FeeObligationDetail> obligations, int totalElements, int totalPages, int pageNumber, int pageSize
});




}
/// @nodoc
class _$FeeObligationListResponseCopyWithImpl<$Res>
    implements $FeeObligationListResponseCopyWith<$Res> {
  _$FeeObligationListResponseCopyWithImpl(this._self, this._then);

  final FeeObligationListResponse _self;
  final $Res Function(FeeObligationListResponse) _then;

/// Create a copy of FeeObligationListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? obligations = null,Object? totalElements = null,Object? totalPages = null,Object? pageNumber = null,Object? pageSize = null,}) {
  return _then(_self.copyWith(
obligations: null == obligations ? _self.obligations : obligations // ignore: cast_nullable_to_non_nullable
as List<FeeObligationDetail>,totalElements: null == totalElements ? _self.totalElements : totalElements // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FeeObligationListResponse].
extension FeeObligationListResponsePatterns on FeeObligationListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeeObligationListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeeObligationListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeeObligationListResponse value)  $default,){
final _that = this;
switch (_that) {
case _FeeObligationListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeeObligationListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _FeeObligationListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<FeeObligationDetail> obligations,  int totalElements,  int totalPages,  int pageNumber,  int pageSize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeeObligationListResponse() when $default != null:
return $default(_that.obligations,_that.totalElements,_that.totalPages,_that.pageNumber,_that.pageSize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<FeeObligationDetail> obligations,  int totalElements,  int totalPages,  int pageNumber,  int pageSize)  $default,) {final _that = this;
switch (_that) {
case _FeeObligationListResponse():
return $default(_that.obligations,_that.totalElements,_that.totalPages,_that.pageNumber,_that.pageSize);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<FeeObligationDetail> obligations,  int totalElements,  int totalPages,  int pageNumber,  int pageSize)?  $default,) {final _that = this;
switch (_that) {
case _FeeObligationListResponse() when $default != null:
return $default(_that.obligations,_that.totalElements,_that.totalPages,_that.pageNumber,_that.pageSize);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeeObligationListResponse implements FeeObligationListResponse {
  const _FeeObligationListResponse({required final  List<FeeObligationDetail> obligations, required this.totalElements, required this.totalPages, required this.pageNumber, required this.pageSize}): _obligations = obligations;
  factory _FeeObligationListResponse.fromJson(Map<String, dynamic> json) => _$FeeObligationListResponseFromJson(json);

 final  List<FeeObligationDetail> _obligations;
@override List<FeeObligationDetail> get obligations {
  if (_obligations is EqualUnmodifiableListView) return _obligations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_obligations);
}

@override final  int totalElements;
@override final  int totalPages;
@override final  int pageNumber;
@override final  int pageSize;

/// Create a copy of FeeObligationListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeeObligationListResponseCopyWith<_FeeObligationListResponse> get copyWith => __$FeeObligationListResponseCopyWithImpl<_FeeObligationListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeeObligationListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeeObligationListResponse&&const DeepCollectionEquality().equals(other._obligations, _obligations)&&(identical(other.totalElements, totalElements) || other.totalElements == totalElements)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_obligations),totalElements,totalPages,pageNumber,pageSize);

@override
String toString() {
  return 'FeeObligationListResponse(obligations: $obligations, totalElements: $totalElements, totalPages: $totalPages, pageNumber: $pageNumber, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class _$FeeObligationListResponseCopyWith<$Res> implements $FeeObligationListResponseCopyWith<$Res> {
  factory _$FeeObligationListResponseCopyWith(_FeeObligationListResponse value, $Res Function(_FeeObligationListResponse) _then) = __$FeeObligationListResponseCopyWithImpl;
@override @useResult
$Res call({
 List<FeeObligationDetail> obligations, int totalElements, int totalPages, int pageNumber, int pageSize
});




}
/// @nodoc
class __$FeeObligationListResponseCopyWithImpl<$Res>
    implements _$FeeObligationListResponseCopyWith<$Res> {
  __$FeeObligationListResponseCopyWithImpl(this._self, this._then);

  final _FeeObligationListResponse _self;
  final $Res Function(_FeeObligationListResponse) _then;

/// Create a copy of FeeObligationListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? obligations = null,Object? totalElements = null,Object? totalPages = null,Object? pageNumber = null,Object? pageSize = null,}) {
  return _then(_FeeObligationListResponse(
obligations: null == obligations ? _self._obligations : obligations // ignore: cast_nullable_to_non_nullable
as List<FeeObligationDetail>,totalElements: null == totalElements ? _self.totalElements : totalElements // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$FeePayment {

 String get id; String get obligationId; int get amount; String get paymentMode;// CASH, ONLINE
 DateTime get paidAt; String? get notes;
/// Create a copy of FeePayment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeePaymentCopyWith<FeePayment> get copyWith => _$FeePaymentCopyWithImpl<FeePayment>(this as FeePayment, _$identity);

  /// Serializes this FeePayment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeePayment&&(identical(other.id, id) || other.id == id)&&(identical(other.obligationId, obligationId) || other.obligationId == obligationId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paymentMode, paymentMode) || other.paymentMode == paymentMode)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,obligationId,amount,paymentMode,paidAt,notes);

@override
String toString() {
  return 'FeePayment(id: $id, obligationId: $obligationId, amount: $amount, paymentMode: $paymentMode, paidAt: $paidAt, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $FeePaymentCopyWith<$Res>  {
  factory $FeePaymentCopyWith(FeePayment value, $Res Function(FeePayment) _then) = _$FeePaymentCopyWithImpl;
@useResult
$Res call({
 String id, String obligationId, int amount, String paymentMode, DateTime paidAt, String? notes
});




}
/// @nodoc
class _$FeePaymentCopyWithImpl<$Res>
    implements $FeePaymentCopyWith<$Res> {
  _$FeePaymentCopyWithImpl(this._self, this._then);

  final FeePayment _self;
  final $Res Function(FeePayment) _then;

/// Create a copy of FeePayment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? obligationId = null,Object? amount = null,Object? paymentMode = null,Object? paidAt = null,Object? notes = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,obligationId: null == obligationId ? _self.obligationId : obligationId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,paymentMode: null == paymentMode ? _self.paymentMode : paymentMode // ignore: cast_nullable_to_non_nullable
as String,paidAt: null == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeePayment].
extension FeePaymentPatterns on FeePayment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeePayment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeePayment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeePayment value)  $default,){
final _that = this;
switch (_that) {
case _FeePayment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeePayment value)?  $default,){
final _that = this;
switch (_that) {
case _FeePayment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String obligationId,  int amount,  String paymentMode,  DateTime paidAt,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeePayment() when $default != null:
return $default(_that.id,_that.obligationId,_that.amount,_that.paymentMode,_that.paidAt,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String obligationId,  int amount,  String paymentMode,  DateTime paidAt,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _FeePayment():
return $default(_that.id,_that.obligationId,_that.amount,_that.paymentMode,_that.paidAt,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String obligationId,  int amount,  String paymentMode,  DateTime paidAt,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _FeePayment() when $default != null:
return $default(_that.id,_that.obligationId,_that.amount,_that.paymentMode,_that.paidAt,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeePayment implements FeePayment {
  const _FeePayment({required this.id, required this.obligationId, required this.amount, required this.paymentMode, required this.paidAt, this.notes});
  factory _FeePayment.fromJson(Map<String, dynamic> json) => _$FeePaymentFromJson(json);

@override final  String id;
@override final  String obligationId;
@override final  int amount;
@override final  String paymentMode;
// CASH, ONLINE
@override final  DateTime paidAt;
@override final  String? notes;

/// Create a copy of FeePayment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeePaymentCopyWith<_FeePayment> get copyWith => __$FeePaymentCopyWithImpl<_FeePayment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeePaymentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeePayment&&(identical(other.id, id) || other.id == id)&&(identical(other.obligationId, obligationId) || other.obligationId == obligationId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paymentMode, paymentMode) || other.paymentMode == paymentMode)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,obligationId,amount,paymentMode,paidAt,notes);

@override
String toString() {
  return 'FeePayment(id: $id, obligationId: $obligationId, amount: $amount, paymentMode: $paymentMode, paidAt: $paidAt, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$FeePaymentCopyWith<$Res> implements $FeePaymentCopyWith<$Res> {
  factory _$FeePaymentCopyWith(_FeePayment value, $Res Function(_FeePayment) _then) = __$FeePaymentCopyWithImpl;
@override @useResult
$Res call({
 String id, String obligationId, int amount, String paymentMode, DateTime paidAt, String? notes
});




}
/// @nodoc
class __$FeePaymentCopyWithImpl<$Res>
    implements _$FeePaymentCopyWith<$Res> {
  __$FeePaymentCopyWithImpl(this._self, this._then);

  final _FeePayment _self;
  final $Res Function(_FeePayment) _then;

/// Create a copy of FeePayment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? obligationId = null,Object? amount = null,Object? paymentMode = null,Object? paidAt = null,Object? notes = freezed,}) {
  return _then(_FeePayment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,obligationId: null == obligationId ? _self.obligationId : obligationId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,paymentMode: null == paymentMode ? _self.paymentMode : paymentMode // ignore: cast_nullable_to_non_nullable
as String,paidAt: null == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
