// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'waitlist_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WaitlistEntry {

 String get id; String get leagueId; String get userId; String? get franchiseId; String get type;// PLAYER, FRANCHISE
 int get position; String get status;// WAITING, PROMOTED, WITHDRAWN
 DateTime get createdAt; DateTime? get promotedAt;
/// Create a copy of WaitlistEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WaitlistEntryCopyWith<WaitlistEntry> get copyWith => _$WaitlistEntryCopyWithImpl<WaitlistEntry>(this as WaitlistEntry, _$identity);

  /// Serializes this WaitlistEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WaitlistEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.type, type) || other.type == type)&&(identical(other.position, position) || other.position == position)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.promotedAt, promotedAt) || other.promotedAt == promotedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,leagueId,userId,franchiseId,type,position,status,createdAt,promotedAt);

@override
String toString() {
  return 'WaitlistEntry(id: $id, leagueId: $leagueId, userId: $userId, franchiseId: $franchiseId, type: $type, position: $position, status: $status, createdAt: $createdAt, promotedAt: $promotedAt)';
}


}

/// @nodoc
abstract mixin class $WaitlistEntryCopyWith<$Res>  {
  factory $WaitlistEntryCopyWith(WaitlistEntry value, $Res Function(WaitlistEntry) _then) = _$WaitlistEntryCopyWithImpl;
@useResult
$Res call({
 String id, String leagueId, String userId, String? franchiseId, String type, int position, String status, DateTime createdAt, DateTime? promotedAt
});




}
/// @nodoc
class _$WaitlistEntryCopyWithImpl<$Res>
    implements $WaitlistEntryCopyWith<$Res> {
  _$WaitlistEntryCopyWithImpl(this._self, this._then);

  final WaitlistEntry _self;
  final $Res Function(WaitlistEntry) _then;

/// Create a copy of WaitlistEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? leagueId = null,Object? userId = null,Object? franchiseId = freezed,Object? type = null,Object? position = null,Object? status = null,Object? createdAt = null,Object? promotedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,franchiseId: freezed == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,promotedAt: freezed == promotedAt ? _self.promotedAt : promotedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [WaitlistEntry].
extension WaitlistEntryPatterns on WaitlistEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WaitlistEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WaitlistEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WaitlistEntry value)  $default,){
final _that = this;
switch (_that) {
case _WaitlistEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WaitlistEntry value)?  $default,){
final _that = this;
switch (_that) {
case _WaitlistEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String leagueId,  String userId,  String? franchiseId,  String type,  int position,  String status,  DateTime createdAt,  DateTime? promotedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WaitlistEntry() when $default != null:
return $default(_that.id,_that.leagueId,_that.userId,_that.franchiseId,_that.type,_that.position,_that.status,_that.createdAt,_that.promotedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String leagueId,  String userId,  String? franchiseId,  String type,  int position,  String status,  DateTime createdAt,  DateTime? promotedAt)  $default,) {final _that = this;
switch (_that) {
case _WaitlistEntry():
return $default(_that.id,_that.leagueId,_that.userId,_that.franchiseId,_that.type,_that.position,_that.status,_that.createdAt,_that.promotedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String leagueId,  String userId,  String? franchiseId,  String type,  int position,  String status,  DateTime createdAt,  DateTime? promotedAt)?  $default,) {final _that = this;
switch (_that) {
case _WaitlistEntry() when $default != null:
return $default(_that.id,_that.leagueId,_that.userId,_that.franchiseId,_that.type,_that.position,_that.status,_that.createdAt,_that.promotedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WaitlistEntry implements WaitlistEntry {
  const _WaitlistEntry({required this.id, required this.leagueId, required this.userId, this.franchiseId, required this.type, required this.position, required this.status, required this.createdAt, this.promotedAt});
  factory _WaitlistEntry.fromJson(Map<String, dynamic> json) => _$WaitlistEntryFromJson(json);

@override final  String id;
@override final  String leagueId;
@override final  String userId;
@override final  String? franchiseId;
@override final  String type;
// PLAYER, FRANCHISE
@override final  int position;
@override final  String status;
// WAITING, PROMOTED, WITHDRAWN
@override final  DateTime createdAt;
@override final  DateTime? promotedAt;

/// Create a copy of WaitlistEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WaitlistEntryCopyWith<_WaitlistEntry> get copyWith => __$WaitlistEntryCopyWithImpl<_WaitlistEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WaitlistEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WaitlistEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.leagueId, leagueId) || other.leagueId == leagueId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.franchiseId, franchiseId) || other.franchiseId == franchiseId)&&(identical(other.type, type) || other.type == type)&&(identical(other.position, position) || other.position == position)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.promotedAt, promotedAt) || other.promotedAt == promotedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,leagueId,userId,franchiseId,type,position,status,createdAt,promotedAt);

@override
String toString() {
  return 'WaitlistEntry(id: $id, leagueId: $leagueId, userId: $userId, franchiseId: $franchiseId, type: $type, position: $position, status: $status, createdAt: $createdAt, promotedAt: $promotedAt)';
}


}

/// @nodoc
abstract mixin class _$WaitlistEntryCopyWith<$Res> implements $WaitlistEntryCopyWith<$Res> {
  factory _$WaitlistEntryCopyWith(_WaitlistEntry value, $Res Function(_WaitlistEntry) _then) = __$WaitlistEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String leagueId, String userId, String? franchiseId, String type, int position, String status, DateTime createdAt, DateTime? promotedAt
});




}
/// @nodoc
class __$WaitlistEntryCopyWithImpl<$Res>
    implements _$WaitlistEntryCopyWith<$Res> {
  __$WaitlistEntryCopyWithImpl(this._self, this._then);

  final _WaitlistEntry _self;
  final $Res Function(_WaitlistEntry) _then;

/// Create a copy of WaitlistEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? leagueId = null,Object? userId = null,Object? franchiseId = freezed,Object? type = null,Object? position = null,Object? status = null,Object? createdAt = null,Object? promotedAt = freezed,}) {
  return _then(_WaitlistEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,leagueId: null == leagueId ? _self.leagueId : leagueId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,franchiseId: freezed == franchiseId ? _self.franchiseId : franchiseId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,promotedAt: freezed == promotedAt ? _self.promotedAt : promotedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$WaitlistPagedResponse {

 List<WaitlistEntry> get entries; int get totalElements; int get totalPages; int get pageNumber; int get pageSize;
/// Create a copy of WaitlistPagedResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WaitlistPagedResponseCopyWith<WaitlistPagedResponse> get copyWith => _$WaitlistPagedResponseCopyWithImpl<WaitlistPagedResponse>(this as WaitlistPagedResponse, _$identity);

  /// Serializes this WaitlistPagedResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WaitlistPagedResponse&&const DeepCollectionEquality().equals(other.entries, entries)&&(identical(other.totalElements, totalElements) || other.totalElements == totalElements)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(entries),totalElements,totalPages,pageNumber,pageSize);

@override
String toString() {
  return 'WaitlistPagedResponse(entries: $entries, totalElements: $totalElements, totalPages: $totalPages, pageNumber: $pageNumber, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class $WaitlistPagedResponseCopyWith<$Res>  {
  factory $WaitlistPagedResponseCopyWith(WaitlistPagedResponse value, $Res Function(WaitlistPagedResponse) _then) = _$WaitlistPagedResponseCopyWithImpl;
@useResult
$Res call({
 List<WaitlistEntry> entries, int totalElements, int totalPages, int pageNumber, int pageSize
});




}
/// @nodoc
class _$WaitlistPagedResponseCopyWithImpl<$Res>
    implements $WaitlistPagedResponseCopyWith<$Res> {
  _$WaitlistPagedResponseCopyWithImpl(this._self, this._then);

  final WaitlistPagedResponse _self;
  final $Res Function(WaitlistPagedResponse) _then;

/// Create a copy of WaitlistPagedResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entries = null,Object? totalElements = null,Object? totalPages = null,Object? pageNumber = null,Object? pageSize = null,}) {
  return _then(_self.copyWith(
entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<WaitlistEntry>,totalElements: null == totalElements ? _self.totalElements : totalElements // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WaitlistPagedResponse].
extension WaitlistPagedResponsePatterns on WaitlistPagedResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WaitlistPagedResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WaitlistPagedResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WaitlistPagedResponse value)  $default,){
final _that = this;
switch (_that) {
case _WaitlistPagedResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WaitlistPagedResponse value)?  $default,){
final _that = this;
switch (_that) {
case _WaitlistPagedResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<WaitlistEntry> entries,  int totalElements,  int totalPages,  int pageNumber,  int pageSize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WaitlistPagedResponse() when $default != null:
return $default(_that.entries,_that.totalElements,_that.totalPages,_that.pageNumber,_that.pageSize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<WaitlistEntry> entries,  int totalElements,  int totalPages,  int pageNumber,  int pageSize)  $default,) {final _that = this;
switch (_that) {
case _WaitlistPagedResponse():
return $default(_that.entries,_that.totalElements,_that.totalPages,_that.pageNumber,_that.pageSize);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<WaitlistEntry> entries,  int totalElements,  int totalPages,  int pageNumber,  int pageSize)?  $default,) {final _that = this;
switch (_that) {
case _WaitlistPagedResponse() when $default != null:
return $default(_that.entries,_that.totalElements,_that.totalPages,_that.pageNumber,_that.pageSize);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WaitlistPagedResponse implements WaitlistPagedResponse {
  const _WaitlistPagedResponse({required final  List<WaitlistEntry> entries, required this.totalElements, required this.totalPages, required this.pageNumber, required this.pageSize}): _entries = entries;
  factory _WaitlistPagedResponse.fromJson(Map<String, dynamic> json) => _$WaitlistPagedResponseFromJson(json);

 final  List<WaitlistEntry> _entries;
@override List<WaitlistEntry> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

@override final  int totalElements;
@override final  int totalPages;
@override final  int pageNumber;
@override final  int pageSize;

/// Create a copy of WaitlistPagedResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WaitlistPagedResponseCopyWith<_WaitlistPagedResponse> get copyWith => __$WaitlistPagedResponseCopyWithImpl<_WaitlistPagedResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WaitlistPagedResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WaitlistPagedResponse&&const DeepCollectionEquality().equals(other._entries, _entries)&&(identical(other.totalElements, totalElements) || other.totalElements == totalElements)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_entries),totalElements,totalPages,pageNumber,pageSize);

@override
String toString() {
  return 'WaitlistPagedResponse(entries: $entries, totalElements: $totalElements, totalPages: $totalPages, pageNumber: $pageNumber, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class _$WaitlistPagedResponseCopyWith<$Res> implements $WaitlistPagedResponseCopyWith<$Res> {
  factory _$WaitlistPagedResponseCopyWith(_WaitlistPagedResponse value, $Res Function(_WaitlistPagedResponse) _then) = __$WaitlistPagedResponseCopyWithImpl;
@override @useResult
$Res call({
 List<WaitlistEntry> entries, int totalElements, int totalPages, int pageNumber, int pageSize
});




}
/// @nodoc
class __$WaitlistPagedResponseCopyWithImpl<$Res>
    implements _$WaitlistPagedResponseCopyWith<$Res> {
  __$WaitlistPagedResponseCopyWithImpl(this._self, this._then);

  final _WaitlistPagedResponse _self;
  final $Res Function(_WaitlistPagedResponse) _then;

/// Create a copy of WaitlistPagedResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entries = null,Object? totalElements = null,Object? totalPages = null,Object? pageNumber = null,Object? pageSize = null,}) {
  return _then(_WaitlistPagedResponse(
entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<WaitlistEntry>,totalElements: null == totalElements ? _self.totalElements : totalElements // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
