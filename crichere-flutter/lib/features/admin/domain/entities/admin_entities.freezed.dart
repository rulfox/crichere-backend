// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlatformMetrics {

 int get totalUsers; int get activeLeagues; int get ongoingAuctions; int get totalRevenue; List<DailyActivity> get activityLog;
/// Create a copy of PlatformMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlatformMetricsCopyWith<PlatformMetrics> get copyWith => _$PlatformMetricsCopyWithImpl<PlatformMetrics>(this as PlatformMetrics, _$identity);

  /// Serializes this PlatformMetrics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlatformMetrics&&(identical(other.totalUsers, totalUsers) || other.totalUsers == totalUsers)&&(identical(other.activeLeagues, activeLeagues) || other.activeLeagues == activeLeagues)&&(identical(other.ongoingAuctions, ongoingAuctions) || other.ongoingAuctions == ongoingAuctions)&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&const DeepCollectionEquality().equals(other.activityLog, activityLog));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalUsers,activeLeagues,ongoingAuctions,totalRevenue,const DeepCollectionEquality().hash(activityLog));

@override
String toString() {
  return 'PlatformMetrics(totalUsers: $totalUsers, activeLeagues: $activeLeagues, ongoingAuctions: $ongoingAuctions, totalRevenue: $totalRevenue, activityLog: $activityLog)';
}


}

