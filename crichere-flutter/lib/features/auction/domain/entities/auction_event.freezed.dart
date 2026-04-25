// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auction_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
AuctionEvent _$AuctionEventFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'playerUp':
          return PlayerUp.fromJson(
            json
          );
                case 'bidPlaced':
          return BidPlaced.fromJson(
            json
          );
                case 'playerSold':
          return PlayerSold.fromJson(
            json
          );
                case 'bidUndone':
          return BidUndone.fromJson(
            json
          );
                case 'soldReverted':
          return SoldReverted.fromJson(
            json
          );
                case 'playerUnsold':
          return PlayerUnsold.fromJson(
            json
          );
                case 'roundStarted':
          return RoundStarted.fromJson(
            json
          );
                case 'auctionStarted':
          return AuctionStarted.fromJson(
            json
          );
                case 'auctionCompleted':
          return AuctionCompleted.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'AuctionEvent',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$AuctionEvent {



  /// Serializes this AuctionEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuctionEvent);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuctionEvent()';
}


}

/// @nodoc
class $AuctionEventCopyWith<$Res>  {
$AuctionEventCopyWith(AuctionEvent _, $Res Function(AuctionEvent) __);
}


/// Adds pattern-matching-related methods to [AuctionEvent].
extension AuctionEventPatterns on AuctionEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PlayerUp value)?  playerUp,TResult Function( BidPlaced value)?  bidPlaced,TResult Function( PlayerSold value)?  playerSold,TResult Function( BidUndone value)?  bidUndone,TResult Function( SoldReverted value)?  soldReverted,TResult Function( PlayerUnsold value)?  playerUnsold,TResult Function( RoundStarted value)?  roundStarted,TResult Function( AuctionStarted value)?  auctionStarted,TResult Function( AuctionCompleted value)?  auctionCompleted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PlayerUp() when playerUp != null:
return playerUp(_that);case BidPlaced() when bidPlaced != null:
return bidPlaced(_that);case PlayerSold() when playerSold != null:
return playerSold(_that);case BidUndone() when bidUndone != null:
return bidUndone(_that);case SoldReverted() when soldReverted != null:
return soldReverted(_that);case PlayerUnsold() when playerUnsold != null:
return playerUnsold(_that);case RoundStarted() when roundStarted != null:
return roundStarted(_that);case AuctionStarted() when auctionStarted != null:
return auctionStarted(_that);case AuctionCompleted() when auctionCompleted != null:
return auctionCompleted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PlayerUp value)  playerUp,required TResult Function( BidPlaced value)  bidPlaced,required TResult Function( PlayerSold value)  playerSold,required TResult Function( BidUndone value)  bidUndone,required TResult Function( SoldReverted value)  soldReverted,required TResult Function( PlayerUnsold value)  playerUnsold,required TResult Function( RoundStarted value)  roundStarted,required TResult Function( AuctionStarted value)  auctionStarted,required TResult Function( AuctionCompleted value)  auctionCompleted,}){
final _that = this;
switch (_that) {
case PlayerUp():
return playerUp(_that);case BidPlaced():
return bidPlaced(_that);case PlayerSold():
return playerSold(_that);case BidUndone():
return bidUndone(_that);case SoldReverted():
return soldReverted(_that);case PlayerUnsold():
return playerUnsold(_that);case RoundStarted():
return roundStarted(_that);case AuctionStarted():
return auctionStarted(_that);case AuctionCompleted():
return auctionCompleted(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PlayerUp value)?  playerUp,TResult? Function( BidPlaced value)?  bidPlaced,TResult? Function( PlayerSold value)?  playerSold,TResult? Function( BidUndone value)?  bidUndone,TResult? Function( SoldReverted value)?  soldReverted,TResult? Function( PlayerUnsold value)?  playerUnsold,TResult? Function( RoundStarted value)?  roundStarted,TResult? Function( AuctionStarted value)?  auctionStarted,TResult? Function( AuctionCompleted value)?  auctionCompleted,}){
final _that = this;
switch (_that) {
case PlayerUp() when playerUp != null:
return playerUp(_that);case BidPlaced() when bidPlaced != null:
return bidPlaced(_that);case PlayerSold() when playerSold != null:
return playerSold(_that);case BidUndone() when bidUndone != null:
return bidUndone(_that);case SoldReverted() when soldReverted != null:
return soldReverted(_that);case PlayerUnsold() when playerUnsold != null:
return playerUnsold(_that);case RoundStarted() when roundStarted != null:
return roundStarted(_that);case AuctionStarted() when auctionStarted != null:
return auctionStarted(_that);case AuctionCompleted() when auctionCompleted != null:
return auctionCompleted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String playerId,  String playerName,  String? playerPhotoUrl,  int basePrice)?  playerUp,TResult Function( String franchiseId,  String franchiseName,  int amount)?  bidPlaced,TResult Function( String playerId,  String franchiseId,  int amount)?  playerSold,TResult Function()?  bidUndone,TResult Function()?  soldReverted,TResult Function( String playerId)?  playerUnsold,TResult Function( int roundNumber)?  roundStarted,TResult Function()?  auctionStarted,TResult Function()?  auctionCompleted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PlayerUp() when playerUp != null:
return playerUp(_that.playerId,_that.playerName,_that.playerPhotoUrl,_that.basePrice);case BidPlaced() when bidPlaced != null:
return bidPlaced(_that.franchiseId,_that.franchiseName,_that.amount);case PlayerSold() when playerSold != null:
return playerSold(_that.playerId,_that.franchiseId,_that.amount);case BidUndone() when bidUndone != null:
return bidUndone();case SoldReverted() when soldReverted != null:
return soldReverted();case PlayerUnsold() when playerUnsold != null:
return playerUnsold(_that.playerId);case RoundStarted() when roundStarted != null:
return roundStarted(_that.roundNumber);case AuctionStarted() when auctionStarted != null:
return auctionStarted();case AuctionCompleted() when auctionCompleted != null:
return auctionCompleted();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String playerId,  String playerName,  String? playerPhotoUrl,  int basePrice)  playerUp,required TResult Function( String franchiseId,  String franchiseName,  int amount)  bidPlaced,required TResult Function( String playerId,  String franchiseId,  int amount)  playerSold,required TResult Function()  bidUndone,required TResult Function()  soldReverted,required TResult Function( String playerId)  playerUnsold,required TResult Function( int roundNumber)  roundStarted,required TResult Function()  auctionStarted,required TResult Function()  auctionCompleted,}) {final _that = this;
switch (_that) {
case PlayerUp():
return playerUp(_that.playerId,_that.playerName,_that.playerPhotoUrl,_that.basePrice);case BidPlaced():
return bidPlaced(_that.franchiseId,_that.franchiseName,_that.amount);case PlayerSold():
return playerSold(_that.playerId,_that.franchiseId,_that.amount);case BidUndone():
return bidUndone();case SoldReverted():
return soldReverted();case PlayerUnsold():
return playerUnsold(_that.playerId);case RoundStarted():
return roundStarted(_that.roundNumber);case AuctionStarted():
return auctionStarted();case AuctionCompleted():
return auctionCompleted();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String playerId,  String playerName,  String? playerPhotoUrl,  int basePrice)?  playerUp,TResult? Function( String franchiseId,  String franchiseName,  int amount)?  bidPlaced,TResult? Function( String playerId,  String franchiseId,  int amount)?  playerSold,TResult? Function()?  bidUndone,TResult? Function()?  soldReverted,TResult? Function( String playerId)?  playerUnsold,TResult? Function( int roundNumber)?  roundStarted,TResult? Function()?  auctionStarted,TResult? Function()?  auctionCompleted,}) {final _that = this;
switch (_that) {
case PlayerUp() when playerUp != null:
return playerUp(_that.playerId,_that.playerName,_that.playerPhotoUrl,_that.basePrice);case BidPlaced() when bidPlaced != null:
return bidPlaced(_that.franchiseId,_that.franchiseName,_that.amount);case PlayerSold() when playerSold != null:
return playerSold(_that.playerId,_that.franchiseId,_that.amount);case BidUndone() when bidUndone != null:
return bidUndone();case SoldReverted() when soldReverted != null:
return soldReverted();case PlayerUnsold() when playerUnsold != null:
return playerUnsold(_that.playerId);case RoundStarted() when roundStarted != null:
return roundStarted(_that.roundNumber);case AuctionStarted() when auctionStarted != null:
return auctionStarted();case AuctionCompleted() when auctionCompleted != null:
return auctionCompleted();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class PlayerUp extends AuctionEvent {
  const PlayerUp({required this.playerId, required this.playerName, this.playerPhotoUrl, required this.basePrice, final  String? $type}): $type = $type ?? 'playerUp',super._();
  factory PlayerUp.fromJson(Map<String, dynamic> json) => _$PlayerUpFromJson(json);

 final  String playerId;
 final  String playerName;
 final  String? playerPhotoUrl;
 final  int basePrice;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerUpCopyWith<PlayerUp> get copyWith => _$PlayerUpCopyWithImpl<PlayerUp>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerUpToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerUp&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.playerName, playerName) || other.playerName == playerName)&&(identical(other.playerPhotoUrl, playerPhotoUrl) || other.playerPhotoUrl == playerPhotoUrl)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,playerName,playerPhotoUrl,basePrice);

