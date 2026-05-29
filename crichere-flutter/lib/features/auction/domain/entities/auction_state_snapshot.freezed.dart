// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auction_state_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BidIncrementSlab {

 int get fromAmount; int? get toAmount; int get incrementBy;
/// Create a copy of BidIncrementSlab
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BidIncrementSlabCopyWith<BidIncrementSlab> get copyWith => _$BidIncrementSlabCopyWithImpl<BidIncrementSlab>(this as BidIncrementSlab, _$identity);

  /// Serializes this BidIncrementSlab to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BidIncrementSlab&&(identical(other.fromAmount, fromAmount) || other.fromAmount == fromAmount)&&(identical(other.toAmount, toAmount) || other.toAmount == toAmount)&&(identical(other.incrementBy, incrementBy) || other.incrementBy == incrementBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fromAmount,toAmount,incrementBy);

@override
String toString() {
  return 'BidIncrementSlab(fromAmount: $fromAmount, toAmount: $toAmount, incrementBy: $incrementBy)';
}


}

/// @nodoc
abstract mixin class $BidIncrementSlabCopyWith<$Res>  {
  factory $BidIncrementSlabCopyWith(BidIncrementSlab value, $Res Function(BidIncrementSlab) _then) = _$BidIncrementSlabCopyWithImpl;
@useResult
$Res call({
 int fromAmount, int? toAmount, int incrementBy
});




}
/// @nodoc
class _$BidIncrementSlabCopyWithImpl<$Res>
    implements $BidIncrementSlabCopyWith<$Res> {
  _$BidIncrementSlabCopyWithImpl(this._self, this._then);

  final BidIncrementSlab _self;
  final $Res Function(BidIncrementSlab) _then;

/// Create a copy of BidIncrementSlab
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fromAmount = null,Object? toAmount = freezed,Object? incrementBy = null,}) {
  return _then(_self.copyWith(
fromAmount: null == fromAmount ? _self.fromAmount : fromAmount // ignore: cast_nullable_to_non_nullable
as int,toAmount: freezed == toAmount ? _self.toAmount : toAmount // ignore: cast_nullable_to_non_nullable
as int?,incrementBy: null == incrementBy ? _self.incrementBy : incrementBy // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BidIncrementSlab].
extension BidIncrementSlabPatterns on BidIncrementSlab {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BidIncrementSlab value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BidIncrementSlab() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BidIncrementSlab value)  $default,){
final _that = this;
switch (_that) {
case _BidIncrementSlab():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BidIncrementSlab value)?  $default,){
final _that = this;
switch (_that) {
case _BidIncrementSlab() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int fromAmount,  int? toAmount,  int incrementBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BidIncrementSlab() when $default != null:
return $default(_that.fromAmount,_that.toAmount,_that.incrementBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int fromAmount,  int? toAmount,  int incrementBy)  $default,) {final _that = this;
switch (_that) {
case _BidIncrementSlab():
return $default(_that.fromAmount,_that.toAmount,_that.incrementBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int fromAmount,  int? toAmount,  int incrementBy)?  $default,) {final _that = this;
switch (_that) {
case _BidIncrementSlab() when $default != null:
return $default(_that.fromAmount,_that.toAmount,_that.incrementBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BidIncrementSlab implements BidIncrementSlab {
  const _BidIncrementSlab({required this.fromAmount, this.toAmount, required this.incrementBy});
  factory _BidIncrementSlab.fromJson(Map<String, dynamic> json) => _$BidIncrementSlabFromJson(json);

@override final  int fromAmount;
@override final  int? toAmount;
@override final  int incrementBy;

/// Create a copy of BidIncrementSlab
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BidIncrementSlabCopyWith<_BidIncrementSlab> get copyWith => __$BidIncrementSlabCopyWithImpl<_BidIncrementSlab>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BidIncrementSlabToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BidIncrementSlab&&(identical(other.fromAmount, fromAmount) || other.fromAmount == fromAmount)&&(identical(other.toAmount, toAmount) || other.toAmount == toAmount)&&(identical(other.incrementBy, incrementBy) || other.incrementBy == incrementBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fromAmount,toAmount,incrementBy);

@override
String toString() {
  return 'BidIncrementSlab(fromAmount: $fromAmount, toAmount: $toAmount, incrementBy: $incrementBy)';
}


}

/// @nodoc
abstract mixin class _$BidIncrementSlabCopyWith<$Res> implements $BidIncrementSlabCopyWith<$Res> {
  factory _$BidIncrementSlabCopyWith(_BidIncrementSlab value, $Res Function(_BidIncrementSlab) _then) = __$BidIncrementSlabCopyWithImpl;
@override @useResult
$Res call({
 int fromAmount, int? toAmount, int incrementBy
});




}
/// @nodoc
class __$BidIncrementSlabCopyWithImpl<$Res>
    implements _$BidIncrementSlabCopyWith<$Res> {
  __$BidIncrementSlabCopyWithImpl(this._self, this._then);

  final _BidIncrementSlab _self;
  final $Res Function(_BidIncrementSlab) _then;

/// Create a copy of BidIncrementSlab
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fromAmount = null,Object? toAmount = freezed,Object? incrementBy = null,}) {
  return _then(_BidIncrementSlab(
fromAmount: null == fromAmount ? _self.fromAmount : fromAmount // ignore: cast_nullable_to_non_nullable
as int,toAmount: freezed == toAmount ? _self.toAmount : toAmount // ignore: cast_nullable_to_non_nullable
as int?,incrementBy: null == incrementBy ? _self.incrementBy : incrementBy // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$RoundConfig {

 int get roundNumber; String? get name;@JsonKey(unknownEnumValue: CurrencyType.unknown) CurrencyType get currencyType; int? get purseAmount;@JsonKey(unknownEnumValue: PurseSource.unknown) PurseSource get purseSource;@JsonKey(unknownEnumValue: BidMode.unknown) BidMode get bidMode;@JsonKey(unknownEnumValue: PlayerPoolSource.unknown) PlayerPoolSource get playerPoolSource;@JsonKey(unknownEnumValue: FranchiseEligibilityRule.unknown) FranchiseEligibilityRule get franchiseEligibilityRule;@JsonKey(unknownEnumValue: CompletionTrigger.unknown) CompletionTrigger get completionTrigger; int? get countdownSeconds; int? get antiSnipeSeconds; List<BidIncrementSlab> get bidIncrementSlabs;
/// Create a copy of RoundConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoundConfigCopyWith<RoundConfig> get copyWith => _$RoundConfigCopyWithImpl<RoundConfig>(this as RoundConfig, _$identity);

  /// Serializes this RoundConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoundConfig&&(identical(other.roundNumber, roundNumber) || other.roundNumber == roundNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.currencyType, currencyType) || other.currencyType == currencyType)&&(identical(other.purseAmount, purseAmount) || other.purseAmount == purseAmount)&&(identical(other.purseSource, purseSource) || other.purseSource == purseSource)&&(identical(other.bidMode, bidMode) || other.bidMode == bidMode)&&(identical(other.playerPoolSource, playerPoolSource) || other.playerPoolSource == playerPoolSource)&&(identical(other.franchiseEligibilityRule, franchiseEligibilityRule) || other.franchiseEligibilityRule == franchiseEligibilityRule)&&(identical(other.completionTrigger, completionTrigger) || other.completionTrigger == completionTrigger)&&(identical(other.countdownSeconds, countdownSeconds) || other.countdownSeconds == countdownSeconds)&&(identical(other.antiSnipeSeconds, antiSnipeSeconds) || other.antiSnipeSeconds == antiSnipeSeconds)&&const DeepCollectionEquality().equals(other.bidIncrementSlabs, bidIncrementSlabs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,roundNumber,name,currencyType,purseAmount,purseSource,bidMode,playerPoolSource,franchiseEligibilityRule,completionTrigger,countdownSeconds,antiSnipeSeconds,const DeepCollectionEquality().hash(bidIncrementSlabs));

@override
String toString() {
  return 'RoundConfig(roundNumber: $roundNumber, name: $name, currencyType: $currencyType, purseAmount: $purseAmount, purseSource: $purseSource, bidMode: $bidMode, playerPoolSource: $playerPoolSource, franchiseEligibilityRule: $franchiseEligibilityRule, completionTrigger: $completionTrigger, countdownSeconds: $countdownSeconds, antiSnipeSeconds: $antiSnipeSeconds, bidIncrementSlabs: $bidIncrementSlabs)';
}


}

/// @nodoc
abstract mixin class $RoundConfigCopyWith<$Res>  {
  factory $RoundConfigCopyWith(RoundConfig value, $Res Function(RoundConfig) _then) = _$RoundConfigCopyWithImpl;
@useResult
$Res call({
 int roundNumber, String? name,@JsonKey(unknownEnumValue: CurrencyType.unknown) CurrencyType currencyType, int? purseAmount,@JsonKey(unknownEnumValue: PurseSource.unknown) PurseSource purseSource,@JsonKey(unknownEnumValue: BidMode.unknown) BidMode bidMode,@JsonKey(unknownEnumValue: PlayerPoolSource.unknown) PlayerPoolSource playerPoolSource,@JsonKey(unknownEnumValue: FranchiseEligibilityRule.unknown) FranchiseEligibilityRule franchiseEligibilityRule,@JsonKey(unknownEnumValue: CompletionTrigger.unknown) CompletionTrigger completionTrigger, int? countdownSeconds, int? antiSnipeSeconds, List<BidIncrementSlab> bidIncrementSlabs
});




}
/// @nodoc
class _$RoundConfigCopyWithImpl<$Res>
    implements $RoundConfigCopyWith<$Res> {
  _$RoundConfigCopyWithImpl(this._self, this._then);

  final RoundConfig _self;
  final $Res Function(RoundConfig) _then;

/// Create a copy of RoundConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roundNumber = null,Object? name = freezed,Object? currencyType = null,Object? purseAmount = freezed,Object? purseSource = null,Object? bidMode = null,Object? playerPoolSource = null,Object? franchiseEligibilityRule = null,Object? completionTrigger = null,Object? countdownSeconds = freezed,Object? antiSnipeSeconds = freezed,Object? bidIncrementSlabs = null,}) {
  return _then(_self.copyWith(
roundNumber: null == roundNumber ? _self.roundNumber : roundNumber // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,currencyType: null == currencyType ? _self.currencyType : currencyType // ignore: cast_nullable_to_non_nullable
as CurrencyType,purseAmount: freezed == purseAmount ? _self.purseAmount : purseAmount // ignore: cast_nullable_to_non_nullable
as int?,purseSource: null == purseSource ? _self.purseSource : purseSource // ignore: cast_nullable_to_non_nullable
as PurseSource,bidMode: null == bidMode ? _self.bidMode : bidMode // ignore: cast_nullable_to_non_nullable
as BidMode,playerPoolSource: null == playerPoolSource ? _self.playerPoolSource : playerPoolSource // ignore: cast_nullable_to_non_nullable
as PlayerPoolSource,franchiseEligibilityRule: null == franchiseEligibilityRule ? _self.franchiseEligibilityRule : franchiseEligibilityRule // ignore: cast_nullable_to_non_nullable
as FranchiseEligibilityRule,completionTrigger: null == completionTrigger ? _self.completionTrigger : completionTrigger // ignore: cast_nullable_to_non_nullable
as CompletionTrigger,countdownSeconds: freezed == countdownSeconds ? _self.countdownSeconds : countdownSeconds // ignore: cast_nullable_to_non_nullable
as int?,antiSnipeSeconds: freezed == antiSnipeSeconds ? _self.antiSnipeSeconds : antiSnipeSeconds // ignore: cast_nullable_to_non_nullable
as int?,bidIncrementSlabs: null == bidIncrementSlabs ? _self.bidIncrementSlabs : bidIncrementSlabs // ignore: cast_nullable_to_non_nullable
as List<BidIncrementSlab>,
  ));
}

}


/// Adds pattern-matching-related methods to [RoundConfig].
extension RoundConfigPatterns on RoundConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoundConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoundConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoundConfig value)  $default,){
final _that = this;
switch (_that) {
case _RoundConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoundConfig value)?  $default,){
final _that = this;
switch (_that) {
case _RoundConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int roundNumber,  String? name, @JsonKey(unknownEnumValue: CurrencyType.unknown)  CurrencyType currencyType,  int? purseAmount, @JsonKey(unknownEnumValue: PurseSource.unknown)  PurseSource purseSource, @JsonKey(unknownEnumValue: BidMode.unknown)  BidMode bidMode, @JsonKey(unknownEnumValue: PlayerPoolSource.unknown)  PlayerPoolSource playerPoolSource, @JsonKey(unknownEnumValue: FranchiseEligibilityRule.unknown)  FranchiseEligibilityRule franchiseEligibilityRule, @JsonKey(unknownEnumValue: CompletionTrigger.unknown)  CompletionTrigger completionTrigger,  int? countdownSeconds,  int? antiSnipeSeconds,  List<BidIncrementSlab> bidIncrementSlabs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoundConfig() when $default != null:
return $default(_that.roundNumber,_that.name,_that.currencyType,_that.purseAmount,_that.purseSource,_that.bidMode,_that.playerPoolSource,_that.franchiseEligibilityRule,_that.completionTrigger,_that.countdownSeconds,_that.antiSnipeSeconds,_that.bidIncrementSlabs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int roundNumber,  String? name, @JsonKey(unknownEnumValue: CurrencyType.unknown)  CurrencyType currencyType,  int? purseAmount, @JsonKey(unknownEnumValue: PurseSource.unknown)  PurseSource purseSource, @JsonKey(unknownEnumValue: BidMode.unknown)  BidMode bidMode, @JsonKey(unknownEnumValue: PlayerPoolSource.unknown)  PlayerPoolSource playerPoolSource, @JsonKey(unknownEnumValue: FranchiseEligibilityRule.unknown)  FranchiseEligibilityRule franchiseEligibilityRule, @JsonKey(unknownEnumValue: CompletionTrigger.unknown)  CompletionTrigger completionTrigger,  int? countdownSeconds,  int? antiSnipeSeconds,  List<BidIncrementSlab> bidIncrementSlabs)  $default,) {final _that = this;
switch (_that) {
case _RoundConfig():
return $default(_that.roundNumber,_that.name,_that.currencyType,_that.purseAmount,_that.purseSource,_that.bidMode,_that.playerPoolSource,_that.franchiseEligibilityRule,_that.completionTrigger,_that.countdownSeconds,_that.antiSnipeSeconds,_that.bidIncrementSlabs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int roundNumber,  String? name, @JsonKey(unknownEnumValue: CurrencyType.unknown)  CurrencyType currencyType,  int? purseAmount, @JsonKey(unknownEnumValue: PurseSource.unknown)  PurseSource purseSource, @JsonKey(unknownEnumValue: BidMode.unknown)  BidMode bidMode, @JsonKey(unknownEnumValue: PlayerPoolSource.unknown)  PlayerPoolSource playerPoolSource, @JsonKey(unknownEnumValue: FranchiseEligibilityRule.unknown)  FranchiseEligibilityRule franchiseEligibilityRule, @JsonKey(unknownEnumValue: CompletionTrigger.unknown)  CompletionTrigger completionTrigger,  int? countdownSeconds,  int? antiSnipeSeconds,  List<BidIncrementSlab> bidIncrementSlabs)?  $default,) {final _that = this;
switch (_that) {
case _RoundConfig() when $default != null:
return $default(_that.roundNumber,_that.name,_that.currencyType,_that.purseAmount,_that.purseSource,_that.bidMode,_that.playerPoolSource,_that.franchiseEligibilityRule,_that.completionTrigger,_that.countdownSeconds,_that.antiSnipeSeconds,_that.bidIncrementSlabs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoundConfig implements RoundConfig {
  const _RoundConfig({required this.roundNumber, this.name, @JsonKey(unknownEnumValue: CurrencyType.unknown) required this.currencyType, this.purseAmount, @JsonKey(unknownEnumValue: PurseSource.unknown) required this.purseSource, @JsonKey(unknownEnumValue: BidMode.unknown) required this.bidMode, @JsonKey(unknownEnumValue: PlayerPoolSource.unknown) required this.playerPoolSource, @JsonKey(unknownEnumValue: FranchiseEligibilityRule.unknown) required this.franchiseEligibilityRule, @JsonKey(unknownEnumValue: CompletionTrigger.unknown) required this.completionTrigger, this.countdownSeconds, this.antiSnipeSeconds, final  List<BidIncrementSlab> bidIncrementSlabs = const <BidIncrementSlab>[]}): _bidIncrementSlabs = bidIncrementSlabs;
  factory _RoundConfig.fromJson(Map<String, dynamic> json) => _$RoundConfigFromJson(json);

@override final  int roundNumber;
@override final  String? name;
@override@JsonKey(unknownEnumValue: CurrencyType.unknown) final  CurrencyType currencyType;
@override final  int? purseAmount;
@override@JsonKey(unknownEnumValue: PurseSource.unknown) final  PurseSource purseSource;
@override@JsonKey(unknownEnumValue: BidMode.unknown) final  BidMode bidMode;
@override@JsonKey(unknownEnumValue: PlayerPoolSource.unknown) final  PlayerPoolSource playerPoolSource;
@override@JsonKey(unknownEnumValue: FranchiseEligibilityRule.unknown) final  FranchiseEligibilityRule franchiseEligibilityRule;
@override@JsonKey(unknownEnumValue: CompletionTrigger.unknown) final  CompletionTrigger completionTrigger;
@override final  int? countdownSeconds;
@override final  int? antiSnipeSeconds;
 final  List<BidIncrementSlab> _bidIncrementSlabs;
@override@JsonKey() List<BidIncrementSlab> get bidIncrementSlabs {
  if (_bidIncrementSlabs is EqualUnmodifiableListView) return _bidIncrementSlabs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bidIncrementSlabs);
}


/// Create a copy of RoundConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoundConfigCopyWith<_RoundConfig> get copyWith => __$RoundConfigCopyWithImpl<_RoundConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoundConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoundConfig&&(identical(other.roundNumber, roundNumber) || other.roundNumber == roundNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.currencyType, currencyType) || other.currencyType == currencyType)&&(identical(other.purseAmount, purseAmount) || other.purseAmount == purseAmount)&&(identical(other.purseSource, purseSource) || other.purseSource == purseSource)&&(identical(other.bidMode, bidMode) || other.bidMode == bidMode)&&(identical(other.playerPoolSource, playerPoolSource) || other.playerPoolSource == playerPoolSource)&&(identical(other.franchiseEligibilityRule, franchiseEligibilityRule) || other.franchiseEligibilityRule == franchiseEligibilityRule)&&(identical(other.completionTrigger, completionTrigger) || other.completionTrigger == completionTrigger)&&(identical(other.countdownSeconds, countdownSeconds) || other.countdownSeconds == countdownSeconds)&&(identical(other.antiSnipeSeconds, antiSnipeSeconds) || other.antiSnipeSeconds == antiSnipeSeconds)&&const DeepCollectionEquality().equals(other._bidIncrementSlabs, _bidIncrementSlabs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,roundNumber,name,currencyType,purseAmount,purseSource,bidMode,playerPoolSource,franchiseEligibilityRule,completionTrigger,countdownSeconds,antiSnipeSeconds,const DeepCollectionEquality().hash(_bidIncrementSlabs));

@override
String toString() {
  return 'RoundConfig(roundNumber: $roundNumber, name: $name, currencyType: $currencyType, purseAmount: $purseAmount, purseSource: $purseSource, bidMode: $bidMode, playerPoolSource: $playerPoolSource, franchiseEligibilityRule: $franchiseEligibilityRule, completionTrigger: $completionTrigger, countdownSeconds: $countdownSeconds, antiSnipeSeconds: $antiSnipeSeconds, bidIncrementSlabs: $bidIncrementSlabs)';
}


}

/// @nodoc
abstract mixin class _$RoundConfigCopyWith<$Res> implements $RoundConfigCopyWith<$Res> {
  factory _$RoundConfigCopyWith(_RoundConfig value, $Res Function(_RoundConfig) _then) = __$RoundConfigCopyWithImpl;
@override @useResult
$Res call({
 int roundNumber, String? name,@JsonKey(unknownEnumValue: CurrencyType.unknown) CurrencyType currencyType, int? purseAmount,@JsonKey(unknownEnumValue: PurseSource.unknown) PurseSource purseSource,@JsonKey(unknownEnumValue: BidMode.unknown) BidMode bidMode,@JsonKey(unknownEnumValue: PlayerPoolSource.unknown) PlayerPoolSource playerPoolSource,@JsonKey(unknownEnumValue: FranchiseEligibilityRule.unknown) FranchiseEligibilityRule franchiseEligibilityRule,@JsonKey(unknownEnumValue: CompletionTrigger.unknown) CompletionTrigger completionTrigger, int? countdownSeconds, int? antiSnipeSeconds, List<BidIncrementSlab> bidIncrementSlabs
});




}
/// @nodoc
class __$RoundConfigCopyWithImpl<$Res>
    implements _$RoundConfigCopyWith<$Res> {
  __$RoundConfigCopyWithImpl(this._self, this._then);

  final _RoundConfig _self;
  final $Res Function(_RoundConfig) _then;

/// Create a copy of RoundConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roundNumber = null,Object? name = freezed,Object? currencyType = null,Object? purseAmount = freezed,Object? purseSource = null,Object? bidMode = null,Object? playerPoolSource = null,Object? franchiseEligibilityRule = null,Object? completionTrigger = null,Object? countdownSeconds = freezed,Object? antiSnipeSeconds = freezed,Object? bidIncrementSlabs = null,}) {
  return _then(_RoundConfig(
roundNumber: null == roundNumber ? _self.roundNumber : roundNumber // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,currencyType: null == currencyType ? _self.currencyType : currencyType // ignore: cast_nullable_to_non_nullable
as CurrencyType,purseAmount: freezed == purseAmount ? _self.purseAmount : purseAmount // ignore: cast_nullable_to_non_nullable
as int?,purseSource: null == purseSource ? _self.purseSource : purseSource // ignore: cast_nullable_to_non_nullable
as PurseSource,bidMode: null == bidMode ? _self.bidMode : bidMode // ignore: cast_nullable_to_non_nullable
as BidMode,playerPoolSource: null == playerPoolSource ? _self.playerPoolSource : playerPoolSource // ignore: cast_nullable_to_non_nullable
as PlayerPoolSource,franchiseEligibilityRule: null == franchiseEligibilityRule ? _self.franchiseEligibilityRule : franchiseEligibilityRule // ignore: cast_nullable_to_non_nullable
as FranchiseEligibilityRule,completionTrigger: null == completionTrigger ? _self.completionTrigger : completionTrigger // ignore: cast_nullable_to_non_nullable
as CompletionTrigger,countdownSeconds: freezed == countdownSeconds ? _self.countdownSeconds : countdownSeconds // ignore: cast_nullable_to_non_nullable
as int?,antiSnipeSeconds: freezed == antiSnipeSeconds ? _self.antiSnipeSeconds : antiSnipeSeconds // ignore: cast_nullable_to_non_nullable
as int?,bidIncrementSlabs: null == bidIncrementSlabs ? _self._bidIncrementSlabs : bidIncrementSlabs // ignore: cast_nullable_to_non_nullable
as List<BidIncrementSlab>,
  ));
}


}


/// @nodoc
mixin _$PlayerAuctionState {

 String get id; String get auctionId; String get leaguePlayerId;@JsonKey(unknownEnumValue: PlayerAuctionStateValue.unknown) PlayerAuctionStateValue get state; int? get currentHighestBid; String? get currentHighestBidderId; int? get finalPrice; String? get soldToFranchiseId; String? get playerName; String? get playerCategory; int? get basePrice; String? get playerPhoto;
/// Create a copy of PlayerAuctionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerAuctionStateCopyWith<PlayerAuctionState> get copyWith => _$PlayerAuctionStateCopyWithImpl<PlayerAuctionState>(this as PlayerAuctionState, _$identity);

  /// Serializes this PlayerAuctionState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerAuctionState&&(identical(other.id, id) || other.id == id)&&(identical(other.auctionId, auctionId) || other.auctionId == auctionId)&&(identical(other.leaguePlayerId, leaguePlayerId) || other.leaguePlayerId == leaguePlayerId)&&(identical(other.state, state) || other.state == state)&&(identical(other.currentHighestBid, currentHighestBid) || other.currentHighestBid == currentHighestBid)&&(identical(other.currentHighestBidderId, currentHighestBidderId) || other.currentHighestBidderId == currentHighestBidderId)&&(identical(other.finalPrice, finalPrice) || other.finalPrice == finalPrice)&&(identical(other.soldToFranchiseId, soldToFranchiseId) || other.soldToFranchiseId == soldToFranchiseId)&&(identical(other.playerName, playerName) || other.playerName == playerName)&&(identical(other.playerCategory, playerCategory) || other.playerCategory == playerCategory)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.playerPhoto, playerPhoto) || other.playerPhoto == playerPhoto));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,auctionId,leaguePlayerId,state,currentHighestBid,currentHighestBidderId,finalPrice,soldToFranchiseId,playerName,playerCategory,basePrice,playerPhoto);

@override
String toString() {
  return 'PlayerAuctionState(id: $id, auctionId: $auctionId, leaguePlayerId: $leaguePlayerId, state: $state, currentHighestBid: $currentHighestBid, currentHighestBidderId: $currentHighestBidderId, finalPrice: $finalPrice, soldToFranchiseId: $soldToFranchiseId, playerName: $playerName, playerCategory: $playerCategory, basePrice: $basePrice, playerPhoto: $playerPhoto)';
}


}

/// @nodoc
abstract mixin class $PlayerAuctionStateCopyWith<$Res>  {
  factory $PlayerAuctionStateCopyWith(PlayerAuctionState value, $Res Function(PlayerAuctionState) _then) = _$PlayerAuctionStateCopyWithImpl;
@useResult
$Res call({
 String id, String auctionId, String leaguePlayerId,@JsonKey(unknownEnumValue: PlayerAuctionStateValue.unknown) PlayerAuctionStateValue state, int? currentHighestBid, String? currentHighestBidderId, int? finalPrice, String? soldToFranchiseId, String? playerName, String? playerCategory, int? basePrice, String? playerPhoto
});




}
/// @nodoc
class _$PlayerAuctionStateCopyWithImpl<$Res>
    implements $PlayerAuctionStateCopyWith<$Res> {
  _$PlayerAuctionStateCopyWithImpl(this._self, this._then);

  final PlayerAuctionState _self;
  final $Res Function(PlayerAuctionState) _then;

/// Create a copy of PlayerAuctionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? auctionId = null,Object? leaguePlayerId = null,Object? state = null,Object? currentHighestBid = freezed,Object? currentHighestBidderId = freezed,Object? finalPrice = freezed,Object? soldToFranchiseId = freezed,Object? playerName = freezed,Object? playerCategory = freezed,Object? basePrice = freezed,Object? playerPhoto = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,auctionId: null == auctionId ? _self.auctionId : auctionId // ignore: cast_nullable_to_non_nullable
as String,leaguePlayerId: null == leaguePlayerId ? _self.leaguePlayerId : leaguePlayerId // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as PlayerAuctionStateValue,currentHighestBid: freezed == currentHighestBid ? _self.currentHighestBid : currentHighestBid // ignore: cast_nullable_to_non_nullable
as int?,currentHighestBidderId: freezed == currentHighestBidderId ? _self.currentHighestBidderId : currentHighestBidderId // ignore: cast_nullable_to_non_nullable
as String?,finalPrice: freezed == finalPrice ? _self.finalPrice : finalPrice // ignore: cast_nullable_to_non_nullable
as int?,soldToFranchiseId: freezed == soldToFranchiseId ? _self.soldToFranchiseId : soldToFranchiseId // ignore: cast_nullable_to_non_nullable
as String?,playerName: freezed == playerName ? _self.playerName : playerName // ignore: cast_nullable_to_non_nullable
as String?,playerCategory: freezed == playerCategory ? _self.playerCategory : playerCategory // ignore: cast_nullable_to_non_nullable
as String?,basePrice: freezed == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as int?,playerPhoto: freezed == playerPhoto ? _self.playerPhoto : playerPhoto // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerAuctionState].
extension PlayerAuctionStatePatterns on PlayerAuctionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerAuctionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerAuctionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerAuctionState value)  $default,){
final _that = this;
switch (_that) {
case _PlayerAuctionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerAuctionState value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerAuctionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String auctionId,  String leaguePlayerId, @JsonKey(unknownEnumValue: PlayerAuctionStateValue.unknown)  PlayerAuctionStateValue state,  int? currentHighestBid,  String? currentHighestBidderId,  int? finalPrice,  String? soldToFranchiseId,  String? playerName,  String? playerCategory,  int? basePrice,  String? playerPhoto)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerAuctionState() when $default != null:
return $default(_that.id,_that.auctionId,_that.leaguePlayerId,_that.state,_that.currentHighestBid,_that.currentHighestBidderId,_that.finalPrice,_that.soldToFranchiseId,_that.playerName,_that.playerCategory,_that.basePrice,_that.playerPhoto);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String auctionId,  String leaguePlayerId, @JsonKey(unknownEnumValue: PlayerAuctionStateValue.unknown)  PlayerAuctionStateValue state,  int? currentHighestBid,  String? currentHighestBidderId,  int? finalPrice,  String? soldToFranchiseId,  String? playerName,  String? playerCategory,  int? basePrice,  String? playerPhoto)  $default,) {final _that = this;
switch (_that) {
case _PlayerAuctionState():
return $default(_that.id,_that.auctionId,_that.leaguePlayerId,_that.state,_that.currentHighestBid,_that.currentHighestBidderId,_that.finalPrice,_that.soldToFranchiseId,_that.playerName,_that.playerCategory,_that.basePrice,_that.playerPhoto);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String auctionId,  String leaguePlayerId, @JsonKey(unknownEnumValue: PlayerAuctionStateValue.unknown)  PlayerAuctionStateValue state,  int? currentHighestBid,  String? currentHighestBidderId,  int? finalPrice,  String? soldToFranchiseId,  String? playerName,  String? playerCategory,  int? basePrice,  String? playerPhoto)?  $default,) {final _that = this;
switch (_that) {
case _PlayerAuctionState() when $default != null:
return $default(_that.id,_that.auctionId,_that.leaguePlayerId,_that.state,_that.currentHighestBid,_that.currentHighestBidderId,_that.finalPrice,_that.soldToFranchiseId,_that.playerName,_that.playerCategory,_that.basePrice,_that.playerPhoto);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayerAuctionState implements PlayerAuctionState {
  const _PlayerAuctionState({required this.id, required this.auctionId, required this.leaguePlayerId, @JsonKey(unknownEnumValue: PlayerAuctionStateValue.unknown) required this.state, this.currentHighestBid, this.currentHighestBidderId, this.finalPrice, this.soldToFranchiseId, this.playerName, this.playerCategory, this.basePrice, this.playerPhoto});
  factory _PlayerAuctionState.fromJson(Map<String, dynamic> json) => _$PlayerAuctionStateFromJson(json);

@override final  String id;
@override final  String auctionId;
@override final  String leaguePlayerId;
@override@JsonKey(unknownEnumValue: PlayerAuctionStateValue.unknown) final  PlayerAuctionStateValue state;
@override final  int? currentHighestBid;
@override final  String? currentHighestBidderId;
@override final  int? finalPrice;
@override final  String? soldToFranchiseId;
@override final  String? playerName;
@override final  String? playerCategory;
@override final  int? basePrice;
@override final  String? playerPhoto;

/// Create a copy of PlayerAuctionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerAuctionStateCopyWith<_PlayerAuctionState> get copyWith => __$PlayerAuctionStateCopyWithImpl<_PlayerAuctionState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerAuctionStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerAuctionState&&(identical(other.id, id) || other.id == id)&&(identical(other.auctionId, auctionId) || other.auctionId == auctionId)&&(identical(other.leaguePlayerId, leaguePlayerId) || other.leaguePlayerId == leaguePlayerId)&&(identical(other.state, state) || other.state == state)&&(identical(other.currentHighestBid, currentHighestBid) || other.currentHighestBid == currentHighestBid)&&(identical(other.currentHighestBidderId, currentHighestBidderId) || other.currentHighestBidderId == currentHighestBidderId)&&(identical(other.finalPrice, finalPrice) || other.finalPrice == finalPrice)&&(identical(other.soldToFranchiseId, soldToFranchiseId) || other.soldToFranchiseId == soldToFranchiseId)&&(identical(other.playerName, playerName) || other.playerName == playerName)&&(identical(other.playerCategory, playerCategory) || other.playerCategory == playerCategory)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.playerPhoto, playerPhoto) || other.playerPhoto == playerPhoto));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,auctionId,leaguePlayerId,state,currentHighestBid,currentHighestBidderId,finalPrice,soldToFranchiseId,playerName,playerCategory,basePrice,playerPhoto);

@override
String toString() {
  return 'PlayerAuctionState(id: $id, auctionId: $auctionId, leaguePlayerId: $leaguePlayerId, state: $state, currentHighestBid: $currentHighestBid, currentHighestBidderId: $currentHighestBidderId, finalPrice: $finalPrice, soldToFranchiseId: $soldToFranchiseId, playerName: $playerName, playerCategory: $playerCategory, basePrice: $basePrice, playerPhoto: $playerPhoto)';
}


}

/// @nodoc
abstract mixin class _$PlayerAuctionStateCopyWith<$Res> implements $PlayerAuctionStateCopyWith<$Res> {
  factory _$PlayerAuctionStateCopyWith(_PlayerAuctionState value, $Res Function(_PlayerAuctionState) _then) = __$PlayerAuctionStateCopyWithImpl;
@override @useResult
$Res call({
 String id, String auctionId, String leaguePlayerId,@JsonKey(unknownEnumValue: PlayerAuctionStateValue.unknown) PlayerAuctionStateValue state, int? currentHighestBid, String? currentHighestBidderId, int? finalPrice, String? soldToFranchiseId, String? playerName, String? playerCategory, int? basePrice, String? playerPhoto
});




}
/// @nodoc
class __$PlayerAuctionStateCopyWithImpl<$Res>
    implements _$PlayerAuctionStateCopyWith<$Res> {
  __$PlayerAuctionStateCopyWithImpl(this._self, this._then);

  final _PlayerAuctionState _self;
  final $Res Function(_PlayerAuctionState) _then;

/// Create a copy of PlayerAuctionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? auctionId = null,Object? leaguePlayerId = null,Object? state = null,Object? currentHighestBid = freezed,Object? currentHighestBidderId = freezed,Object? finalPrice = freezed,Object? soldToFranchiseId = freezed,Object? playerName = freezed,Object? playerCategory = freezed,Object? basePrice = freezed,Object? playerPhoto = freezed,}) {
  return _then(_PlayerAuctionState(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,auctionId: null == auctionId ? _self.auctionId : auctionId // ignore: cast_nullable_to_non_nullable
as String,leaguePlayerId: null == leaguePlayerId ? _self.leaguePlayerId : leaguePlayerId // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as PlayerAuctionStateValue,currentHighestBid: freezed == currentHighestBid ? _self.currentHighestBid : currentHighestBid // ignore: cast_nullable_to_non_nullable
as int?,currentHighestBidderId: freezed == currentHighestBidderId ? _self.currentHighestBidderId : currentHighestBidderId // ignore: cast_nullable_to_non_nullable
as String?,finalPrice: freezed == finalPrice ? _self.finalPrice : finalPrice // ignore: cast_nullable_to_non_nullable
as int?,soldToFranchiseId: freezed == soldToFranchiseId ? _self.soldToFranchiseId : soldToFranchiseId // ignore: cast_nullable_to_non_nullable
as String?,playerName: freezed == playerName ? _self.playerName : playerName // ignore: cast_nullable_to_non_nullable
as String?,playerCategory: freezed == playerCategory ? _self.playerCategory : playerCategory // ignore: cast_nullable_to_non_nullable
as String?,basePrice: freezed == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as int?,playerPhoto: freezed == playerPhoto ? _self.playerPhoto : playerPhoto // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$FranchisePurseState {

 String get id; String get franchiseId; String? get roundId;@JsonKey(unknownEnumValue: CurrencyType.unknown) CurrencyType? get currencyType; int? get startingAmount; int get currentAmount; int get reservedAmount; String? get franchiseName; String? get franchiseLogoUrl;
/// Create a copy of FranchisePurseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FranchisePurseStateCopyWith<FranchisePurseState> get copyWith => _$FranchisePurseStateCopyWithImpl<FranchisePurseState>(this as FranchisePurseState, _$identity);

  /// Serializes this FranchisePurseState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FranchisePurseState&&(identical(other.id, id) || other.id == id)&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.roundId, roundId) || other.roundId == roundId)&&(identical(other.currencyType, currencyType) || other.currencyType == currencyType)&&(identical(other.startingAmount, startingAmount) || other.startingAmount == startingAmount)&&(identical(other.currentAmount, currentAmount) || other.currentAmount == currentAmount)&&(identical(other.reservedAmount, reservedAmount) || other.reservedAmount == reservedAmount)&&(identical(other.franchiseName, franchiseName) || other.franchiseName == franchiseName)&&(identical(other.franchiseLogoUrl, franchiseLogoUrl) || other.franchiseLogoUrl == franchiseLogoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,franchiseId,roundId,currencyType,startingAmount,currentAmount,reservedAmount,franchiseName,franchiseLogoUrl);

@override
String toString() {
  return 'FranchisePurseState(id: $id, franchiseId: $franchiseId, roundId: $roundId, currencyType: $currencyType, startingAmount: $startingAmount, currentAmount: $currentAmount, reservedAmount: $reservedAmount, franchiseName: $franchiseName, franchiseLogoUrl: $franchiseLogoUrl)';
}


}

/// @nodoc
abstract mixin class $FranchisePurseStateCopyWith<$Res>  {
  factory $FranchisePurseStateCopyWith(FranchisePurseState value, $Res Function(FranchisePurseState) _then) = _$FranchisePurseStateCopyWithImpl;
@useResult
$Res call({
 String id, String franchiseId, String? roundId,@JsonKey(unknownEnumValue: CurrencyType.unknown) CurrencyType? currencyType, int? startingAmount, int currentAmount, int reservedAmount, String? franchiseName, String? franchiseLogoUrl
});




}
/// @nodoc
class _$FranchisePurseStateCopyWithImpl<$Res>
    implements $FranchisePurseStateCopyWith<$Res> {
  _$FranchisePurseStateCopyWithImpl(this._self, this._then);

  final FranchisePurseState _self;
  final $Res Function(FranchisePurseState) _then;

/// Create a copy of FranchisePurseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? franchiseId = null,Object? roundId = freezed,Object? currencyType = freezed,Object? startingAmount = freezed,Object? currentAmount = null,Object? reservedAmount = null,Object? franchiseName = freezed,Object? franchiseLogoUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,franchiseId: null == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String,roundId: freezed == roundId ? _self.roundId : roundId // ignore: cast_nullable_to_non_nullable
as String?,currencyType: freezed == currencyType ? _self.currencyType : currencyType // ignore: cast_nullable_to_non_nullable
as CurrencyType?,startingAmount: freezed == startingAmount ? _self.startingAmount : startingAmount // ignore: cast_nullable_to_non_nullable
as int?,currentAmount: null == currentAmount ? _self.currentAmount : currentAmount // ignore: cast_nullable_to_non_nullable
as int,reservedAmount: null == reservedAmount ? _self.reservedAmount : reservedAmount // ignore: cast_nullable_to_non_nullable
as int,franchiseName: freezed == franchiseName ? _self.franchiseName : franchiseName // ignore: cast_nullable_to_non_nullable
as String?,franchiseLogoUrl: freezed == franchiseLogoUrl ? _self.franchiseLogoUrl : franchiseLogoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FranchisePurseState].
extension FranchisePurseStatePatterns on FranchisePurseState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FranchisePurseState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FranchisePurseState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FranchisePurseState value)  $default,){
final _that = this;
switch (_that) {
case _FranchisePurseState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FranchisePurseState value)?  $default,){
final _that = this;
switch (_that) {
case _FranchisePurseState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String franchiseId,  String? roundId, @JsonKey(unknownEnumValue: CurrencyType.unknown)  CurrencyType? currencyType,  int? startingAmount,  int currentAmount,  int reservedAmount,  String? franchiseName,  String? franchiseLogoUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FranchisePurseState() when $default != null:
return $default(_that.id,_that.franchiseId,_that.roundId,_that.currencyType,_that.startingAmount,_that.currentAmount,_that.reservedAmount,_that.franchiseName,_that.franchiseLogoUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String franchiseId,  String? roundId, @JsonKey(unknownEnumValue: CurrencyType.unknown)  CurrencyType? currencyType,  int? startingAmount,  int currentAmount,  int reservedAmount,  String? franchiseName,  String? franchiseLogoUrl)  $default,) {final _that = this;
switch (_that) {
case _FranchisePurseState():
return $default(_that.id,_that.franchiseId,_that.roundId,_that.currencyType,_that.startingAmount,_that.currentAmount,_that.reservedAmount,_that.franchiseName,_that.franchiseLogoUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String franchiseId,  String? roundId, @JsonKey(unknownEnumValue: CurrencyType.unknown)  CurrencyType? currencyType,  int? startingAmount,  int currentAmount,  int reservedAmount,  String? franchiseName,  String? franchiseLogoUrl)?  $default,) {final _that = this;
switch (_that) {
case _FranchisePurseState() when $default != null:
return $default(_that.id,_that.franchiseId,_that.roundId,_that.currencyType,_that.startingAmount,_that.currentAmount,_that.reservedAmount,_that.franchiseName,_that.franchiseLogoUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FranchisePurseState implements FranchisePurseState {
  const _FranchisePurseState({required this.id, required this.franchiseId, this.roundId, @JsonKey(unknownEnumValue: CurrencyType.unknown) this.currencyType, this.startingAmount, required this.currentAmount, required this.reservedAmount, this.franchiseName, this.franchiseLogoUrl});
  factory _FranchisePurseState.fromJson(Map<String, dynamic> json) => _$FranchisePurseStateFromJson(json);

@override final  String id;
@override final  String franchiseId;
@override final  String? roundId;
@override@JsonKey(unknownEnumValue: CurrencyType.unknown) final  CurrencyType? currencyType;
@override final  int? startingAmount;
@override final  int currentAmount;
@override final  int reservedAmount;
@override final  String? franchiseName;
@override final  String? franchiseLogoUrl;

/// Create a copy of FranchisePurseState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FranchisePurseStateCopyWith<_FranchisePurseState> get copyWith => __$FranchisePurseStateCopyWithImpl<_FranchisePurseState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FranchisePurseStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FranchisePurseState&&(identical(other.id, id) || other.id == id)&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.roundId, roundId) || other.roundId == roundId)&&(identical(other.currencyType, currencyType) || other.currencyType == currencyType)&&(identical(other.startingAmount, startingAmount) || other.startingAmount == startingAmount)&&(identical(other.currentAmount, currentAmount) || other.currentAmount == currentAmount)&&(identical(other.reservedAmount, reservedAmount) || other.reservedAmount == reservedAmount)&&(identical(other.franchiseName, franchiseName) || other.franchiseName == franchiseName)&&(identical(other.franchiseLogoUrl, franchiseLogoUrl) || other.franchiseLogoUrl == franchiseLogoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,franchiseId,roundId,currencyType,startingAmount,currentAmount,reservedAmount,franchiseName,franchiseLogoUrl);

@override
String toString() {
  return 'FranchisePurseState(id: $id, franchiseId: $franchiseId, roundId: $roundId, currencyType: $currencyType, startingAmount: $startingAmount, currentAmount: $currentAmount, reservedAmount: $reservedAmount, franchiseName: $franchiseName, franchiseLogoUrl: $franchiseLogoUrl)';
}


}

/// @nodoc
abstract mixin class _$FranchisePurseStateCopyWith<$Res> implements $FranchisePurseStateCopyWith<$Res> {
  factory _$FranchisePurseStateCopyWith(_FranchisePurseState value, $Res Function(_FranchisePurseState) _then) = __$FranchisePurseStateCopyWithImpl;
@override @useResult
$Res call({
 String id, String franchiseId, String? roundId,@JsonKey(unknownEnumValue: CurrencyType.unknown) CurrencyType? currencyType, int? startingAmount, int currentAmount, int reservedAmount, String? franchiseName, String? franchiseLogoUrl
});




}
/// @nodoc
class __$FranchisePurseStateCopyWithImpl<$Res>
    implements _$FranchisePurseStateCopyWith<$Res> {
  __$FranchisePurseStateCopyWithImpl(this._self, this._then);

  final _FranchisePurseState _self;
  final $Res Function(_FranchisePurseState) _then;

/// Create a copy of FranchisePurseState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? franchiseId = null,Object? roundId = freezed,Object? currencyType = freezed,Object? startingAmount = freezed,Object? currentAmount = null,Object? reservedAmount = null,Object? franchiseName = freezed,Object? franchiseLogoUrl = freezed,}) {
  return _then(_FranchisePurseState(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,franchiseId: null == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String,roundId: freezed == roundId ? _self.roundId : roundId // ignore: cast_nullable_to_non_nullable
as String?,currencyType: freezed == currencyType ? _self.currencyType : currencyType // ignore: cast_nullable_to_non_nullable
as CurrencyType?,startingAmount: freezed == startingAmount ? _self.startingAmount : startingAmount // ignore: cast_nullable_to_non_nullable
as int?,currentAmount: null == currentAmount ? _self.currentAmount : currentAmount // ignore: cast_nullable_to_non_nullable
as int,reservedAmount: null == reservedAmount ? _self.reservedAmount : reservedAmount // ignore: cast_nullable_to_non_nullable
as int,franchiseName: freezed == franchiseName ? _self.franchiseName : franchiseName // ignore: cast_nullable_to_non_nullable
as String?,franchiseLogoUrl: freezed == franchiseLogoUrl ? _self.franchiseLogoUrl : franchiseLogoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TimerState {

 bool get isRunning; DateTime? get startedAt; int? get durationSeconds; int? get remainingSeconds; int get antiSnipeSeconds;
/// Create a copy of TimerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimerStateCopyWith<TimerState> get copyWith => _$TimerStateCopyWithImpl<TimerState>(this as TimerState, _$identity);

  /// Serializes this TimerState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimerState&&(identical(other.isRunning, isRunning) || other.isRunning == isRunning)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.remainingSeconds, remainingSeconds) || other.remainingSeconds == remainingSeconds)&&(identical(other.antiSnipeSeconds, antiSnipeSeconds) || other.antiSnipeSeconds == antiSnipeSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isRunning,startedAt,durationSeconds,remainingSeconds,antiSnipeSeconds);

@override
String toString() {
  return 'TimerState(isRunning: $isRunning, startedAt: $startedAt, durationSeconds: $durationSeconds, remainingSeconds: $remainingSeconds, antiSnipeSeconds: $antiSnipeSeconds)';
}


}

/// @nodoc
abstract mixin class $TimerStateCopyWith<$Res>  {
  factory $TimerStateCopyWith(TimerState value, $Res Function(TimerState) _then) = _$TimerStateCopyWithImpl;
@useResult
$Res call({
 bool isRunning, DateTime? startedAt, int? durationSeconds, int? remainingSeconds, int antiSnipeSeconds
});




}
/// @nodoc
class _$TimerStateCopyWithImpl<$Res>
    implements $TimerStateCopyWith<$Res> {
  _$TimerStateCopyWithImpl(this._self, this._then);

  final TimerState _self;
  final $Res Function(TimerState) _then;

/// Create a copy of TimerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isRunning = null,Object? startedAt = freezed,Object? durationSeconds = freezed,Object? remainingSeconds = freezed,Object? antiSnipeSeconds = null,}) {
  return _then(_self.copyWith(
isRunning: null == isRunning ? _self.isRunning : isRunning // ignore: cast_nullable_to_non_nullable
as bool,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,remainingSeconds: freezed == remainingSeconds ? _self.remainingSeconds : remainingSeconds // ignore: cast_nullable_to_non_nullable
as int?,antiSnipeSeconds: null == antiSnipeSeconds ? _self.antiSnipeSeconds : antiSnipeSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TimerState].
extension TimerStatePatterns on TimerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimerState value)  $default,){
final _that = this;
switch (_that) {
case _TimerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimerState value)?  $default,){
final _that = this;
switch (_that) {
case _TimerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isRunning,  DateTime? startedAt,  int? durationSeconds,  int? remainingSeconds,  int antiSnipeSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimerState() when $default != null:
return $default(_that.isRunning,_that.startedAt,_that.durationSeconds,_that.remainingSeconds,_that.antiSnipeSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isRunning,  DateTime? startedAt,  int? durationSeconds,  int? remainingSeconds,  int antiSnipeSeconds)  $default,) {final _that = this;
switch (_that) {
case _TimerState():
return $default(_that.isRunning,_that.startedAt,_that.durationSeconds,_that.remainingSeconds,_that.antiSnipeSeconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isRunning,  DateTime? startedAt,  int? durationSeconds,  int? remainingSeconds,  int antiSnipeSeconds)?  $default,) {final _that = this;
switch (_that) {
case _TimerState() when $default != null:
return $default(_that.isRunning,_that.startedAt,_that.durationSeconds,_that.remainingSeconds,_that.antiSnipeSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TimerState implements TimerState {
  const _TimerState({required this.isRunning, this.startedAt, this.durationSeconds, this.remainingSeconds, required this.antiSnipeSeconds});
  factory _TimerState.fromJson(Map<String, dynamic> json) => _$TimerStateFromJson(json);

@override final  bool isRunning;
@override final  DateTime? startedAt;
@override final  int? durationSeconds;
@override final  int? remainingSeconds;
@override final  int antiSnipeSeconds;

/// Create a copy of TimerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimerStateCopyWith<_TimerState> get copyWith => __$TimerStateCopyWithImpl<_TimerState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimerStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimerState&&(identical(other.isRunning, isRunning) || other.isRunning == isRunning)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.remainingSeconds, remainingSeconds) || other.remainingSeconds == remainingSeconds)&&(identical(other.antiSnipeSeconds, antiSnipeSeconds) || other.antiSnipeSeconds == antiSnipeSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isRunning,startedAt,durationSeconds,remainingSeconds,antiSnipeSeconds);

@override
String toString() {
  return 'TimerState(isRunning: $isRunning, startedAt: $startedAt, durationSeconds: $durationSeconds, remainingSeconds: $remainingSeconds, antiSnipeSeconds: $antiSnipeSeconds)';
}


}

/// @nodoc
abstract mixin class _$TimerStateCopyWith<$Res> implements $TimerStateCopyWith<$Res> {
  factory _$TimerStateCopyWith(_TimerState value, $Res Function(_TimerState) _then) = __$TimerStateCopyWithImpl;
@override @useResult
$Res call({
 bool isRunning, DateTime? startedAt, int? durationSeconds, int? remainingSeconds, int antiSnipeSeconds
});




}
/// @nodoc
class __$TimerStateCopyWithImpl<$Res>
    implements _$TimerStateCopyWith<$Res> {
  __$TimerStateCopyWithImpl(this._self, this._then);

  final _TimerState _self;
  final $Res Function(_TimerState) _then;

/// Create a copy of TimerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isRunning = null,Object? startedAt = freezed,Object? durationSeconds = freezed,Object? remainingSeconds = freezed,Object? antiSnipeSeconds = null,}) {
  return _then(_TimerState(
isRunning: null == isRunning ? _self.isRunning : isRunning // ignore: cast_nullable_to_non_nullable
as bool,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,remainingSeconds: freezed == remainingSeconds ? _self.remainingSeconds : remainingSeconds // ignore: cast_nullable_to_non_nullable
as int?,antiSnipeSeconds: null == antiSnipeSeconds ? _self.antiSnipeSeconds : antiSnipeSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$AuctionStateSnapshot {

 String get leagueName;@JsonKey(unknownEnumValue: AuctionStatus.unknown) AuctionStatus get auctionStatus; RoundConfig? get currentRound; PlayerAuctionState? get currentPlayer; int? get currentHighestBid; String? get currentHighestBidderId; List<FranchisePurseState> get franchisePurseStates; TimerState? get timer; int get lastSequenceNumber;
/// Create a copy of AuctionStateSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuctionStateSnapshotCopyWith<AuctionStateSnapshot> get copyWith => _$AuctionStateSnapshotCopyWithImpl<AuctionStateSnapshot>(this as AuctionStateSnapshot, _$identity);

  /// Serializes this AuctionStateSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuctionStateSnapshot&&(identical(other.leagueName, leagueName) || other.leagueName == leagueName)&&(identical(other.auctionStatus, auctionStatus) || other.auctionStatus == auctionStatus)&&(identical(other.currentRound, currentRound) || other.currentRound == currentRound)&&(identical(other.currentPlayer, currentPlayer) || other.currentPlayer == currentPlayer)&&(identical(other.currentHighestBid, currentHighestBid) || other.currentHighestBid == currentHighestBid)&&(identical(other.currentHighestBidderId, currentHighestBidderId) || other.currentHighestBidderId == currentHighestBidderId)&&const DeepCollectionEquality().equals(other.franchisePurseStates, franchisePurseStates)&&(identical(other.timer, timer) || other.timer == timer)&&(identical(other.lastSequenceNumber, lastSequenceNumber) || other.lastSequenceNumber == lastSequenceNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,leagueName,auctionStatus,currentRound,currentPlayer,currentHighestBid,currentHighestBidderId,const DeepCollectionEquality().hash(franchisePurseStates),timer,lastSequenceNumber);

@override
String toString() {
  return 'AuctionStateSnapshot(leagueName: $leagueName, auctionStatus: $auctionStatus, currentRound: $currentRound, currentPlayer: $currentPlayer, currentHighestBid: $currentHighestBid, currentHighestBidderId: $currentHighestBidderId, franchisePurseStates: $franchisePurseStates, timer: $timer, lastSequenceNumber: $lastSequenceNumber)';
}


}

/// @nodoc
abstract mixin class $AuctionStateSnapshotCopyWith<$Res>  {
  factory $AuctionStateSnapshotCopyWith(AuctionStateSnapshot value, $Res Function(AuctionStateSnapshot) _then) = _$AuctionStateSnapshotCopyWithImpl;
@useResult
$Res call({
 String leagueName,@JsonKey(unknownEnumValue: AuctionStatus.unknown) AuctionStatus auctionStatus, RoundConfig? currentRound, PlayerAuctionState? currentPlayer, int? currentHighestBid, String? currentHighestBidderId, List<FranchisePurseState> franchisePurseStates, TimerState? timer, int lastSequenceNumber
});


$RoundConfigCopyWith<$Res>? get currentRound;$PlayerAuctionStateCopyWith<$Res>? get currentPlayer;$TimerStateCopyWith<$Res>? get timer;

}
/// @nodoc
class _$AuctionStateSnapshotCopyWithImpl<$Res>
    implements $AuctionStateSnapshotCopyWith<$Res> {
  _$AuctionStateSnapshotCopyWithImpl(this._self, this._then);

  final AuctionStateSnapshot _self;
  final $Res Function(AuctionStateSnapshot) _then;

/// Create a copy of AuctionStateSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? leagueName = null,Object? auctionStatus = null,Object? currentRound = freezed,Object? currentPlayer = freezed,Object? currentHighestBid = freezed,Object? currentHighestBidderId = freezed,Object? franchisePurseStates = null,Object? timer = freezed,Object? lastSequenceNumber = null,}) {
  return _then(_self.copyWith(
leagueName: null == leagueName ? _self.leagueName : leagueName // ignore: cast_nullable_to_non_nullable
as String,auctionStatus: null == auctionStatus ? _self.auctionStatus : auctionStatus // ignore: cast_nullable_to_non_nullable
as AuctionStatus,currentRound: freezed == currentRound ? _self.currentRound : currentRound // ignore: cast_nullable_to_non_nullable
as RoundConfig?,currentPlayer: freezed == currentPlayer ? _self.currentPlayer : currentPlayer // ignore: cast_nullable_to_non_nullable
as PlayerAuctionState?,currentHighestBid: freezed == currentHighestBid ? _self.currentHighestBid : currentHighestBid // ignore: cast_nullable_to_non_nullable
as int?,currentHighestBidderId: freezed == currentHighestBidderId ? _self.currentHighestBidderId : currentHighestBidderId // ignore: cast_nullable_to_non_nullable
as String?,franchisePurseStates: null == franchisePurseStates ? _self.franchisePurseStates : franchisePurseStates // ignore: cast_nullable_to_non_nullable
as List<FranchisePurseState>,timer: freezed == timer ? _self.timer : timer // ignore: cast_nullable_to_non_nullable
as TimerState?,lastSequenceNumber: null == lastSequenceNumber ? _self.lastSequenceNumber : lastSequenceNumber // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of AuctionStateSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoundConfigCopyWith<$Res>? get currentRound {
    if (_self.currentRound == null) {
    return null;
  }

  return $RoundConfigCopyWith<$Res>(_self.currentRound!, (value) {
    return _then(_self.copyWith(currentRound: value));
  });
}/// Create a copy of AuctionStateSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerAuctionStateCopyWith<$Res>? get currentPlayer {
    if (_self.currentPlayer == null) {
    return null;
  }

  return $PlayerAuctionStateCopyWith<$Res>(_self.currentPlayer!, (value) {
    return _then(_self.copyWith(currentPlayer: value));
  });
}/// Create a copy of AuctionStateSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimerStateCopyWith<$Res>? get timer {
    if (_self.timer == null) {
    return null;
  }

  return $TimerStateCopyWith<$Res>(_self.timer!, (value) {
    return _then(_self.copyWith(timer: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuctionStateSnapshot].
extension AuctionStateSnapshotPatterns on AuctionStateSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuctionStateSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuctionStateSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuctionStateSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _AuctionStateSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuctionStateSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _AuctionStateSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String leagueName, @JsonKey(unknownEnumValue: AuctionStatus.unknown)  AuctionStatus auctionStatus,  RoundConfig? currentRound,  PlayerAuctionState? currentPlayer,  int? currentHighestBid,  String? currentHighestBidderId,  List<FranchisePurseState> franchisePurseStates,  TimerState? timer,  int lastSequenceNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuctionStateSnapshot() when $default != null:
return $default(_that.leagueName,_that.auctionStatus,_that.currentRound,_that.currentPlayer,_that.currentHighestBid,_that.currentHighestBidderId,_that.franchisePurseStates,_that.timer,_that.lastSequenceNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String leagueName, @JsonKey(unknownEnumValue: AuctionStatus.unknown)  AuctionStatus auctionStatus,  RoundConfig? currentRound,  PlayerAuctionState? currentPlayer,  int? currentHighestBid,  String? currentHighestBidderId,  List<FranchisePurseState> franchisePurseStates,  TimerState? timer,  int lastSequenceNumber)  $default,) {final _that = this;
switch (_that) {
case _AuctionStateSnapshot():
return $default(_that.leagueName,_that.auctionStatus,_that.currentRound,_that.currentPlayer,_that.currentHighestBid,_that.currentHighestBidderId,_that.franchisePurseStates,_that.timer,_that.lastSequenceNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String leagueName, @JsonKey(unknownEnumValue: AuctionStatus.unknown)  AuctionStatus auctionStatus,  RoundConfig? currentRound,  PlayerAuctionState? currentPlayer,  int? currentHighestBid,  String? currentHighestBidderId,  List<FranchisePurseState> franchisePurseStates,  TimerState? timer,  int lastSequenceNumber)?  $default,) {final _that = this;
switch (_that) {
case _AuctionStateSnapshot() when $default != null:
return $default(_that.leagueName,_that.auctionStatus,_that.currentRound,_that.currentPlayer,_that.currentHighestBid,_that.currentHighestBidderId,_that.franchisePurseStates,_that.timer,_that.lastSequenceNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuctionStateSnapshot implements AuctionStateSnapshot {
  const _AuctionStateSnapshot({required this.leagueName, @JsonKey(unknownEnumValue: AuctionStatus.unknown) required this.auctionStatus, this.currentRound, this.currentPlayer, this.currentHighestBid, this.currentHighestBidderId, final  List<FranchisePurseState> franchisePurseStates = const <FranchisePurseState>[], this.timer, this.lastSequenceNumber = 0}): _franchisePurseStates = franchisePurseStates;
  factory _AuctionStateSnapshot.fromJson(Map<String, dynamic> json) => _$AuctionStateSnapshotFromJson(json);

@override final  String leagueName;
@override@JsonKey(unknownEnumValue: AuctionStatus.unknown) final  AuctionStatus auctionStatus;
@override final  RoundConfig? currentRound;
@override final  PlayerAuctionState? currentPlayer;
@override final  int? currentHighestBid;
@override final  String? currentHighestBidderId;
 final  List<FranchisePurseState> _franchisePurseStates;
@override@JsonKey() List<FranchisePurseState> get franchisePurseStates {
  if (_franchisePurseStates is EqualUnmodifiableListView) return _franchisePurseStates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_franchisePurseStates);
}

@override final  TimerState? timer;
@override@JsonKey() final  int lastSequenceNumber;

/// Create a copy of AuctionStateSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuctionStateSnapshotCopyWith<_AuctionStateSnapshot> get copyWith => __$AuctionStateSnapshotCopyWithImpl<_AuctionStateSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuctionStateSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuctionStateSnapshot&&(identical(other.leagueName, leagueName) || other.leagueName == leagueName)&&(identical(other.auctionStatus, auctionStatus) || other.auctionStatus == auctionStatus)&&(identical(other.currentRound, currentRound) || other.currentRound == currentRound)&&(identical(other.currentPlayer, currentPlayer) || other.currentPlayer == currentPlayer)&&(identical(other.currentHighestBid, currentHighestBid) || other.currentHighestBid == currentHighestBid)&&(identical(other.currentHighestBidderId, currentHighestBidderId) || other.currentHighestBidderId == currentHighestBidderId)&&const DeepCollectionEquality().equals(other._franchisePurseStates, _franchisePurseStates)&&(identical(other.timer, timer) || other.timer == timer)&&(identical(other.lastSequenceNumber, lastSequenceNumber) || other.lastSequenceNumber == lastSequenceNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,leagueName,auctionStatus,currentRound,currentPlayer,currentHighestBid,currentHighestBidderId,const DeepCollectionEquality().hash(_franchisePurseStates),timer,lastSequenceNumber);

@override
String toString() {
  return 'AuctionStateSnapshot(leagueName: $leagueName, auctionStatus: $auctionStatus, currentRound: $currentRound, currentPlayer: $currentPlayer, currentHighestBid: $currentHighestBid, currentHighestBidderId: $currentHighestBidderId, franchisePurseStates: $franchisePurseStates, timer: $timer, lastSequenceNumber: $lastSequenceNumber)';
}


}

/// @nodoc
abstract mixin class _$AuctionStateSnapshotCopyWith<$Res> implements $AuctionStateSnapshotCopyWith<$Res> {
  factory _$AuctionStateSnapshotCopyWith(_AuctionStateSnapshot value, $Res Function(_AuctionStateSnapshot) _then) = __$AuctionStateSnapshotCopyWithImpl;
@override @useResult
$Res call({
 String leagueName,@JsonKey(unknownEnumValue: AuctionStatus.unknown) AuctionStatus auctionStatus, RoundConfig? currentRound, PlayerAuctionState? currentPlayer, int? currentHighestBid, String? currentHighestBidderId, List<FranchisePurseState> franchisePurseStates, TimerState? timer, int lastSequenceNumber
});


@override $RoundConfigCopyWith<$Res>? get currentRound;@override $PlayerAuctionStateCopyWith<$Res>? get currentPlayer;@override $TimerStateCopyWith<$Res>? get timer;

}
/// @nodoc
class __$AuctionStateSnapshotCopyWithImpl<$Res>
    implements _$AuctionStateSnapshotCopyWith<$Res> {
  __$AuctionStateSnapshotCopyWithImpl(this._self, this._then);

  final _AuctionStateSnapshot _self;
  final $Res Function(_AuctionStateSnapshot) _then;

/// Create a copy of AuctionStateSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? leagueName = null,Object? auctionStatus = null,Object? currentRound = freezed,Object? currentPlayer = freezed,Object? currentHighestBid = freezed,Object? currentHighestBidderId = freezed,Object? franchisePurseStates = null,Object? timer = freezed,Object? lastSequenceNumber = null,}) {
  return _then(_AuctionStateSnapshot(
leagueName: null == leagueName ? _self.leagueName : leagueName // ignore: cast_nullable_to_non_nullable
as String,auctionStatus: null == auctionStatus ? _self.auctionStatus : auctionStatus // ignore: cast_nullable_to_non_nullable
as AuctionStatus,currentRound: freezed == currentRound ? _self.currentRound : currentRound // ignore: cast_nullable_to_non_nullable
as RoundConfig?,currentPlayer: freezed == currentPlayer ? _self.currentPlayer : currentPlayer // ignore: cast_nullable_to_non_nullable
as PlayerAuctionState?,currentHighestBid: freezed == currentHighestBid ? _self.currentHighestBid : currentHighestBid // ignore: cast_nullable_to_non_nullable
as int?,currentHighestBidderId: freezed == currentHighestBidderId ? _self.currentHighestBidderId : currentHighestBidderId // ignore: cast_nullable_to_non_nullable
as String?,franchisePurseStates: null == franchisePurseStates ? _self._franchisePurseStates : franchisePurseStates // ignore: cast_nullable_to_non_nullable
as List<FranchisePurseState>,timer: freezed == timer ? _self.timer : timer // ignore: cast_nullable_to_non_nullable
as TimerState?,lastSequenceNumber: null == lastSequenceNumber ? _self.lastSequenceNumber : lastSequenceNumber // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of AuctionStateSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoundConfigCopyWith<$Res>? get currentRound {
    if (_self.currentRound == null) {
    return null;
  }

  return $RoundConfigCopyWith<$Res>(_self.currentRound!, (value) {
    return _then(_self.copyWith(currentRound: value));
  });
}/// Create a copy of AuctionStateSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerAuctionStateCopyWith<$Res>? get currentPlayer {
    if (_self.currentPlayer == null) {
    return null;
  }

  return $PlayerAuctionStateCopyWith<$Res>(_self.currentPlayer!, (value) {
    return _then(_self.copyWith(currentPlayer: value));
  });
}/// Create a copy of AuctionStateSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimerStateCopyWith<$Res>? get timer {
    if (_self.timer == null) {
    return null;
  }

  return $TimerStateCopyWith<$Res>(_self.timer!, (value) {
    return _then(_self.copyWith(timer: value));
  });
}
}

// dart format on