/// @nodoc
abstract mixin class $PlatformMetricsCopyWith<$Res>  {
  factory $PlatformMetricsCopyWith(PlatformMetrics value, $Res Function(PlatformMetrics) _then) = _$PlatformMetricsCopyWithImpl;
@useResult
$Res call({
 int totalUsers, int activeLeagues, int ongoingAuctions, int totalRevenue, List<DailyActivity> activityLog
});




}
/// @nodoc
class _$PlatformMetricsCopyWithImpl<$Res>
    implements $PlatformMetricsCopyWith<$Res> {
  _$PlatformMetricsCopyWithImpl(this._self, this._then);

  final PlatformMetrics _self;
  final $Res Function(PlatformMetrics) _then;

/// Create a copy of PlatformMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalUsers = null,Object? activeLeagues = null,Object? ongoingAuctions = null,Object? totalRevenue = null,Object? activityLog = null,}) {
  return _then(_self.copyWith(
totalUsers: null == totalUsers ? _self.totalUsers : totalUsers // ignore: cast_nullable_to_non_nullable
as int,activeLeagues: null == activeLeagues ? _self.activeLeagues : activeLeagues // ignore: cast_nullable_to_non_nullable
as int,ongoingAuctions: null == ongoingAuctions ? _self.ongoingAuctions : ongoingAuctions // ignore: cast_nullable_to_non_nullable
as int,totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as int,activityLog: null == activityLog ? _self.activityLog : activityLog // ignore: cast_nullable_to_non_nullable
as List<DailyActivity>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlatformMetrics].
extension PlatformMetricsPatterns on PlatformMetrics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlatformMetrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlatformMetrics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlatformMetrics value)  $default,){
final _that = this;
switch (_that) {
case _PlatformMetrics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlatformMetrics value)?  $default,){
final _that = this;
switch (_that) {
case _PlatformMetrics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalUsers,  int activeLeagues,  int ongoingAuctions,  int totalRevenue,  List<DailyActivity> activityLog)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlatformMetrics() when $default != null:
return $default(_that.totalUsers,_that.activeLeagues,_that.ongoingAuctions,_that.totalRevenue,_that.activityLog);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalUsers,  int activeLeagues,  int ongoingAuctions,  int totalRevenue,  List<DailyActivity> activityLog)  $default,) {final _that = this;
switch (_that) {
case _PlatformMetrics():
return $default(_that.totalUsers,_that.activeLeagues,_that.ongoingAuctions,_that.totalRevenue,_that.activityLog);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalUsers,  int activeLeagues,  int ongoingAuctions,  int totalRevenue,  List<DailyActivity> activityLog)?  $default,) {final _that = this;
switch (_that) {
case _PlatformMetrics() when $default != null:
return $default(_that.totalUsers,_that.activeLeagues,_that.ongoingAuctions,_that.totalRevenue,_that.activityLog);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlatformMetrics implements PlatformMetrics {
  const _PlatformMetrics({required this.totalUsers, required this.activeLeagues, required this.ongoingAuctions, required this.totalRevenue, required final  List<DailyActivity> activityLog}): _activityLog = activityLog;
  factory _PlatformMetrics.fromJson(Map<String, dynamic> json) => _$PlatformMetricsFromJson(json);

@override final  int totalUsers;
@override final  int activeLeagues;
@override final  int ongoingAuctions;
@override final  int totalRevenue;
 final  List<DailyActivity> _activityLog;
@override List<DailyActivity> get activityLog {
  if (_activityLog is EqualUnmodifiableListView) return _activityLog;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activityLog);
}


/// Create a copy of PlatformMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlatformMetricsCopyWith<_PlatformMetrics> get copyWith => __$PlatformMetricsCopyWithImpl<_PlatformMetrics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlatformMetricsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlatformMetrics&&(identical(other.totalUsers, totalUsers) || other.totalUsers == totalUsers)&&(identical(other.activeLeagues, activeLeagues) || other.activeLeagues == activeLeagues)&&(identical(other.ongoingAuctions, ongoingAuctions) || other.ongoingAuctions == ongoingAuctions)&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&const DeepCollectionEquality().equals(other._activityLog, _activityLog));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalUsers,activeLeagues,ongoingAuctions,totalRevenue,const DeepCollectionEquality().hash(_activityLog));

@override
String toString() {
  return 'PlatformMetrics(totalUsers: $totalUsers, activeLeagues: $activeLeagues, ongoingAuctions: $ongoingAuctions, totalRevenue: $totalRevenue, activityLog: $activityLog)';
}


}

/// @nodoc
abstract mixin class _$PlatformMetricsCopyWith<$Res> implements $PlatformMetricsCopyWith<$Res> {
  factory _$PlatformMetricsCopyWith(_PlatformMetrics value, $Res Function(_PlatformMetrics) _then) = __$PlatformMetricsCopyWithImpl;
@override @useResult
$Res call({
 int totalUsers, int activeLeagues, int ongoingAuctions, int totalRevenue, List<DailyActivity> activityLog
});




}
/// @nodoc
class __$PlatformMetricsCopyWithImpl<$Res>
    implements _$PlatformMetricsCopyWith<$Res> {
  __$PlatformMetricsCopyWithImpl(this._self, this._then);

  final _PlatformMetrics _self;
  final $Res Function(_PlatformMetrics) _then;

/// Create a copy of PlatformMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalUsers = null,Object? activeLeagues = null,Object? ongoingAuctions = null,Object? totalRevenue = null,Object? activityLog = null,}) {
  return _then(_PlatformMetrics(
totalUsers: null == totalUsers ? _self.totalUsers : totalUsers // ignore: cast_nullable_to_non_nullable
as int,activeLeagues: null == activeLeagues ? _self.activeLeagues : activeLeagues // ignore: cast_nullable_to_non_nullable
as int,ongoingAuctions: null == ongoingAuctions ? _self.ongoingAuctions : ongoingAuctions // ignore: cast_nullable_to_non_nullable
as int,totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as int,activityLog: null == activityLog ? _self._activityLog : activityLog // ignore: cast_nullable_to_non_nullable
as List<DailyActivity>,
  ));
}


}


/// @nodoc
mixin _$DailyActivity {

 DateTime get date; int get usersJoined; int get auctionsStarted;
/// Create a copy of DailyActivity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyActivityCopyWith<DailyActivity> get copyWith => _$DailyActivityCopyWithImpl<DailyActivity>(this as DailyActivity, _$identity);

  /// Serializes this DailyActivity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyActivity&&(identical(other.date, date) || other.date == date)&&(identical(other.usersJoined, usersJoined) || other.usersJoined == usersJoined)&&(identical(other.auctionsStarted, auctionsStarted) || other.auctionsStarted == auctionsStarted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,usersJoined,auctionsStarted);

@override
String toString() {
  return 'DailyActivity(date: $date, usersJoined: $usersJoined, auctionsStarted: $auctionsStarted)';
}


}

