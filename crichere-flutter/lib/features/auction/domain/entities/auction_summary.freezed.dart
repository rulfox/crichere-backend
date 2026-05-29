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

 String get auctionId; String get leagueId; String get leagueName;@JsonKey(unknownEnumValue: AuctionStatus.unknown) AuctionStatus? get status; DateTime? get startedAt; DateTime? get completedAt; int get totalPlayers; int get totalSold; int get totalUnsold; int get totalWithdrawn;// Backend serializes this as Long; read as int.
 int get totalSpent; TopBuy? get highestSale; List<FranchiseResult> get franchiseSummaries;
/// Create a copy of AuctionSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuctionSummaryCopyWith<AuctionSummary> get copyWith => _$AuctionSummaryCopyWithImpl<AuctionSummary>(this as AuctionSummary, _$identity);

  /// Serializes this AuctionSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuctionSummary&&(identical(other.auctionId, auctionId) || other.auctionId == auctionId)&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.leagueName, leagueName) || other.leagueName == leagueName)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.totalPlayers, totalPlayers) || other.totalPlayers == totalPlayers)&&(identical(other.totalSold, totalSold) || other.totalSold == totalSold)&&(identical(other.totalUnsold, totalUnsold) || other.totalUnsold == totalUnsold)&&(identical(other.totalWithdrawn, totalWithdrawn) || other.totalWithdrawn == totalWithdrawn)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent)&&(identical(other.highestSale, highestSale) || other.highestSale == highestSale)&&const DeepCollectionEquality().equals(other.franchiseSummaries, franchiseSummaries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,auctionId,leagueId,leagueName,status,startedAt,completedAt,totalPlayers,totalSold,totalUnsold,totalWithdrawn,totalSpent,highestSale,const DeepCollectionEquality().hash(franchiseSummaries));

@override
String toString() {
  return 'AuctionSummary(auctionId: $auctionId, leagueId: $leagueId, leagueName: $leagueName, status: $status, startedAt: $startedAt, completedAt: $completedAt, totalPlayers: $totalPlayers, totalSold: $totalSold, totalUnsold: $totalUnsold, totalWithdrawn: $totalWithdrawn, totalSpent: $totalSpent, highestSale: $highestSale, franchiseSummaries: $franchiseSummaries)';
}


}