@override
String toString() {
  return 'AuctionEvent.playerUp(playerId: $playerId, playerName: $playerName, playerPhotoUrl: $playerPhotoUrl, basePrice: $basePrice)';
}


}

/// @nodoc
abstract mixin class $PlayerUpCopyWith<$Res> implements $AuctionEventCopyWith<$Res> {
  factory $PlayerUpCopyWith(PlayerUp value, $Res Function(PlayerUp) _then) = _$PlayerUpCopyWithImpl;
@useResult
$Res call({
 String playerId, String playerName, String? playerPhotoUrl, int basePrice
});




}
/// @nodoc
class _$PlayerUpCopyWithImpl<$Res>
    implements $PlayerUpCopyWith<$Res> {
  _$PlayerUpCopyWithImpl(this._self, this._then);

  final PlayerUp _self;
  final $Res Function(PlayerUp) _then;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? playerName = null,Object? playerPhotoUrl = freezed,Object? basePrice = null,}) {
  return _then(PlayerUp(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,playerName: null == playerName ? _self.playerName : playerName // ignore: cast_nullable_to_non_nullable
as String,playerPhotoUrl: freezed == playerPhotoUrl ? _self.playerPhotoUrl : playerPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,basePrice: null == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class BidPlaced extends AuctionEvent {
  const BidPlaced({required this.franchiseId, required this.franchiseName, required this.amount, final  String? $type}): $type = $type ?? 'bidPlaced',super._();
  factory BidPlaced.fromJson(Map<String, dynamic> json) => _$BidPlacedFromJson(json);

 final  String franchiseId;
 final  String franchiseName;
 final  int amount;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BidPlacedCopyWith<BidPlaced> get copyWith => _$BidPlacedCopyWithImpl<BidPlaced>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BidPlacedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BidPlaced&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.franchiseName, franchiseName) || other.franchiseName == franchiseName)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,franchiseId,franchiseName,amount);

@override
String toString() {
  return 'AuctionEvent.bidPlaced(franchiseId: $franchiseId, franchiseName: $franchiseName, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $BidPlacedCopyWith<$Res> implements $AuctionEventCopyWith<$Res> {
  factory $BidPlacedCopyWith(BidPlaced value, $Res Function(BidPlaced) _then) = _$BidPlacedCopyWithImpl;
@useResult
$Res call({
 String franchiseId, String franchiseName, int amount
});




}
/// @nodoc
class _$BidPlacedCopyWithImpl<$Res>
    implements $BidPlacedCopyWith<$Res> {
  _$BidPlacedCopyWithImpl(this._self, this._then);

  final BidPlaced _self;
  final $Res Function(BidPlaced) _then;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? franchiseId = null,Object? franchiseName = null,Object? amount = null,}) {
  return _then(BidPlaced(
franchiseId: null == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String,franchiseName: null == franchiseName ? _self.franchiseName : franchiseName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PlayerSold extends AuctionEvent {
  const PlayerSold({required this.playerId, required this.franchiseId, required this.amount, final  String? $type}): $type = $type ?? 'playerSold',super._();
  factory PlayerSold.fromJson(Map<String, dynamic> json) => _$PlayerSoldFromJson(json);

 final  String playerId;
 final  String franchiseId;
 final  int amount;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerSoldCopyWith<PlayerSold> get copyWith => _$PlayerSoldCopyWithImpl<PlayerSold>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerSoldToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerSold&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,franchiseId,amount);

@override
String toString() {
  return 'AuctionEvent.playerSold(playerId: $playerId, franchiseId: $franchiseId, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $PlayerSoldCopyWith<$Res> implements $AuctionEventCopyWith<$Res> {
  factory $PlayerSoldCopyWith(PlayerSold value, $Res Function(PlayerSold) _then) = _$PlayerSoldCopyWithImpl;
@useResult
$Res call({
 String playerId, String franchiseId, int amount
});




}
/// @nodoc
class _$PlayerSoldCopyWithImpl<$Res>
    implements $PlayerSoldCopyWith<$Res> {
  _$PlayerSoldCopyWithImpl(this._self, this._then);

  final PlayerSold _self;
  final $Res Function(PlayerSold) _then;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? franchiseId = null,Object? amount = null,}) {
  return _then(PlayerSold(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,franchiseId: null == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class BidUndone extends AuctionEvent {
  const BidUndone({final  String? $type}): $type = $type ?? 'bidUndone',super._();
  factory BidUndone.fromJson(Map<String, dynamic> json) => _$BidUndoneFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$BidUndoneToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BidUndone);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuctionEvent.bidUndone()';
}


}




/// @nodoc
@JsonSerializable()

class SoldReverted extends AuctionEvent {
  const SoldReverted({final  String? $type}): $type = $type ?? 'soldReverted',super._();
  factory SoldReverted.fromJson(Map<String, dynamic> json) => _$SoldRevertedFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$SoldRevertedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SoldReverted);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuctionEvent.soldReverted()';
}


}




/// @nodoc
@JsonSerializable()

class PlayerUnsold extends AuctionEvent {
  const PlayerUnsold({required this.playerId, final  String? $type}): $type = $type ?? 'playerUnsold',super._();
  factory PlayerUnsold.fromJson(Map<String, dynamic> json) => _$PlayerUnsoldFromJson(json);

 final  String playerId;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerUnsoldCopyWith<PlayerUnsold> get copyWith => _$PlayerUnsoldCopyWithImpl<PlayerUnsold>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerUnsoldToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerUnsold&&(identical(other.playerId, playerId) || other.playerId == playerId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId);

@override
String toString() {
  return 'AuctionEvent.playerUnsold(playerId: $playerId)';
}


}

/// @nodoc
abstract mixin class $PlayerUnsoldCopyWith<$Res> implements $AuctionEventCopyWith<$Res> {
  factory $PlayerUnsoldCopyWith(PlayerUnsold value, $Res Function(PlayerUnsold) _then) = _$PlayerUnsoldCopyWithImpl;
@useResult
$Res call({
 String playerId
});




}
/// @nodoc
class _$PlayerUnsoldCopyWithImpl<$Res>
    implements $PlayerUnsoldCopyWith<$Res> {
  _$PlayerUnsoldCopyWithImpl(this._self, this._then);

  final PlayerUnsold _self;
  final $Res Function(PlayerUnsold) _then;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? playerId = null,}) {
  return _then(PlayerUnsold(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class RoundStarted extends AuctionEvent {
  const RoundStarted({required this.roundNumber, final  String? $type}): $type = $type ?? 'roundStarted',super._();
  factory RoundStarted.fromJson(Map<String, dynamic> json) => _$RoundStartedFromJson(json);

 final  int roundNumber;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoundStartedCopyWith<RoundStarted> get copyWith => _$RoundStartedCopyWithImpl<RoundStarted>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoundStartedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoundStarted&&(identical(other.roundNumber, roundNumber) || other.roundNumber == roundNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,roundNumber);

@override
String toString() {
  return 'AuctionEvent.roundStarted(roundNumber: $roundNumber)';
}


}

/// @nodoc
abstract mixin class $RoundStartedCopyWith<$Res> implements $AuctionEventCopyWith<$Res> {
  factory $RoundStartedCopyWith(RoundStarted value, $Res Function(RoundStarted) _then) = _$RoundStartedCopyWithImpl;
@useResult
$Res call({
 int roundNumber
});




}
/// @nodoc
class _$RoundStartedCopyWithImpl<$Res>
    implements $RoundStartedCopyWith<$Res> {
  _$RoundStartedCopyWithImpl(this._self, this._then);

  final RoundStarted _self;
  final $Res Function(RoundStarted) _then;

/// Create a copy of AuctionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? roundNumber = null,}) {
  return _then(RoundStarted(
roundNumber: null == roundNumber ? _self.roundNumber : roundNumber // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AuctionStarted extends AuctionEvent {
  const AuctionStarted({final  String? $type}): $type = $type ?? 'auctionStarted',super._();
  factory AuctionStarted.fromJson(Map<String, dynamic> json) => _$AuctionStartedFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$AuctionStartedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuctionStarted);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuctionEvent.auctionStarted()';
}


}




/// @nodoc
@JsonSerializable()

class AuctionCompleted extends AuctionEvent {
  const AuctionCompleted({final  String? $type}): $type = $type ?? 'auctionCompleted',super._();
  factory AuctionCompleted.fromJson(Map<String, dynamic> json) => _$AuctionCompletedFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$AuctionCompletedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuctionCompleted);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuctionEvent.auctionCompleted()';
}


}




// dart format on