/// @nodoc
abstract mixin class $DailyActivityCopyWith<$Res>  {
  factory $DailyActivityCopyWith(DailyActivity value, $Res Function(DailyActivity) _then) = _$DailyActivityCopyWithImpl;
@useResult
$Res call({
 DateTime date, int usersJoined, int auctionsStarted
});




}
/// @nodoc
class _$DailyActivityCopyWithImpl<$Res>
    implements $DailyActivityCopyWith<$Res> {
  _$DailyActivityCopyWithImpl(this._self, this._then);

  final DailyActivity _self;
  final $Res Function(DailyActivity) _then;

/// Create a copy of DailyActivity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? usersJoined = null,Object? auctionsStarted = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,usersJoined: null == usersJoined ? _self.usersJoined : usersJoined // ignore: cast_nullable_to_non_nullable
as int,auctionsStarted: null == auctionsStarted ? _self.auctionsStarted : auctionsStarted // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyActivity].
extension DailyActivityPatterns on DailyActivity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyActivity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyActivity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyActivity value)  $default,){
final _that = this;
switch (_that) {
case _DailyActivity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyActivity value)?  $default,){
final _that = this;
switch (_that) {
case _DailyActivity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  int usersJoined,  int auctionsStarted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyActivity() when $default != null:
return $default(_that.date,_that.usersJoined,_that.auctionsStarted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  int usersJoined,  int auctionsStarted)  $default,) {final _that = this;
switch (_that) {
case _DailyActivity():
return $default(_that.date,_that.usersJoined,_that.auctionsStarted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  int usersJoined,  int auctionsStarted)?  $default,) {final _that = this;
switch (_that) {
case _DailyActivity() when $default != null:
return $default(_that.date,_that.usersJoined,_that.auctionsStarted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyActivity implements DailyActivity {
  const _DailyActivity({required this.date, required this.usersJoined, required this.auctionsStarted});
  factory _DailyActivity.fromJson(Map<String, dynamic> json) => _$DailyActivityFromJson(json);

@override final  DateTime date;
@override final  int usersJoined;
@override final  int auctionsStarted;

/// Create a copy of DailyActivity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyActivityCopyWith<_DailyActivity> get copyWith => __$DailyActivityCopyWithImpl<_DailyActivity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyActivityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyActivity&&(identical(other.date, date) || other.date == date)&&(identical(other.usersJoined, usersJoined) || other.usersJoined == usersJoined)&&(identical(other.auctionsStarted, auctionsStarted) || other.auctionsStarted == auctionsStarted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,usersJoined,auctionsStarted);

@override
String toString() {
  return 'DailyActivity(date: $date, usersJoined: $usersJoined, auctionsStarted: $auctionsStarted)';
}


}

/// @nodoc
abstract mixin class _$DailyActivityCopyWith<$Res> implements $DailyActivityCopyWith<$Res> {
  factory _$DailyActivityCopyWith(_DailyActivity value, $Res Function(_DailyActivity) _then) = __$DailyActivityCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, int usersJoined, int auctionsStarted
});




}
/// @nodoc
class __$DailyActivityCopyWithImpl<$Res>
    implements _$DailyActivityCopyWith<$Res> {
  __$DailyActivityCopyWithImpl(this._self, this._then);

  final _DailyActivity _self;
  final $Res Function(_DailyActivity) _then;

/// Create a copy of DailyActivity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? usersJoined = null,Object? auctionsStarted = null,}) {
  return _then(_DailyActivity(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,usersJoined: null == usersJoined ? _self.usersJoined : usersJoined // ignore: cast_nullable_to_non_nullable
as int,auctionsStarted: null == auctionsStarted ? _self.auctionsStarted : auctionsStarted // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