/// @nodoc
abstract mixin class $AuctionSummaryCopyWith<$Res>  {
  factory $AuctionSummaryCopyWith(AuctionSummary value, $Res Function(AuctionSummary) _then) = _$AuctionSummaryCopyWithImpl;
@useResult
$Res call({
 String auctionId, String leagueId, String leagueName,@JsonKey(unknownEnumValue: AuctionStatus.unknown) AuctionStatus? status, DateTime? startedAt, DateTime? completedAt, int totalPlayers, int totalSold, int totalUnsold, int totalWithdrawn, int totalSpent, TopBuy? highestSale, List<FranchiseResult> franchiseSummaries
});


$TopBuyCopyWith<$Res>? get highestSale;

}
/// @nodoc
class _$AuctionSummaryCopyWithImpl<$Res>
    implements $AuctionSummaryCopyWith<$Res> {
  _$AuctionSummaryCopyWithImpl(this._self, this._then);

  final AuctionSummary _self;
  final $Res Function(AuctionSummary) _then;

/// Create a copy of AuctionSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? auctionId = null,Object? leagueId = null,Object? leagueName = null,Object? status = freezed,Object? startedAt = freezed,Object? completedAt = freezed,Object? totalPlayers = null,Object? totalSold = null,Object? totalUnsold = null,Object? totalWithdrawn = null,Object? totalSpent = null,Object? highestSale = freezed,Object? franchiseSummaries = null,}) {
  return _then(_self.copyWith(
auctionId: null == auctionId ? _self.auctionId : auctionId // ignore: cast_nullable_to_non_nullable
as String,leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,leagueName: null == leagueName ? _self.leagueName : leagueName // ignore: cast_nullable_to_non_nullable
as String,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuctionStatus?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,totalPlayers: null == totalPlayers ? _self.totalPlayers : totalPlayers // ignore: cast_nullable_to_non_nullable
as int,totalSold: null == totalSold ? _self.totalSold : totalSold // ignore: cast_nullable_to_non_nullable
as int,totalUnsold: null == totalUnsold ? _self.totalUnsold : totalUnsold // ignore: cast_nullable_to_non_nullable
as int,totalWithdrawn: null == totalWithdrawn ? _self.totalWithdrawn : totalWithdrawn // ignore: cast_nullable_to_non_nullable
as int,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as int,highestSale: freezed == highestSale ? _self.highestSale : highestSale // ignore: cast_nullable_to_non_nullable
as TopBuy?,franchiseSummaries: null == franchiseSummaries ? _self.franchiseSummaries : franchiseSummaries // ignore: cast_nullable_to_non_nullable
as List<FranchiseResult>,
  ));
}
/// Create a copy of AuctionSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TopBuyCopyWith<$Res>? get highestSale {
    if (_self.highestSale == null) {
    return null;
  }

  return $TopBuyCopyWith<$Res>(_self.highestSale!, (value) {
    return _then(_self.copyWith(highestSale: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String auctionId,  String leagueId,  String leagueName, @JsonKey(unknownEnumValue: AuctionStatus.unknown)  AuctionStatus? status,  DateTime? startedAt,  DateTime? completedAt,  int totalPlayers,  int totalSold,  int totalUnsold,  int totalWithdrawn,  int totalSpent,  TopBuy? highestSale,  List<FranchiseResult> franchiseSummaries)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuctionSummary() when $default != null:
return $default(_that.auctionId,_that.leagueId,_that.leagueName,_that.status,_that.startedAt,_that.completedAt,_that.totalPlayers,_that.totalSold,_that.totalUnsold,_that.totalWithdrawn,_that.totalSpent,_that.highestSale,_that.franchiseSummaries);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String auctionId,  String leagueId,  String leagueName, @JsonKey(unknownEnumValue: AuctionStatus.unknown)  AuctionStatus? status,  DateTime? startedAt,  DateTime? completedAt,  int totalPlayers,  int totalSold,  int totalUnsold,  int totalWithdrawn,  int totalSpent,  TopBuy? highestSale,  List<FranchiseResult> franchiseSummaries)  $default,) {final _that = this;
switch (_that) {
case _AuctionSummary():
return $default(_that.auctionId,_that.leagueId,_that.leagueName,_that.status,_that.startedAt,_that.completedAt,_that.totalPlayers,_that.totalSold,_that.totalUnsold,_that.totalWithdrawn,_that.totalSpent,_that.highestSale,_that.franchiseSummaries);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String auctionId,  String leagueId,  String leagueName, @JsonKey(unknownEnumValue: AuctionStatus.unknown)  AuctionStatus? status,  DateTime? startedAt,  DateTime? completedAt,  int totalPlayers,  int totalSold,  int totalUnsold,  int totalWithdrawn,  int totalSpent,  TopBuy? highestSale,  List<FranchiseResult> franchiseSummaries)?  $default,) {final _that = this;
switch (_that) {
case _AuctionSummary() when $default != null:
return $default(_that.auctionId,_that.leagueId,_that.leagueName,_that.status,_that.startedAt,_that.completedAt,_that.totalPlayers,_that.totalSold,_that.totalUnsold,_that.totalWithdrawn,_that.totalSpent,_that.highestSale,_that.franchiseSummaries);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuctionSummary implements AuctionSummary {
  const _AuctionSummary({required this.auctionId, required this.leagueId, required this.leagueName, @JsonKey(unknownEnumValue: AuctionStatus.unknown) this.status, this.startedAt, this.completedAt, this.totalPlayers = 0, this.totalSold = 0, this.totalUnsold = 0, this.totalWithdrawn = 0, this.totalSpent = 0, this.highestSale, final  List<FranchiseResult> franchiseSummaries = const <FranchiseResult>[]}): _franchiseSummaries = franchiseSummaries;
  factory _AuctionSummary.fromJson(Map<String, dynamic> json) => _$AuctionSummaryFromJson(json);

@override final  String auctionId;
@override final  String leagueId;
@override final  String leagueName;
@override@JsonKey(unknownEnumValue: AuctionStatus.unknown) final  AuctionStatus? status;
@override final  DateTime? startedAt;
@override final  DateTime? completedAt;
@override@JsonKey() final  int totalPlayers;
@override@JsonKey() final  int totalSold;
@override@JsonKey() final  int totalUnsold;
@override@JsonKey() final  int totalWithdrawn;
// Backend serializes this as Long; read as int.
@override@JsonKey() final  int totalSpent;
@override final  TopBuy? highestSale;
 final  List<FranchiseResult> _franchiseSummaries;
@override@JsonKey() List<FranchiseResult> get franchiseSummaries {
  if (_franchiseSummaries is EqualUnmodifiableListView) return _franchiseSummaries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_franchiseSummaries);
}


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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuctionSummary&&(identical(other.auctionId, auctionId) || other.auctionId == auctionId)&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.leagueName, leagueName) || other.leagueName == leagueName)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.totalPlayers, totalPlayers) || other.totalPlayers == totalPlayers)&&(identical(other.totalSold, totalSold) || other.totalSold == totalSold)&&(identical(other.totalUnsold, totalUnsold) || other.totalUnsold == totalUnsold)&&(identical(other.totalWithdrawn, totalWithdrawn) || other.totalWithdrawn == totalWithdrawn)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent)&&(identical(other.highestSale, highestSale) || other.highestSale == highestSale)&&const DeepCollectionEquality().equals(other._franchiseSummaries, _franchiseSummaries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,auctionId,leagueId,leagueName,status,startedAt,completedAt,totalPlayers,totalSold,totalUnsold,totalWithdrawn,totalSpent,highestSale,const DeepCollectionEquality().hash(_franchiseSummaries));

@override
String toString() {
  return 'AuctionSummary(auctionId: $auctionId, leagueId: $leagueId, leagueName: $leagueName, status: $status, startedAt: $startedAt, completedAt: $completedAt, totalPlayers: $totalPlayers, totalSold: $totalSold, totalUnsold: $totalUnsold, totalWithdrawn: $totalWithdrawn, totalSpent: $totalSpent, highestSale: $highestSale, franchiseSummaries: $franchiseSummaries)';
}


}

