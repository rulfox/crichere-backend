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

 String get id; String get leagueId; String get entityId;// PlayerId or FranchiseId
 String get entityName; String get feeType;// PLAYER_FEE, FRANCHISE_FEE
 int get totalAmount; int get paidAmount; String get status;// UNPAID, PARTIALLY_PAID, PAID, WAIVED
 bool get auctionEligible;
/// Create a copy of FeeObligation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeeObligationCopyWith<FeeObligation> get copyWith => _$FeeObligationCopyWithImpl<FeeObligation>(this as FeeObligation, _$identity);

  /// Serializes this FeeObligation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeeObligation&&(identical(other.id, id) || other.id == id)&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.entityName, entityName) || other.entityName == entityName)&&(identical(other.feeType, feeType) || other.feeType == feeType)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.auctionEligible, auctionEligible) || other.auctionEligible == auctionEligible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,leagueId,entityId,entityName,feeType,totalAmount,paidAmount,status,auctionEligible);

@override
String toString() {
  return 'FeeObligation(id: $id, leagueId: $leagueId, entityId: $entityId, entityName: $entityName, feeType: $feeType, totalAmount: $totalAmount, paidAmount: $paidAmount, status: $status, auctionEligible: $auctionEligible)';
}


}

/// @nodoc
abstract mixin class $FeeObligationCopyWith<$Res>  {
  factory $FeeObligationCopyWith(FeeObligation value, $Res Function(FeeObligation) _then) = _$FeeObligationCopyWithImpl;
@useResult
$Res call({
 String id, String leagueId, String entityId, String entityName, String feeType, int totalAmount, int paidAmount, String status, bool auctionEligible
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? leagueId = null,Object? entityId = null,Object? entityName = null,Object? feeType = null,Object? totalAmount = null,Object? paidAmount = null,Object? status = null,Object? auctionEligible = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,entityName: null == entityName ? _self.entityName : entityName // ignore: cast_nullable_to_non_nullable
as String,feeType: null == feeType ? _self.feeType : feeType // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,paidAmount: null == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,auctionEligible: null == auctionEligible ? _self.auctionEligible : auctionEligible // ignore: cast_nullable_to_non_nullable
as bool,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String leagueId,  String entityId,  String entityName,  String feeType,  int totalAmount,  int paidAmount,  String status,  bool auctionEligible)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeeObligation() when $default != null:
return $default(_that.id,_that.leagueId,_that.entityId,_that.entityName,_that.feeType,_that.totalAmount,_that.paidAmount,_that.status,_that.auctionEligible);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String leagueId,  String entityId,  String entityName,  String feeType,  int totalAmount,  int paidAmount,  String status,  bool auctionEligible)  $default,) {final _that = this;
switch (_that) {
case _FeeObligation():
return $default(_that.id,_that.leagueId,_that.entityId,_that.entityName,_that.feeType,_that.totalAmount,_that.paidAmount,_that.status,_that.auctionEligible);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String leagueId,  String entityId,  String entityName,  String feeType,  int totalAmount,  int paidAmount,  String status,  bool auctionEligible)?  $default,) {final _that = this;
switch (_that) {
case _FeeObligation() when $default != null:
return $default(_that.id,_that.leagueId,_that.entityId,_that.entityName,_that.feeType,_that.totalAmount,_that.paidAmount,_that.status,_that.auctionEligible);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeeObligation implements FeeObligation {
  const _FeeObligation({required this.id, required this.leagueId, required this.entityId, required this.entityName, required this.feeType, required this.totalAmount, required this.paidAmount, required this.status, required this.auctionEligible});
  factory _FeeObligation.fromJson(Map<String, dynamic> json) => _$FeeObligationFromJson(json);

@override final  String id;
@override final  String leagueId;
@override final  String entityId;
// PlayerId or FranchiseId
@override final  String entityName;
@override final  String feeType;
// PLAYER_FEE, FRANCHISE_FEE
@override final  int totalAmount;
@override final  int paidAmount;
@override final  String status;
// UNPAID, PARTIALLY_PAID, PAID, WAIVED
@override final  bool auctionEligible;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeeObligation&&(identical(other.id, id) || other.id == id)&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.entityName, entityName) || other.entityName == entityName)&&(identical(other.feeType, feeType) || other.feeType == feeType)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.auctionEligible, auctionEligible) || other.auctionEligible == auctionEligible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,leagueId,entityId,entityName,feeType,totalAmount,paidAmount,status,auctionEligible);

@override
String toString() {
  return 'FeeObligation(id: $id, leagueId: $leagueId, entityId: $entityId, entityName: $entityName, feeType: $feeType, totalAmount: $totalAmount, paidAmount: $paidAmount, status: $status, auctionEligible: $auctionEligible)';
}


}

/// @nodoc
abstract mixin class _$FeeObligationCopyWith<$Res> implements $FeeObligationCopyWith<$Res> {
  factory _$FeeObligationCopyWith(_FeeObligation value, $Res Function(_FeeObligation) _then) = __$FeeObligationCopyWithImpl;
@override @useResult
$Res call({
 String id, String leagueId, String entityId, String entityName, String feeType, int totalAmount, int paidAmount, String status, bool auctionEligible
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? leagueId = null,Object? entityId = null,Object? entityName = null,Object? feeType = null,Object? totalAmount = null,Object? paidAmount = null,Object? status = null,Object? auctionEligible = null,}) {
  return _then(_FeeObligation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,entityName: null == entityName ? _self.entityName : entityName // ignore: cast_nullable_to_non_nullable
as String,feeType: null == feeType ? _self.feeType : feeType // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,paidAmount: null == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,auctionEligible: null == auctionEligible ? _self.auctionEligible : auctionEligible // ignore: cast_nullable_to_non_nullable
as bool,
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
