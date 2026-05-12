// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auction_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuctionSummary {

 String get auctionId; String get leagueName; int get totalPlayersSold; int get totalAmountSpent; List<TopBuy> get topBuys; List<FranchiseResult> get franchiseResults; List<String> get unsoldPlayerIds; DateTime get completedAt;
/// Create a copy of AuctionSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuctionSummaryCopyWith<AuctionSummary> get copyWith => _$AuctionSummaryCopyWithImpl<AuctionSummary>(this as AuctionSummary, _$identity);

  /// Serializes this AuctionSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuctionSummary&&(identical(other.auctionId, auctionId) || other.auctionId == auctionId)&&(identical(other.leagueName, leagueName) || other.leagueName == leagueName)&&(identical(other.totalPlayersSold, totalPlayersSold) || other.totalPlayersSold == totalPlayersSold)&&(identical(other.totalAmountSpent, totalAmountSpent) || other.totalAmountSpent == totalAmountSpent)&&const DeepCollectionEquality().equals(other.topBuys, topBuys)&&const DeepCollectionEquality().equals(other.franchiseResults, franchiseResults)&&const DeepCollectionEquality().equals(other.unsoldPlayerIds, unsoldPlayerIds)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,auctionId,leagueName,totalPlayersSold,totalAmountSpent,const DeepCollectionEquality().hash(topBuys),const DeepCollectionEquality().hash(franchiseResults),const DeepCollectionEquality().hash(unsoldPlayerIds),completedAt);