/// @nodoc
abstract mixin class _$AuctionSummaryCopyWith<$Res> implements $AuctionSummaryCopyWith<$Res> {
  factory _$AuctionSummaryCopyWith(_AuctionSummary value, $Res Function(_AuctionSummary) _then) = __$AuctionSummaryCopyWithImpl;
@override @useResult
$Res call({
 String auctionId, String leagueId, String leagueName,@JsonKey(unknownEnumValue: AuctionStatus.unknown) AuctionStatus? status, DateTime? startedAt, DateTime? completedAt, int totalPlayers, int totalSold, int totalUnsold, int totalWithdrawn, int totalSpent, TopBuy? highestSale, List<FranchiseResult> franchiseSummaries
});


@override $TopBuyCopyWith<$Res>? get highestSale;

}
/// @nodoc
class __$AuctionSummaryCopyWithImpl<$Res>
    implements _$AuctionSummaryCopyWith<$Res> {
  __$AuctionSummaryCopyWithImpl(this._self, this._then);

  final _AuctionSummary _self;
  final $Res Function(_AuctionSummary) _then;

/// Create a copy of AuctionSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? auctionId = null,Object? leagueId = null,Object? leagueName = null,Object? status = freezed,Object? startedAt = freezed,Object? completedAt = freezed,Object? totalPlayers = null,Object? totalSold = null,Object? totalUnsold = null,Object? totalWithdrawn = null,Object? totalSpent = null,Object? highestSale = freezed,Object? franchiseSummaries = null,}) {
  return _then(_AuctionSummary(
auctionId: null == auctionId ? _self.auctionId : auctionId // ignore: cast_nullable_to_non_nullable
as String,leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,leagueName: null == leagueName ? _self.leagueName : leagueName // ignore: cast_nullable_to_non_nullable
as String,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuctionStatus?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,totalPlayers: null == totalPlayers ? _self.totalPlayers : totalPlayers // ignore: cast_nullable_to_non_nullable
as int,totalSold: null == totalSold ? _self.totalSold : totalSold // ignore: cast_nullable_to_non_nullable
as int,totalUnsold: null == totalUnsold ? _self.totalUnsold : totalUnsold // ignore: cast_nullable_to_non_nullable
as int,totalWithdrawn: null == totalWithdrawn ? _self.totalWithdrawn : totalWithdrawn // ignore: cast_nullable_to_non_nullable
as int,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as int,highestSale: freezed == highestSale ? _self.highestSale : highestSale // ignore: cast_nullable_to_non_nullable
as TopBuy?,franchiseSummaries: null == franchiseSummaries ? _self._franchiseSummaries : franchiseSummaries // ignore: cast_nullable_to_non_nullable
as List<FranchiseResult>,
  ));
}

/// Create a copy of AuctionSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TopBuyCopyWith<$Res>? get highestSale {
    if (_self.highestSale == null) {
    return null;
  }

  return $TopBuyCopyWith<$Res>(_self.highestSale!, (value) {
    return _then(_self.copyWith(highestSale: value));
  });
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
mixin _$AuctionPlayerSummary {

 String get playerName; String? get playerCategory; String? get playerTag; int? get finalPrice; String? get assignmentType; int? get roundNumber;
/// Create a copy of AuctionPlayerSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuctionPlayerSummaryCopyWith<AuctionPlayerSummary> get copyWith => _$AuctionPlayerSummaryCopyWithImpl<AuctionPlayerSummary>(this as AuctionPlayerSummary, _$identity);

  /// Serializes this AuctionPlayerSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuctionPlayerSummary&&(identical(other.playerName, playerName) || other.playerName == playerName)&&(identical(other.playerCategory, playerCategory) || other.playerCategory == playerCategory)&&(identical(other.playerTag, playerTag) || other.playerTag == playerTag)&&(identical(other.finalPrice, finalPrice) || other.finalPrice == finalPrice)&&(identical(other.assignmentType, assignmentType) || other.assignmentType == assignmentType)&&(identical(other.roundNumber, roundNumber) || other.roundNumber == roundNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerName,playerCategory,playerTag,finalPrice,assignmentType,roundNumber);

@override
String toString() {
  return 'AuctionPlayerSummary(playerName: $playerName, playerCategory: $playerCategory, playerTag: $playerTag, finalPrice: $finalPrice, assignmentType: $assignmentType, roundNumber: $roundNumber)';
}


}

