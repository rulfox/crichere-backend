// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'franchise_squad.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuctionPlayerSummary {

 String get playerName; String? get playerCategory; int? get finalPrice; String? get assignmentType; int? get roundNumber;
/// Create a copy of AuctionPlayerSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuctionPlayerSummaryCopyWith<AuctionPlayerSummary> get copyWith => _$AuctionPlayerSummaryCopyWithImpl<AuctionPlayerSummary>(this as AuctionPlayerSummary, _$identity);

  /// Serializes this AuctionPlayerSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuctionPlayerSummary&&(identical(other.playerName, playerName) || other.playerName == playerName)&&(identical(other.playerCategory, playerCategory) || other.playerCategory == playerCategory)&&(identical(other.finalPrice, finalPrice) || other.finalPrice == finalPrice)&&(identical(other.assignmentType, assignmentType) || other.assignmentType == assignmentType)&&(identical(other.roundNumber, roundNumber) || other.roundNumber == roundNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerName,playerCategory,finalPrice,assignmentType,roundNumber);

@override
String toString() {
  return 'AuctionPlayerSummary(playerName: $playerName, playerCategory: $playerCategory, finalPrice: $finalPrice, assignmentType: $assignmentType, roundNumber: $roundNumber)';
}


}

/// @nodoc
abstract mixin class $AuctionPlayerSummaryCopyWith<$Res>  {
  factory $AuctionPlayerSummaryCopyWith(AuctionPlayerSummary value, $Res Function(AuctionPlayerSummary) _then) = _$AuctionPlayerSummaryCopyWithImpl;
@useResult
$Res call({
 String playerName, String? playerCategory, int? finalPrice, String? assignmentType, int? roundNumber
});




}
/// @nodoc
class _$AuctionPlayerSummaryCopyWithImpl<$Res>
    implements $AuctionPlayerSummaryCopyWith<$Res> {
  _$AuctionPlayerSummaryCopyWithImpl(this._self, this._then);

  final AuctionPlayerSummary _self;
  final $Res Function(AuctionPlayerSummary) _then;

/// Create a copy of AuctionPlayerSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerName = null,Object? playerCategory = freezed,Object? finalPrice = freezed,Object? assignmentType = freezed,Object? roundNumber = freezed,}) {
  return _then(_self.copyWith(
playerName: null == playerName ? _self.playerName : playerName // ignore: cast_nullable_to_non_nullable
as String,playerCategory: freezed == playerCategory ? _self.playerCategory : playerCategory // ignore: cast_nullable_to_non_nullable
as String?,finalPrice: freezed == finalPrice ? _self.finalPrice : finalPrice // ignore: cast_nullable_to_non_nullable
as int?,assignmentType: freezed == assignmentType ? _self.assignmentType : assignmentType // ignore: cast_nullable_to_non_nullable
as String?,roundNumber: freezed == roundNumber ? _self.roundNumber : roundNumber // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [AuctionPlayerSummary].
extension AuctionPlayerSummaryPatterns on AuctionPlayerSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuctionPlayerSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuctionPlayerSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuctionPlayerSummary value)  $default,){
final _that = this;
switch (_that) {
case _AuctionPlayerSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuctionPlayerSummary value)?  $default,){
final _that = this;
switch (_that) {
case _AuctionPlayerSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerName,  String? playerCategory,  int? finalPrice,  String? assignmentType,  int? roundNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuctionPlayerSummary() when $default != null:
return $default(_that.playerName,_that.playerCategory,_that.finalPrice,_that.assignmentType,_that.roundNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerName,  String? playerCategory,  int? finalPrice,  String? assignmentType,  int? roundNumber)  $default,) {final _that = this;
switch (_that) {
case _AuctionPlayerSummary():
return $default(_that.playerName,_that.playerCategory,_that.finalPrice,_that.assignmentType,_that.roundNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerName,  String? playerCategory,  int? finalPrice,  String? assignmentType,  int? roundNumber)?  $default,) {final _that = this;
switch (_that) {
case _AuctionPlayerSummary() when $default != null:
return $default(_that.playerName,_that.playerCategory,_that.finalPrice,_that.assignmentType,_that.roundNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuctionPlayerSummary implements AuctionPlayerSummary {
  const _AuctionPlayerSummary({required this.playerName, this.playerCategory, this.finalPrice, this.assignmentType, this.roundNumber});
  factory _AuctionPlayerSummary.fromJson(Map<String, dynamic> json) => _$AuctionPlayerSummaryFromJson(json);

@override final  String playerName;
@override final  String? playerCategory;
@override final  int? finalPrice;
@override final  String? assignmentType;
@override final  int? roundNumber;

/// Create a copy of AuctionPlayerSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuctionPlayerSummaryCopyWith<_AuctionPlayerSummary> get copyWith => __$AuctionPlayerSummaryCopyWithImpl<_AuctionPlayerSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuctionPlayerSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuctionPlayerSummary&&(identical(other.playerName, playerName) || other.playerName == playerName)&&(identical(other.playerCategory, playerCategory) || other.playerCategory == playerCategory)&&(identical(other.finalPrice, finalPrice) || other.finalPrice == finalPrice)&&(identical(other.assignmentType, assignmentType) || other.assignmentType == assignmentType)&&(identical(other.roundNumber, roundNumber) || other.roundNumber == roundNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerName,playerCategory,finalPrice,assignmentType,roundNumber);

@override
String toString() {
  return 'AuctionPlayerSummary(playerName: $playerName, playerCategory: $playerCategory, finalPrice: $finalPrice, assignmentType: $assignmentType, roundNumber: $roundNumber)';
}


}

/// @nodoc
abstract mixin class _$AuctionPlayerSummaryCopyWith<$Res> implements $AuctionPlayerSummaryCopyWith<$Res> {
  factory _$AuctionPlayerSummaryCopyWith(_AuctionPlayerSummary value, $Res Function(_AuctionPlayerSummary) _then) = __$AuctionPlayerSummaryCopyWithImpl;
@override @useResult
$Res call({
 String playerName, String? playerCategory, int? finalPrice, String? assignmentType, int? roundNumber
});




}
/// @nodoc
class __$AuctionPlayerSummaryCopyWithImpl<$Res>
    implements _$AuctionPlayerSummaryCopyWith<$Res> {
  __$AuctionPlayerSummaryCopyWithImpl(this._self, this._then);

  final _AuctionPlayerSummary _self;
  final $Res Function(_AuctionPlayerSummary) _then;

/// Create a copy of AuctionPlayerSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerName = null,Object? playerCategory = freezed,Object? finalPrice = freezed,Object? assignmentType = freezed,Object? roundNumber = freezed,}) {
  return _then(_AuctionPlayerSummary(
playerName: null == playerName ? _self.playerName : playerName // ignore: cast_nullable_to_non_nullable
as String,playerCategory: freezed == playerCategory ? _self.playerCategory : playerCategory // ignore: cast_nullable_to_non_nullable
as String?,finalPrice: freezed == finalPrice ? _self.finalPrice : finalPrice // ignore: cast_nullable_to_non_nullable
as int?,assignmentType: freezed == assignmentType ? _self.assignmentType : assignmentType // ignore: cast_nullable_to_non_nullable
as String?,roundNumber: freezed == roundNumber ? _self.roundNumber : roundNumber // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$FranchiseSquadResponse {

 String get franchiseId; String get franchiseName; List<AuctionPlayerSummary> get players;
/// Create a copy of FranchiseSquadResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FranchiseSquadResponseCopyWith<FranchiseSquadResponse> get copyWith => _$FranchiseSquadResponseCopyWithImpl<FranchiseSquadResponse>(this as FranchiseSquadResponse, _$identity);

  /// Serializes this FranchiseSquadResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FranchiseSquadResponse&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.franchiseName, franchiseName) || other.franchiseName == franchiseName)&&const DeepCollectionEquality().equals(other.players, players));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,franchiseId,franchiseName,const DeepCollectionEquality().hash(players));

@override
String toString() {
  return 'FranchiseSquadResponse(franchiseId: $franchiseId, franchiseName: $franchiseName, players: $players)';
}


}

/// @nodoc
abstract mixin class $FranchiseSquadResponseCopyWith<$Res>  {
  factory $FranchiseSquadResponseCopyWith(FranchiseSquadResponse value, $Res Function(FranchiseSquadResponse) _then) = _$FranchiseSquadResponseCopyWithImpl;
@useResult
$Res call({
 String franchiseId, String franchiseName, List<AuctionPlayerSummary> players
});




}
/// @nodoc
class _$FranchiseSquadResponseCopyWithImpl<$Res>
    implements $FranchiseSquadResponseCopyWith<$Res> {
  _$FranchiseSquadResponseCopyWithImpl(this._self, this._then);

  final FranchiseSquadResponse _self;
  final $Res Function(FranchiseSquadResponse) _then;

/// Create a copy of FranchiseSquadResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? franchiseId = null,Object? franchiseName = null,Object? players = null,}) {
  return _then(_self.copyWith(
franchiseId: null == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String,franchiseName: null == franchiseName ? _self.franchiseName : franchiseName // ignore: cast_nullable_to_non_nullable
as String,players: null == players ? _self.players : players // ignore: cast_nullable_to_non_nullable
as List<AuctionPlayerSummary>,
  ));
}

}


/// Adds pattern-matching-related methods to [FranchiseSquadResponse].
extension FranchiseSquadResponsePatterns on FranchiseSquadResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FranchiseSquadResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FranchiseSquadResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FranchiseSquadResponse value)  $default,){
final _that = this;
switch (_that) {
case _FranchiseSquadResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FranchiseSquadResponse value)?  $default,){
final _that = this;
switch (_that) {
case _FranchiseSquadResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String franchiseId,  String franchiseName,  List<AuctionPlayerSummary> players)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FranchiseSquadResponse() when $default != null:
return $default(_that.franchiseId,_that.franchiseName,_that.players);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String franchiseId,  String franchiseName,  List<AuctionPlayerSummary> players)  $default,) {final _that = this;
switch (_that) {
case _FranchiseSquadResponse():
return $default(_that.franchiseId,_that.franchiseName,_that.players);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String franchiseId,  String franchiseName,  List<AuctionPlayerSummary> players)?  $default,) {final _that = this;
switch (_that) {
case _FranchiseSquadResponse() when $default != null:
return $default(_that.franchiseId,_that.franchiseName,_that.players);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FranchiseSquadResponse implements FranchiseSquadResponse {
  const _FranchiseSquadResponse({required this.franchiseId, required this.franchiseName, required final  List<AuctionPlayerSummary> players}): _players = players;
  factory _FranchiseSquadResponse.fromJson(Map<String, dynamic> json) => _$FranchiseSquadResponseFromJson(json);

@override final  String franchiseId;
@override final  String franchiseName;
 final  List<AuctionPlayerSummary> _players;
@override List<AuctionPlayerSummary> get players {
  if (_players is EqualUnmodifiableListView) return _players;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_players);
}


/// Create a copy of FranchiseSquadResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FranchiseSquadResponseCopyWith<_FranchiseSquadResponse> get copyWith => __$FranchiseSquadResponseCopyWithImpl<_FranchiseSquadResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FranchiseSquadResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FranchiseSquadResponse&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.franchiseName, franchiseName) || other.franchiseName == franchiseName)&&const DeepCollectionEquality().equals(other._players, _players));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,franchiseId,franchiseName,const DeepCollectionEquality().hash(_players));

@override
String toString() {
  return 'FranchiseSquadResponse(franchiseId: $franchiseId, franchiseName: $franchiseName, players: $players)';
}


}

/// @nodoc
abstract mixin class _$FranchiseSquadResponseCopyWith<$Res> implements $FranchiseSquadResponseCopyWith<$Res> {
  factory _$FranchiseSquadResponseCopyWith(_FranchiseSquadResponse value, $Res Function(_FranchiseSquadResponse) _then) = __$FranchiseSquadResponseCopyWithImpl;
@override @useResult
$Res call({
 String franchiseId, String franchiseName, List<AuctionPlayerSummary> players
});




}
/// @nodoc
class __$FranchiseSquadResponseCopyWithImpl<$Res>
    implements _$FranchiseSquadResponseCopyWith<$Res> {
  __$FranchiseSquadResponseCopyWithImpl(this._self, this._then);

  final _FranchiseSquadResponse _self;
  final $Res Function(_FranchiseSquadResponse) _then;

/// Create a copy of FranchiseSquadResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? franchiseId = null,Object? franchiseName = null,Object? players = null,}) {
  return _then(_FranchiseSquadResponse(
franchiseId: null == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String,franchiseName: null == franchiseName ? _self.franchiseName : franchiseName // ignore: cast_nullable_to_non_nullable
as String,players: null == players ? _self._players : players // ignore: cast_nullable_to_non_nullable
as List<AuctionPlayerSummary>,
  ));
}


}

// dart format on