@override
String toString() {
  return 'AuctionSummary(auctionId: $auctionId, leagueName: $leagueName, totalPlayersSold: $totalPlayersSold, totalAmountSpent: $totalAmountSpent, topBuys: $topBuys, franchiseResults: $franchiseResults, unsoldPlayerIds: $unsoldPlayerIds, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $AuctionSummaryCopyWith<$Res>  {
  factory $AuctionSummaryCopyWith(AuctionSummary value, $Res Function(AuctionSummary) _then) = _$AuctionSummaryCopyWithImpl;
@useResult
$Res call({
 String auctionId, String leagueName, int totalPlayersSold, int totalAmountSpent, List<TopBuy> topBuys, List<FranchiseResult> franchiseResults, List<String> unsoldPlayerIds, DateTime completedAt
});




}
/// @nodoc
class _$AuctionSummaryCopyWithImpl<$Res>
    implements $AuctionSummaryCopyWith<$Res> {
  _$AuctionSummaryCopyWithImpl(this._self, this._then);

  final AuctionSummary _self;
  final $Res Function(AuctionSummary) _then;

/// Create a copy of AuctionSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? auctionId = null,Object? leagueName = null,Object? totalPlayersSold = null,Object? totalAmountSpent = null,Object? topBuys = null,Object? franchiseResults = null,Object? unsoldPlayerIds = null,Object? completedAt = null,}) {
  return _then(_self.copyWith(
auctionId: null == auctionId ? _self.auctionId : auctionId // ignore: cast_nullable_to_non_nullable
as String,leagueName: null == leagueName ? _self.leagueName : leagueName // ignore: cast_nullable_to_non_nullable
as String,totalPlayersSold: null == totalPlayersSold ? _self.totalPlayersSold : totalPlayersSold // ignore: cast_nullable_to_non_nullable
as int,totalAmountSpent: null == totalAmountSpent ? _self.totalAmountSpent : totalAmountSpent // ignore: cast_nullable_to_non_nullable
as int,topBuys: null == topBuys ? _self.topBuys : topBuys // ignore: cast_nullable_to_non_nullable
as List<TopBuy>,franchiseResults: null == franchiseResults ? _self.franchiseResults : franchiseResults // ignore: cast_nullable_to_non_nullable
as List<FranchiseResult>,unsoldPlayerIds: null == unsoldPlayerIds ? _self.unsoldPlayerIds : unsoldPlayerIds // ignore: cast_nullable_to_non_nullable
as List<String>,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AuctionSummary].
extension AuctionSummaryPatterns on AuctionSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuctionSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuctionSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuctionSummary value)  $default,){
final _that = this;
switch (_that) {
case _AuctionSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuctionSummary value)?  $default,){
final _that = this;
switch (_that) {
case _AuctionSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String auctionId,  String leagueName,  int totalPlayersSold,  int totalAmountSpent,  List<TopBuy> topBuys,  List<FranchiseResult> franchiseResults,  List<String> unsoldPlayerIds,  DateTime completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuctionSummary() when $default != null:
return $default(_that.auctionId,_that.leagueName,_that.totalPlayersSold,_that.totalAmountSpent,_that.topBuys,_that.franchiseResults,_that.unsoldPlayerIds,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String auctionId,  String leagueName,  int totalPlayersSold,  int totalAmountSpent,  List<TopBuy> topBuys,  List<FranchiseResult> franchiseResults,  List<String> unsoldPlayerIds,  DateTime completedAt)  $default,) {final _that = this;
switch (_that) {
case _AuctionSummary():
return $default(_that.auctionId,_that.leagueName,_that.totalPlayersSold,_that.totalAmountSpent,_that.topBuys,_that.franchiseResults,_that.unsoldPlayerIds,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String auctionId,  String leagueName,  int totalPlayersSold,  int totalAmountSpent,  List<TopBuy> topBuys,  List<FranchiseResult> franchiseResults,  List<String> unsoldPlayerIds,  DateTime completedAt)?  $default,) {final _that = this;
switch (_that) {
case _AuctionSummary() when $default != null:
return $default(_that.auctionId,_that.leagueName,_that.totalPlayersSold,_that.totalAmountSpent,_that.topBuys,_that.franchiseResults,_that.unsoldPlayerIds,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuctionSummary implements AuctionSummary {
  const _AuctionSummary({required this.auctionId, required this.leagueName, required this.totalPlayersSold, required this.totalAmountSpent, required final  List<TopBuy> topBuys, required final  List<FranchiseResult> franchiseResults, required final  List<String> unsoldPlayerIds, required this.completedAt}): _topBuys = topBuys,_franchiseResults = franchiseResults,_unsoldPlayerIds = unsoldPlayerIds;
  factory _AuctionSummary.fromJson(Map<String, dynamic> json) => _$AuctionSummaryFromJson(json);

@override final  String auctionId;
@override final  String leagueName;
@override final  int totalPlayersSold;
@override final  int totalAmountSpent;
 final  List<TopBuy> _topBuys;
@override List<TopBuy> get topBuys {
  if (_topBuys is EqualUnmodifiableListView) return _topBuys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topBuys);
}

 final  List<FranchiseResult> _franchiseResults;
@override List<FranchiseResult> get franchiseResults {
  if (_franchiseResults is EqualUnmodifiableListView) return _franchiseResults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_franchiseResults);
}

 final  List<String> _unsoldPlayerIds;
@override List<String> get unsoldPlayerIds {
  if (_unsoldPlayerIds is EqualUnmodifiableListView) return _unsoldPlayerIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_unsoldPlayerIds);
}

@override final  DateTime completedAt;

/// Create a copy of AuctionSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuctionSummaryCopyWith<_AuctionSummary> get copyWith => __$AuctionSummaryCopyWithImpl<_AuctionSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuctionSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuctionSummary&&(identical(other.auctionId, auctionId) || other.auctionId == auctionId)&&(identical(other.leagueName, leagueName) || other.leagueName == leagueName)&&(identical(other.totalPlayersSold, totalPlayersSold) || other.totalPlayersSold == totalPlayersSold)&&(identical(other.totalAmountSpent, totalAmountSpent) || other.totalAmountSpent == totalAmountSpent)&&const DeepCollectionEquality().equals(other._topBuys, _topBuys)&&const DeepCollectionEquality().equals(other._franchiseResults, _franchiseResults)&&const DeepCollectionEquality().equals(other._unsoldPlayerIds, _unsoldPlayerIds)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,auctionId,leagueName,totalPlayersSold,totalAmountSpent,const DeepCollectionEquality().hash(_topBuys),const DeepCollectionEquality().hash(_franchiseResults),const DeepCollectionEquality().hash(_unsoldPlayerIds),completedAt);

@override
String toString() {
  return 'AuctionSummary(auctionId: $auctionId, leagueName: $leagueName, totalPlayersSold: $totalPlayersSold, totalAmountSpent: $totalAmountSpent, topBuys: $topBuys, franchiseResults: $franchiseResults, unsoldPlayerIds: $unsoldPlayerIds, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$AuctionSummaryCopyWith<$Res> implements $AuctionSummaryCopyWith<$Res> {
  factory _$AuctionSummaryCopyWith(_AuctionSummary value, $Res Function(_AuctionSummary) _then) = __$AuctionSummaryCopyWithImpl;
@override @useResult
$Res call({
 String auctionId, String leagueName, int totalPlayersSold, int totalAmountSpent, List<TopBuy> topBuys, List<FranchiseResult> franchiseResults, List<String> unsoldPlayerIds, DateTime completedAt
});




}
/// @nodoc
class __$AuctionSummaryCopyWithImpl<$Res>
    implements _$AuctionSummaryCopyWith<$Res> {
  __$AuctionSummaryCopyWithImpl(this._self, this._then);

  final _AuctionSummary _self;
  final $Res Function(_AuctionSummary) _then;

/// Create a copy of AuctionSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? auctionId = null,Object? leagueName = null,Object? totalPlayersSold = null,Object? totalAmountSpent = null,Object? topBuys = null,Object? franchiseResults = null,Object? unsoldPlayerIds = null,Object? completedAt = null,}) {
  return _then(_AuctionSummary(
auctionId: null == auctionId ? _self.auctionId : auctionId // ignore: cast_nullable_to_non_nullable
as String,leagueName: null == leagueName ? _self.leagueName : leagueName // ignore: cast_nullable_to_non_nullable
as String,totalPlayersSold: null == totalPlayersSold ? _self.totalPlayersSold : totalPlayersSold // ignore: cast_nullable_to_non_nullable
as int,totalAmountSpent: null == totalAmountSpent ? _self.totalAmountSpent : totalAmountSpent // ignore: cast_nullable_to_non_nullable
as int,topBuys: null == topBuys ? _self._topBuys : topBuys // ignore: cast_nullable_to_non_nullable
as List<TopBuy>,franchiseResults: null == franchiseResults ? _self._franchiseResults : franchiseResults // ignore: cast_nullable_to_non_nullable
as List<FranchiseResult>,unsoldPlayerIds: null == unsoldPlayerIds ? _self._unsoldPlayerIds : unsoldPlayerIds // ignore: cast_nullable_to_non_nullable
as List<String>,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$TopBuy {

 String get playerName; String get franchiseName; int get amount;
/// Create a copy of TopBuy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TopBuyCopyWith<TopBuy> get copyWith => _$TopBuyCopyWithImpl<TopBuy>(this as TopBuy, _$identity);

  /// Serializes this TopBuy to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TopBuy&&(identical(other.playerName, playerName) || other.playerName == playerName)&&(identical(other.franchiseName, franchiseName) || other.franchiseName == franchiseName)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerName,franchiseName,amount);

@override
String toString() {
  return 'TopBuy(playerName: $playerName, franchiseName: $franchiseName, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $TopBuyCopyWith<$Res>  {
  factory $TopBuyCopyWith(TopBuy value, $Res Function(TopBuy) _then) = _$TopBuyCopyWithImpl;
@useResult
$Res call({
 String playerName, String franchiseName, int amount
});




}
/// @nodoc
class _$TopBuyCopyWithImpl<$Res>
    implements $TopBuyCopyWith<$Res> {
  _$TopBuyCopyWithImpl(this._self, this._then);

  final TopBuy _self;
  final $Res Function(TopBuy) _then;

/// Create a copy of TopBuy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerName = null,Object? franchiseName = null,Object? amount = null,}) {
  return _then(_self.copyWith(
playerName: null == playerName ? _self.playerName : playerName // ignore: cast_nullable_to_non_nullable
as String,franchiseName: null == franchiseName ? _self.franchiseName : franchiseName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TopBuy].
extension TopBuyPatterns on TopBuy {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TopBuy value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TopBuy() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TopBuy value)  $default,){
final _that = this;
switch (_that) {
case _TopBuy():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TopBuy value)?  $default,){
final _that = this;
switch (_that) {
case _TopBuy() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerName,  String franchiseName,  int amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TopBuy() when $default != null:
return $default(_that.playerName,_that.franchiseName,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerName,  String franchiseName,  int amount)  $default,) {final _that = this;
switch (_that) {
case _TopBuy():
return $default(_that.playerName,_that.franchiseName,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerName,  String franchiseName,  int amount)?  $default,) {final _that = this;
switch (_that) {
case _TopBuy() when $default != null:
return $default(_that.playerName,_that.franchiseName,_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TopBuy implements TopBuy {
  const _TopBuy({required this.playerName, required this.franchiseName, required this.amount});
  factory _TopBuy.fromJson(Map<String, dynamic> json) => _$TopBuyFromJson(json);

@override final  String playerName;
@override final  String franchiseName;
@override final  int amount;

/// Create a copy of TopBuy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TopBuyCopyWith<_TopBuy> get copyWith => __$TopBuyCopyWithImpl<_TopBuy>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TopBuyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TopBuy&&(identical(other.playerName, playerName) || other.playerName == playerName)&&(identical(other.franchiseName, franchiseName) || other.franchiseName == franchiseName)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerName,franchiseName,amount);

@override
String toString() {
  return 'TopBuy(playerName: $playerName, franchiseName: $franchiseName, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$TopBuyCopyWith<$Res> implements $TopBuyCopyWith<$Res> {
  factory _$TopBuyCopyWith(_TopBuy value, $Res Function(_TopBuy) _then) = __$TopBuyCopyWithImpl;
@override @useResult
$Res call({
 String playerName, String franchiseName, int amount
});




}
/// @nodoc
class __$TopBuyCopyWithImpl<$Res>
    implements _$TopBuyCopyWith<$Res> {
  __$TopBuyCopyWithImpl(this._self, this._then);

  final _TopBuy _self;
  final $Res Function(_TopBuy) _then;

/// Create a copy of TopBuy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerName = null,Object? franchiseName = null,Object? amount = null,}) {
  return _then(_TopBuy(
playerName: null == playerName ? _self.playerName : playerName // ignore: cast_nullable_to_non_nullable
as String,franchiseName: null == franchiseName ? _self.franchiseName : franchiseName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$FranchiseResult {

 String get franchiseId; String get franchiseName; int get totalSpent; int get playersCount; int get remainingPurse;
/// Create a copy of FranchiseResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FranchiseResultCopyWith<FranchiseResult> get copyWith => _$FranchiseResultCopyWithImpl<FranchiseResult>(this as FranchiseResult, _$identity);

  /// Serializes this FranchiseResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FranchiseResult&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.franchiseName, franchiseName) || other.franchiseName == franchiseName)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent)&&(identical(other.playersCount, playersCount) || other.playersCount == playersCount)&&(identical(other.remainingPurse, remainingPurse) || other.remainingPurse == remainingPurse));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,franchiseId,franchiseName,totalSpent,playersCount,remainingPurse);

@override
String toString() {
  return 'FranchiseResult(franchiseId: $franchiseId, franchiseName: $franchiseName, totalSpent: $totalSpent, playersCount: $playersCount, remainingPurse: $remainingPurse)';
}


}

/// @nodoc
abstract mixin class $FranchiseResultCopyWith<$Res>  {
  factory $FranchiseResultCopyWith(FranchiseResult value, $Res Function(FranchiseResult) _then) = _$FranchiseResultCopyWithImpl;
@useResult
$Res call({
 String franchiseId, String franchiseName, int totalSpent, int playersCount, int remainingPurse
});




}
/// @nodoc
class _$FranchiseResultCopyWithImpl<$Res>
    implements $FranchiseResultCopyWith<$Res> {
  _$FranchiseResultCopyWithImpl(this._self, this._then);

  final FranchiseResult _self;
  final $Res Function(FranchiseResult) _then;

/// Create a copy of FranchiseResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? franchiseId = null,Object? franchiseName = null,Object? totalSpent = null,Object? playersCount = null,Object? remainingPurse = null,}) {
  return _then(_self.copyWith(
franchiseId: null == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String,franchiseName: null == franchiseName ? _self.franchiseName : franchiseName // ignore: cast_nullable_to_non_nullable
as String,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as int,playersCount: null == playersCount ? _self.playersCount : playersCount // ignore: cast_nullable_to_non_nullable
as int,remainingPurse: null == remainingPurse ? _self.remainingPurse : remainingPurse // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FranchiseResult].
extension FranchiseResultPatterns on FranchiseResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FranchiseResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FranchiseResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FranchiseResult value)  $default,){
final _that = this;
switch (_that) {
case _FranchiseResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FranchiseResult value)?  $default,){
final _that = this;
switch (_that) {
case _FranchiseResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String franchiseId,  String franchiseName,  int totalSpent,  int playersCount,  int remainingPurse)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FranchiseResult() when $default != null:
return $default(_that.franchiseId,_that.franchiseName,_that.totalSpent,_that.playersCount,_that.remainingPurse);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String franchiseId,  String franchiseName,  int totalSpent,  int playersCount,  int remainingPurse)  $default,) {final _that = this;
switch (_that) {
case _FranchiseResult():
return $default(_that.franchiseId,_that.franchiseName,_that.totalSpent,_that.playersCount,_that.remainingPurse);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String franchiseId,  String franchiseName,  int totalSpent,  int playersCount,  int remainingPurse)?  $default,) {final _that = this;
switch (_that) {
case _FranchiseResult() when $default != null:
return $default(_that.franchiseId,_that.franchiseName,_that.totalSpent,_that.playersCount,_that.remainingPurse);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FranchiseResult implements FranchiseResult {
  const _FranchiseResult({required this.franchiseId, required this.franchiseName, required this.totalSpent, required this.playersCount, required this.remainingPurse});
  factory _FranchiseResult.fromJson(Map<String, dynamic> json) => _$FranchiseResultFromJson(json);

@override final  String franchiseId;
@override final  String franchiseName;
@override final  int totalSpent;
@override final  int playersCount;
@override final  int remainingPurse;

/// Create a copy of FranchiseResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FranchiseResultCopyWith<_FranchiseResult> get copyWith => __$FranchiseResultCopyWithImpl<_FranchiseResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FranchiseResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FranchiseResult&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.franchiseName, franchiseName) || other.franchiseName == franchiseName)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent)&&(identical(other.playersCount, playersCount) || other.playersCount == playersCount)&&(identical(other.remainingPurse, remainingPurse) || other.remainingPurse == remainingPurse));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,franchiseId,franchiseName,totalSpent,playersCount,remainingPurse);

@override
String toString() {
  return 'FranchiseResult(franchiseId: $franchiseId, franchiseName: $franchiseName, totalSpent: $totalSpent, playersCount: $playersCount, remainingPurse: $remainingPurse)';
}


}

/// @nodoc
abstract mixin class _$FranchiseResultCopyWith<$Res> implements $FranchiseResultCopyWith<$Res> {
  factory _$FranchiseResultCopyWith(_FranchiseResult value, $Res Function(_FranchiseResult) _then) = __$FranchiseResultCopyWithImpl;
@override @useResult
$Res call({
 String franchiseId, String franchiseName, int totalSpent, int playersCount, int remainingPurse
});




}
/// @nodoc
class __$FranchiseResultCopyWithImpl<$Res>
    implements _$FranchiseResultCopyWith<$Res> {
  __$FranchiseResultCopyWithImpl(this._self, this._then);

  final _FranchiseResult _self;
  final $Res Function(_FranchiseResult) _then;

/// Create a copy of FranchiseResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? franchiseId = null,Object? franchiseName = null,Object? totalSpent = null,Object? playersCount = null,Object? remainingPurse = null,}) {
  return _then(_FranchiseResult(
franchiseId: null == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String,franchiseName: null == franchiseName ? _self.franchiseName : franchiseName // ignore: cast_nullable_to_non_nullable
as String,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as int,playersCount: null == playersCount ? _self.playersCount : playersCount // ignore: cast_nullable_to_non_nullable
as int,remainingPurse: null == remainingPurse ? _self.remainingPurse : remainingPurse // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