/// @nodoc
abstract mixin class $AuctionPlayerSummaryCopyWith<$Res>  {
  factory $AuctionPlayerSummaryCopyWith(AuctionPlayerSummary value, $Res Function(AuctionPlayerSummary) _then) = _$AuctionPlayerSummaryCopyWithImpl;
@useResult
$Res call({
 String playerName, String? playerCategory, String? playerTag, int? finalPrice, String? assignmentType, int? roundNumber
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
@pragma('vm:prefer-inline') @override $Res call({Object? playerName = null,Object? playerCategory = freezed,Object? playerTag = freezed,Object? finalPrice = freezed,Object? assignmentType = freezed,Object? roundNumber = freezed,}) {
  return _then(_self.copyWith(
playerName: null == playerName ? _self.playerName : playerName // ignore: cast_nullable_to_non_nullable
as String,playerCategory: freezed == playerCategory ? _self.playerCategory : playerCategory // ignore: cast_nullable_to_non_nullable
as String?,playerTag: freezed == playerTag ? _self.playerTag : playerTag // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerName,  String? playerCategory,  String? playerTag,  int? finalPrice,  String? assignmentType,  int? roundNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuctionPlayerSummary() when $default != null:
return $default(_that.playerName,_that.playerCategory,_that.playerTag,_that.finalPrice,_that.assignmentType,_that.roundNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerName,  String? playerCategory,  String? playerTag,  int? finalPrice,  String? assignmentType,  int? roundNumber)  $default,) {final _that = this;
switch (_that) {
case _AuctionPlayerSummary():
return $default(_that.playerName,_that.playerCategory,_that.playerTag,_that.finalPrice,_that.assignmentType,_that.roundNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerName,  String? playerCategory,  String? playerTag,  int? finalPrice,  String? assignmentType,  int? roundNumber)?  $default,) {final _that = this;
switch (_that) {
case _AuctionPlayerSummary() when $default != null:
return $default(_that.playerName,_that.playerCategory,_that.playerTag,_that.finalPrice,_that.assignmentType,_that.roundNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuctionPlayerSummary implements AuctionPlayerSummary {
  const _AuctionPlayerSummary({required this.playerName, this.playerCategory, this.playerTag, this.finalPrice, this.assignmentType, this.roundNumber});
  factory _AuctionPlayerSummary.fromJson(Map<String, dynamic> json) => _$AuctionPlayerSummaryFromJson(json);

@override final  String playerName;
@override final  String? playerCategory;
@override final  String? playerTag;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuctionPlayerSummary&&(identical(other.playerName, playerName) || other.playerName == playerName)&&(identical(other.playerCategory, playerCategory) || other.playerCategory == playerCategory)&&(identical(other.playerTag, playerTag) || other.playerTag == playerTag)&&(identical(other.finalPrice, finalPrice) || other.finalPrice == finalPrice)&&(identical(other.assignmentType, assignmentType) || other.assignmentType == assignmentType)&&(identical(other.roundNumber, roundNumber) || other.roundNumber == roundNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerName,playerCategory,playerTag,finalPrice,assignmentType,roundNumber);

@override
String toString() {
  return 'AuctionPlayerSummary(playerName: $playerName, playerCategory: $playerCategory, playerTag: $playerTag, finalPrice: $finalPrice, assignmentType: $assignmentType, roundNumber: $roundNumber)';
}


}

/// @nodoc
abstract mixin class _$AuctionPlayerSummaryCopyWith<$Res> implements $AuctionPlayerSummaryCopyWith<$Res> {
  factory _$AuctionPlayerSummaryCopyWith(_AuctionPlayerSummary value, $Res Function(_AuctionPlayerSummary) _then) = __$AuctionPlayerSummaryCopyWithImpl;
@override @useResult
$Res call({
 String playerName, String? playerCategory, String? playerTag, int? finalPrice, String? assignmentType, int? roundNumber
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
@override @pragma('vm:prefer-inline') $Res call({Object? playerName = null,Object? playerCategory = freezed,Object? playerTag = freezed,Object? finalPrice = freezed,Object? assignmentType = freezed,Object? roundNumber = freezed,}) {
  return _then(_AuctionPlayerSummary(
playerName: null == playerName ? _self.playerName : playerName // ignore: cast_nullable_to_non_nullable
as String,playerCategory: freezed == playerCategory ? _self.playerCategory : playerCategory // ignore: cast_nullable_to_non_nullable
as String?,playerTag: freezed == playerTag ? _self.playerTag : playerTag // ignore: cast_nullable_to_non_nullable
as String?,finalPrice: freezed == finalPrice ? _self.finalPrice : finalPrice // ignore: cast_nullable_to_non_nullable
as int?,assignmentType: freezed == assignmentType ? _self.assignmentType : assignmentType // ignore: cast_nullable_to_non_nullable
as String?,roundNumber: freezed == roundNumber ? _self.roundNumber : roundNumber // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$FranchiseResult {

 String get franchiseId; String get franchiseName; int get squadCount; int get totalSpent; int get remainingPurse; List<AuctionPlayerSummary> get players;
/// Create a copy of FranchiseResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FranchiseResultCopyWith<FranchiseResult> get copyWith => _$FranchiseResultCopyWithImpl<FranchiseResult>(this as FranchiseResult, _$identity);

  /// Serializes this FranchiseResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FranchiseResult&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.franchiseName, franchiseName) || other.franchiseName == franchiseName)&&(identical(other.squadCount, squadCount) || other.squadCount == squadCount)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent)&&(identical(other.remainingPurse, remainingPurse) || other.remainingPurse == remainingPurse)&&const DeepCollectionEquality().equals(other.players, players));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,franchiseId,franchiseName,squadCount,totalSpent,remainingPurse,const DeepCollectionEquality().hash(players));

@override
String toString() {
  return 'FranchiseResult(franchiseId: $franchiseId, franchiseName: $franchiseName, squadCount: $squadCount, totalSpent: $totalSpent, remainingPurse: $remainingPurse, players: $players)';
}


}

/// @nodoc
abstract mixin class $FranchiseResultCopyWith<$Res>  {
  factory $FranchiseResultCopyWith(FranchiseResult value, $Res Function(FranchiseResult) _then) = _$FranchiseResultCopyWithImpl;
@useResult
$Res call({
 String franchiseId, String franchiseName, int squadCount, int totalSpent, int remainingPurse, List<AuctionPlayerSummary> players
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
@pragma('vm:prefer-inline') @override $Res call({Object? franchiseId = null,Object? franchiseName = null,Object? squadCount = null,Object? totalSpent = null,Object? remainingPurse = null,Object? players = null,}) {
  return _then(_self.copyWith(
franchiseId: null == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String,franchiseName: null == franchiseName ? _self.franchiseName : franchiseName // ignore: cast_nullable_to_non_nullable
as String,squadCount: null == squadCount ? _self.squadCount : squadCount // ignore: cast_nullable_to_non_nullable
as int,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as int,remainingPurse: null == remainingPurse ? _self.remainingPurse : remainingPurse // ignore: cast_nullable_to_non_nullable
as int,players: null == players ? _self.players : players // ignore: cast_nullable_to_non_nullable
as List<AuctionPlayerSummary>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String franchiseId,  String franchiseName,  int squadCount,  int totalSpent,  int remainingPurse,  List<AuctionPlayerSummary> players)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FranchiseResult() when $default != null:
return $default(_that.franchiseId,_that.franchiseName,_that.squadCount,_that.totalSpent,_that.remainingPurse,_that.players);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String franchiseId,  String franchiseName,  int squadCount,  int totalSpent,  int remainingPurse,  List<AuctionPlayerSummary> players)  $default,) {final _that = this;
switch (_that) {
case _FranchiseResult():
return $default(_that.franchiseId,_that.franchiseName,_that.squadCount,_that.totalSpent,_that.remainingPurse,_that.players);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String franchiseId,  String franchiseName,  int squadCount,  int totalSpent,  int remainingPurse,  List<AuctionPlayerSummary> players)?  $default,) {final _that = this;
switch (_that) {
case _FranchiseResult() when $default != null:
return $default(_that.franchiseId,_that.franchiseName,_that.squadCount,_that.totalSpent,_that.remainingPurse,_that.players);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FranchiseResult implements FranchiseResult {
  const _FranchiseResult({required this.franchiseId, required this.franchiseName, this.squadCount = 0, this.totalSpent = 0, this.remainingPurse = 0, final  List<AuctionPlayerSummary> players = const <AuctionPlayerSummary>[]}): _players = players;
  factory _FranchiseResult.fromJson(Map<String, dynamic> json) => _$FranchiseResultFromJson(json);

@override final  String franchiseId;
@override final  String franchiseName;
@override@JsonKey() final  int squadCount;
@override@JsonKey() final  int totalSpent;
@override@JsonKey() final  int remainingPurse;
 final  List<AuctionPlayerSummary> _players;
@override@JsonKey() List<AuctionPlayerSummary> get players {
  if (_players is EqualUnmodifiableListView) return _players;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_players);
}


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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FranchiseResult&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.franchiseName, franchiseName) || other.franchiseName == franchiseName)&&(identical(other.squadCount, squadCount) || other.squadCount == squadCount)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent)&&(identical(other.remainingPurse, remainingPurse) || other.remainingPurse == remainingPurse)&&const DeepCollectionEquality().equals(other._players, _players));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,franchiseId,franchiseName,squadCount,totalSpent,remainingPurse,const DeepCollectionEquality().hash(_players));

@override
String toString() {
  return 'FranchiseResult(franchiseId: $franchiseId, franchiseName: $franchiseName, squadCount: $squadCount, totalSpent: $totalSpent, remainingPurse: $remainingPurse, players: $players)';
}


}

/// @nodoc
abstract mixin class _$FranchiseResultCopyWith<$Res> implements $FranchiseResultCopyWith<$Res> {
  factory _$FranchiseResultCopyWith(_FranchiseResult value, $Res Function(_FranchiseResult) _then) = __$FranchiseResultCopyWithImpl;
@override @useResult
$Res call({
 String franchiseId, String franchiseName, int squadCount, int totalSpent, int remainingPurse, List<AuctionPlayerSummary> players
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
@override @pragma('vm:prefer-inline') $Res call({Object? franchiseId = null,Object? franchiseName = null,Object? squadCount = null,Object? totalSpent = null,Object? remainingPurse = null,Object? players = null,}) {
  return _then(_FranchiseResult(
franchiseId: null == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String,franchiseName: null == franchiseName ? _self.franchiseName : franchiseName // ignore: cast_nullable_to_non_nullable
as String,squadCount: null == squadCount ? _self.squadCount : squadCount // ignore: cast_nullable_to_non_nullable
as int,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as int,remainingPurse: null == remainingPurse ? _self.remainingPurse : remainingPurse // ignore: cast_nullable_to_non_nullable
as int,players: null == players ? _self._players : players // ignore: cast_nullable_to_non_nullable
as List<AuctionPlayerSummary>,
  ));
}


}


/// @nodoc
mixin _$CategoryBreakdown {

 String get category; int get count; int get totalSpent;
/// Create a copy of CategoryBreakdown
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryBreakdownCopyWith<CategoryBreakdown> get copyWith => _$CategoryBreakdownCopyWithImpl<CategoryBreakdown>(this as CategoryBreakdown, _$identity);

  /// Serializes this CategoryBreakdown to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryBreakdown&&(identical(other.category, category) || other.category == category)&&(identical(other.count, count) || other.count == count)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,count,totalSpent);

@override
String toString() {
  return 'CategoryBreakdown(category: $category, count: $count, totalSpent: $totalSpent)';
}


}

/// @nodoc
abstract mixin class $CategoryBreakdownCopyWith<$Res>  {
  factory $CategoryBreakdownCopyWith(CategoryBreakdown value, $Res Function(CategoryBreakdown) _then) = _$CategoryBreakdownCopyWithImpl;
@useResult
$Res call({
 String category, int count, int totalSpent
});




}
/// @nodoc
class _$CategoryBreakdownCopyWithImpl<$Res>
    implements $CategoryBreakdownCopyWith<$Res> {
  _$CategoryBreakdownCopyWithImpl(this._self, this._then);

  final CategoryBreakdown _self;
  final $Res Function(CategoryBreakdown) _then;

/// Create a copy of CategoryBreakdown
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = null,Object? count = null,Object? totalSpent = null,}) {
  return _then(_self.copyWith(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryBreakdown].
extension CategoryBreakdownPatterns on CategoryBreakdown {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryBreakdown value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryBreakdown() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryBreakdown value)  $default,){
final _that = this;
switch (_that) {
case _CategoryBreakdown():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryBreakdown value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryBreakdown() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String category,  int count,  int totalSpent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryBreakdown() when $default != null:
return $default(_that.category,_that.count,_that.totalSpent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String category,  int count,  int totalSpent)  $default,) {final _that = this;
switch (_that) {
case _CategoryBreakdown():
return $default(_that.category,_that.count,_that.totalSpent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String category,  int count,  int totalSpent)?  $default,) {final _that = this;
switch (_that) {
case _CategoryBreakdown() when $default != null:
return $default(_that.category,_that.count,_that.totalSpent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CategoryBreakdown implements CategoryBreakdown {
  const _CategoryBreakdown({required this.category, this.count = 0, this.totalSpent = 0});
  factory _CategoryBreakdown.fromJson(Map<String, dynamic> json) => _$CategoryBreakdownFromJson(json);

@override final  String category;
@override@JsonKey() final  int count;
@override@JsonKey() final  int totalSpent;

/// Create a copy of CategoryBreakdown
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryBreakdownCopyWith<_CategoryBreakdown> get copyWith => __$CategoryBreakdownCopyWithImpl<_CategoryBreakdown>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategoryBreakdownToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryBreakdown&&(identical(other.category, category) || other.category == category)&&(identical(other.count, count) || other.count == count)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,count,totalSpent);

@override
String toString() {
  return 'CategoryBreakdown(category: $category, count: $count, totalSpent: $totalSpent)';
}


}

/// @nodoc
abstract mixin class _$CategoryBreakdownCopyWith<$Res> implements $CategoryBreakdownCopyWith<$Res> {
  factory _$CategoryBreakdownCopyWith(_CategoryBreakdown value, $Res Function(_CategoryBreakdown) _then) = __$CategoryBreakdownCopyWithImpl;
@override @useResult
$Res call({
 String category, int count, int totalSpent
});




}
/// @nodoc
class __$CategoryBreakdownCopyWithImpl<$Res>
    implements _$CategoryBreakdownCopyWith<$Res> {
  __$CategoryBreakdownCopyWithImpl(this._self, this._then);

  final _CategoryBreakdown _self;
  final $Res Function(_CategoryBreakdown) _then;

/// Create a copy of CategoryBreakdown
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = null,Object? count = null,Object? totalSpent = null,}) {
  return _then(_CategoryBreakdown(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$FranchiseDetailedSummary {

 String get franchiseId; String get franchiseName; int get squadCount; int get totalSpent; int get remainingPurse; List<CategoryBreakdown> get categoryBreakdown; List<AuctionPlayerSummary> get players;
/// Create a copy of FranchiseDetailedSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FranchiseDetailedSummaryCopyWith<FranchiseDetailedSummary> get copyWith => _$FranchiseDetailedSummaryCopyWithImpl<FranchiseDetailedSummary>(this as FranchiseDetailedSummary, _$identity);

  /// Serializes this FranchiseDetailedSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FranchiseDetailedSummary&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.franchiseName, franchiseName) || other.franchiseName == franchiseName)&&(identical(other.squadCount, squadCount) || other.squadCount == squadCount)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent)&&(identical(other.remainingPurse, remainingPurse) || other.remainingPurse == remainingPurse)&&const DeepCollectionEquality().equals(other.categoryBreakdown, categoryBreakdown)&&const DeepCollectionEquality().equals(other.players, players));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,franchiseId,franchiseName,squadCount,totalSpent,remainingPurse,const DeepCollectionEquality().hash(categoryBreakdown),const DeepCollectionEquality().hash(players));

@override
String toString() {
  return 'FranchiseDetailedSummary(franchiseId: $franchiseId, franchiseName: $franchiseName, squadCount: $squadCount, totalSpent: $totalSpent, remainingPurse: $remainingPurse, categoryBreakdown: $categoryBreakdown, players: $players)';
}


}

/// @nodoc
abstract mixin class $FranchiseDetailedSummaryCopyWith<$Res>  {
  factory $FranchiseDetailedSummaryCopyWith(FranchiseDetailedSummary value, $Res Function(FranchiseDetailedSummary) _then) = _$FranchiseDetailedSummaryCopyWithImpl;
@useResult
$Res call({
 String franchiseId, String franchiseName, int squadCount, int totalSpent, int remainingPurse, List<CategoryBreakdown> categoryBreakdown, List<AuctionPlayerSummary> players
});




}
/// @nodoc
class _$FranchiseDetailedSummaryCopyWithImpl<$Res>
    implements $FranchiseDetailedSummaryCopyWith<$Res> {
  _$FranchiseDetailedSummaryCopyWithImpl(this._self, this._then);

  final FranchiseDetailedSummary _self;
  final $Res Function(FranchiseDetailedSummary) _then;

/// Create a copy of FranchiseDetailedSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? franchiseId = null,Object? franchiseName = null,Object? squadCount = null,Object? totalSpent = null,Object? remainingPurse = null,Object? categoryBreakdown = null,Object? players = null,}) {
  return _then(_self.copyWith(
franchiseId: null == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String,franchiseName: null == franchiseName ? _self.franchiseName : franchiseName // ignore: cast_nullable_to_non_nullable
as String,squadCount: null == squadCount ? _self.squadCount : squadCount // ignore: cast_nullable_to_non_nullable
as int,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as int,remainingPurse: null == remainingPurse ? _self.remainingPurse : remainingPurse // ignore: cast_nullable_to_non_nullable
as int,categoryBreakdown: null == categoryBreakdown ? _self.categoryBreakdown : categoryBreakdown // ignore: cast_nullable_to_non_nullable
as List<CategoryBreakdown>,players: null == players ? _self.players : players // ignore: cast_nullable_to_non_nullable
as List<AuctionPlayerSummary>,
  ));
}

}


/// Adds pattern-matching-related methods to [FranchiseDetailedSummary].
extension FranchiseDetailedSummaryPatterns on FranchiseDetailedSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FranchiseDetailedSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FranchiseDetailedSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FranchiseDetailedSummary value)  $default,){
final _that = this;
switch (_that) {
case _FranchiseDetailedSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FranchiseDetailedSummary value)?  $default,){
final _that = this;
switch (_that) {
case _FranchiseDetailedSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String franchiseId,  String franchiseName,  int squadCount,  int totalSpent,  int remainingPurse,  List<CategoryBreakdown> categoryBreakdown,  List<AuctionPlayerSummary> players)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FranchiseDetailedSummary() when $default != null:
return $default(_that.franchiseId,_that.franchiseName,_that.squadCount,_that.totalSpent,_that.remainingPurse,_that.categoryBreakdown,_that.players);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String franchiseId,  String franchiseName,  int squadCount,  int totalSpent,  int remainingPurse,  List<CategoryBreakdown> categoryBreakdown,  List<AuctionPlayerSummary> players)  $default,) {final _that = this;
switch (_that) {
case _FranchiseDetailedSummary():
return $default(_that.franchiseId,_that.franchiseName,_that.squadCount,_that.totalSpent,_that.remainingPurse,_that.categoryBreakdown,_that.players);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String franchiseId,  String franchiseName,  int squadCount,  int totalSpent,  int remainingPurse,  List<CategoryBreakdown> categoryBreakdown,  List<AuctionPlayerSummary> players)?  $default,) {final _that = this;
switch (_that) {
case _FranchiseDetailedSummary() when $default != null:
return $default(_that.franchiseId,_that.franchiseName,_that.squadCount,_that.totalSpent,_that.remainingPurse,_that.categoryBreakdown,_that.players);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FranchiseDetailedSummary implements FranchiseDetailedSummary {
  const _FranchiseDetailedSummary({required this.franchiseId, required this.franchiseName, this.squadCount = 0, this.totalSpent = 0, this.remainingPurse = 0, final  List<CategoryBreakdown> categoryBreakdown = const <CategoryBreakdown>[], final  List<AuctionPlayerSummary> players = const <AuctionPlayerSummary>[]}): _categoryBreakdown = categoryBreakdown,_players = players;
  factory _FranchiseDetailedSummary.fromJson(Map<String, dynamic> json) => _$FranchiseDetailedSummaryFromJson(json);

@override final  String franchiseId;
@override final  String franchiseName;
@override@JsonKey() final  int squadCount;
@override@JsonKey() final  int totalSpent;
@override@JsonKey() final  int remainingPurse;
 final  List<CategoryBreakdown> _categoryBreakdown;
@override@JsonKey() List<CategoryBreakdown> get categoryBreakdown {
  if (_categoryBreakdown is EqualUnmodifiableListView) return _categoryBreakdown;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categoryBreakdown);
}

 final  List<AuctionPlayerSummary> _players;
@override@JsonKey() List<AuctionPlayerSummary> get players {
  if (_players is EqualUnmodifiableListView) return _players;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_players);
}


/// Create a copy of FranchiseDetailedSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FranchiseDetailedSummaryCopyWith<_FranchiseDetailedSummary> get copyWith => __$FranchiseDetailedSummaryCopyWithImpl<_FranchiseDetailedSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FranchiseDetailedSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FranchiseDetailedSummary&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.franchiseName, franchiseName) || other.franchiseName == franchiseName)&&(identical(other.squadCount, squadCount) || other.squadCount == squadCount)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent)&&(identical(other.remainingPurse, remainingPurse) || other.remainingPurse == remainingPurse)&&const DeepCollectionEquality().equals(other._categoryBreakdown, _categoryBreakdown)&&const DeepCollectionEquality().equals(other._players, _players));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,franchiseId,franchiseName,squadCount,totalSpent,remainingPurse,const DeepCollectionEquality().hash(_categoryBreakdown),const DeepCollectionEquality().hash(_players));

@override
String toString() {
  return 'FranchiseDetailedSummary(franchiseId: $franchiseId, franchiseName: $franchiseName, squadCount: $squadCount, totalSpent: $totalSpent, remainingPurse: $remainingPurse, categoryBreakdown: $categoryBreakdown, players: $players)';
}


}

/// @nodoc
abstract mixin class _$FranchiseDetailedSummaryCopyWith<$Res> implements $FranchiseDetailedSummaryCopyWith<$Res> {
  factory _$FranchiseDetailedSummaryCopyWith(_FranchiseDetailedSummary value, $Res Function(_FranchiseDetailedSummary) _then) = __$FranchiseDetailedSummaryCopyWithImpl;
@override @useResult
$Res call({
 String franchiseId, String franchiseName, int squadCount, int totalSpent, int remainingPurse, List<CategoryBreakdown> categoryBreakdown, List<AuctionPlayerSummary> players
});




}
/// @nodoc
class __$FranchiseDetailedSummaryCopyWithImpl<$Res>
    implements _$FranchiseDetailedSummaryCopyWith<$Res> {
  __$FranchiseDetailedSummaryCopyWithImpl(this._self, this._then);

  final _FranchiseDetailedSummary _self;
  final $Res Function(_FranchiseDetailedSummary) _then;

/// Create a copy of FranchiseDetailedSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? franchiseId = null,Object? franchiseName = null,Object? squadCount = null,Object? totalSpent = null,Object? remainingPurse = null,Object? categoryBreakdown = null,Object? players = null,}) {
  return _then(_FranchiseDetailedSummary(
franchiseId: null == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String,franchiseName: null == franchiseName ? _self.franchiseName : franchiseName // ignore: cast_nullable_to_non_nullable
as String,squadCount: null == squadCount ? _self.squadCount : squadCount // ignore: cast_nullable_to_non_nullable
as int,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as int,remainingPurse: null == remainingPurse ? _self.remainingPurse : remainingPurse // ignore: cast_nullable_to_non_nullable
as int,categoryBreakdown: null == categoryBreakdown ? _self._categoryBreakdown : categoryBreakdown // ignore: cast_nullable_to_non_nullable
as List<CategoryBreakdown>,players: null == players ? _self._players : players // ignore: cast_nullable_to_non_nullable
as List<AuctionPlayerSummary>,
  ));
}


}


/// @nodoc
mixin _$UnsoldPlayersResponse {

 List<AuctionPlayerSummary> get players; int get totalElements; int get totalPages; int get pageNumber; int get pageSize;
/// Create a copy of UnsoldPlayersResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnsoldPlayersResponseCopyWith<UnsoldPlayersResponse> get copyWith => _$UnsoldPlayersResponseCopyWithImpl<UnsoldPlayersResponse>(this as UnsoldPlayersResponse, _$identity);

  /// Serializes this UnsoldPlayersResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnsoldPlayersResponse&&const DeepCollectionEquality().equals(other.players, players)&&(identical(other.totalElements, totalElements) || other.totalElements == totalElements)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(players),totalElements,totalPages,pageNumber,pageSize);

@override
String toString() {
  return 'UnsoldPlayersResponse(players: $players, totalElements: $totalElements, totalPages: $totalPages, pageNumber: $pageNumber, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class $UnsoldPlayersResponseCopyWith<$Res>  {
  factory $UnsoldPlayersResponseCopyWith(UnsoldPlayersResponse value, $Res Function(UnsoldPlayersResponse) _then) = _$UnsoldPlayersResponseCopyWithImpl;
@useResult
$Res call({
 List<AuctionPlayerSummary> players, int totalElements, int totalPages, int pageNumber, int pageSize
});




}
/// @nodoc
class _$UnsoldPlayersResponseCopyWithImpl<$Res>
    implements $UnsoldPlayersResponseCopyWith<$Res> {
  _$UnsoldPlayersResponseCopyWithImpl(this._self, this._then);

  final UnsoldPlayersResponse _self;
  final $Res Function(UnsoldPlayersResponse) _then;

/// Create a copy of UnsoldPlayersResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? players = null,Object? totalElements = null,Object? totalPages = null,Object? pageNumber = null,Object? pageSize = null,}) {
  return _then(_self.copyWith(
players: null == players ? _self.players : players // ignore: cast_nullable_to_non_nullable
as List<AuctionPlayerSummary>,totalElements: null == totalElements ? _self.totalElements : totalElements // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UnsoldPlayersResponse].
extension UnsoldPlayersResponsePatterns on UnsoldPlayersResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnsoldPlayersResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnsoldPlayersResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnsoldPlayersResponse value)  $default,){
final _that = this;
switch (_that) {
case _UnsoldPlayersResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnsoldPlayersResponse value)?  $default,){
final _that = this;
switch (_that) {
case _UnsoldPlayersResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AuctionPlayerSummary> players,  int totalElements,  int totalPages,  int pageNumber,  int pageSize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnsoldPlayersResponse() when $default != null:
return $default(_that.players,_that.totalElements,_that.totalPages,_that.pageNumber,_that.pageSize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AuctionPlayerSummary> players,  int totalElements,  int totalPages,  int pageNumber,  int pageSize)  $default,) {final _that = this;
switch (_that) {
case _UnsoldPlayersResponse():
return $default(_that.players,_that.totalElements,_that.totalPages,_that.pageNumber,_that.pageSize);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AuctionPlayerSummary> players,  int totalElements,  int totalPages,  int pageNumber,  int pageSize)?  $default,) {final _that = this;
switch (_that) {
case _UnsoldPlayersResponse() when $default != null:
return $default(_that.players,_that.totalElements,_that.totalPages,_that.pageNumber,_that.pageSize);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UnsoldPlayersResponse implements UnsoldPlayersResponse {
  const _UnsoldPlayersResponse({final  List<AuctionPlayerSummary> players = const <AuctionPlayerSummary>[], this.totalElements = 0, this.totalPages = 0, this.pageNumber = 0, this.pageSize = 0}): _players = players;
  factory _UnsoldPlayersResponse.fromJson(Map<String, dynamic> json) => _$UnsoldPlayersResponseFromJson(json);

 final  List<AuctionPlayerSummary> _players;
@override@JsonKey() List<AuctionPlayerSummary> get players {
  if (_players is EqualUnmodifiableListView) return _players;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_players);
}

@override@JsonKey() final  int totalElements;
@override@JsonKey() final  int totalPages;
@override@JsonKey() final  int pageNumber;
@override@JsonKey() final  int pageSize;

/// Create a copy of UnsoldPlayersResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnsoldPlayersResponseCopyWith<_UnsoldPlayersResponse> get copyWith => __$UnsoldPlayersResponseCopyWithImpl<_UnsoldPlayersResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnsoldPlayersResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnsoldPlayersResponse&&const DeepCollectionEquality().equals(other._players, _players)&&(identical(other.totalElements, totalElements) || other.totalElements == totalElements)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_players),totalElements,totalPages,pageNumber,pageSize);

@override
String toString() {
  return 'UnsoldPlayersResponse(players: $players, totalElements: $totalElements, totalPages: $totalPages, pageNumber: $pageNumber, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class _$UnsoldPlayersResponseCopyWith<$Res> implements $UnsoldPlayersResponseCopyWith<$Res> {
  factory _$UnsoldPlayersResponseCopyWith(_UnsoldPlayersResponse value, $Res Function(_UnsoldPlayersResponse) _then) = __$UnsoldPlayersResponseCopyWithImpl;
@override @useResult
$Res call({
 List<AuctionPlayerSummary> players, int totalElements, int totalPages, int pageNumber, int pageSize
});




}
/// @nodoc
class __$UnsoldPlayersResponseCopyWithImpl<$Res>
    implements _$UnsoldPlayersResponseCopyWith<$Res> {
  __$UnsoldPlayersResponseCopyWithImpl(this._self, this._then);

  final _UnsoldPlayersResponse _self;
  final $Res Function(_UnsoldPlayersResponse) _then;

/// Create a copy of UnsoldPlayersResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? players = null,Object? totalElements = null,Object? totalPages = null,Object? pageNumber = null,Object? pageSize = null,}) {
  return _then(_UnsoldPlayersResponse(
players: null == players ? _self._players : players // ignore: cast_nullable_to_non_nullable
as List<AuctionPlayerSummary>,totalElements: null == totalElements ? _self.totalElements : totalElements // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
