// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfile {

 String get id; String? get phone; String? get name; String? get email; String? get profilePhoto;@JsonKey(unknownEnumValue: ProfileStatus.active) ProfileStatus? get profileStatus;@JsonKey(unknownEnumValue: PlayingRole.batter) PlayingRole? get playingRole;@JsonKey(unknownEnumValue: BattingStyle.rightHand) BattingStyle? get battingStyle;@JsonKey(unknownEnumValue: BowlingStyle.rightArm) BowlingStyle? get bowlingStyle;@JsonKey(unknownEnumValue: BowlingType.medium) BowlingType? get bowlingType;@JsonKey(unknownEnumValue: ExperienceLevel.local) ExperienceLevel? get experienceLevel; int? get jerseyNumber; DateTime? get dateOfBirth; String? get gender; String? get city; String? get state;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.profilePhoto, profilePhoto) || other.profilePhoto == profilePhoto)&&(identical(other.profileStatus, profileStatus) || other.profileStatus == profileStatus)&&(identical(other.playingRole, playingRole) || other.playingRole == playingRole)&&(identical(other.battingStyle, battingStyle) || other.battingStyle == battingStyle)&&(identical(other.bowlingStyle, bowlingStyle) || other.bowlingStyle == bowlingStyle)&&(identical(other.bowlingType, bowlingType) || other.bowlingType == bowlingType)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&(identical(other.jerseyNumber, jerseyNumber) || other.jerseyNumber == jerseyNumber)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,phone,name,email,profilePhoto,profileStatus,playingRole,battingStyle,bowlingStyle,bowlingType,experienceLevel,jerseyNumber,dateOfBirth,gender,city,state);

@override
String toString() {
  return 'UserProfile(id: $id, phone: $phone, name: $name, email: $email, profilePhoto: $profilePhoto, profileStatus: $profileStatus, playingRole: $playingRole, battingStyle: $battingStyle, bowlingStyle: $bowlingStyle, bowlingType: $bowlingType, experienceLevel: $experienceLevel, jerseyNumber: $jerseyNumber, dateOfBirth: $dateOfBirth, gender: $gender, city: $city, state: $state)';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 String id, String? phone, String? name, String? email, String? profilePhoto,@JsonKey(unknownEnumValue: ProfileStatus.active) ProfileStatus? profileStatus,@JsonKey(unknownEnumValue: PlayingRole.batter) PlayingRole? playingRole,@JsonKey(unknownEnumValue: BattingStyle.rightHand) BattingStyle? battingStyle,@JsonKey(unknownEnumValue: BowlingStyle.rightArm) BowlingStyle? bowlingStyle,@JsonKey(unknownEnumValue: BowlingType.medium) BowlingType? bowlingType,@JsonKey(unknownEnumValue: ExperienceLevel.local) ExperienceLevel? experienceLevel, int? jerseyNumber, DateTime? dateOfBirth, String? gender, String? city, String? state
});




}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? phone = freezed,Object? name = freezed,Object? email = freezed,Object? profilePhoto = freezed,Object? profileStatus = freezed,Object? playingRole = freezed,Object? battingStyle = freezed,Object? bowlingStyle = freezed,Object? bowlingType = freezed,Object? experienceLevel = freezed,Object? jerseyNumber = freezed,Object? dateOfBirth = freezed,Object? gender = freezed,Object? city = freezed,Object? state = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,profilePhoto: freezed == profilePhoto ? _self.profilePhoto : profilePhoto // ignore: cast_nullable_to_non_nullable
as String?,profileStatus: freezed == profileStatus ? _self.profileStatus : profileStatus // ignore: cast_nullable_to_non_nullable
as ProfileStatus?,playingRole: freezed == playingRole ? _self.playingRole : playingRole // ignore: cast_nullable_to_non_nullable
as PlayingRole?,battingStyle: freezed == battingStyle ? _self.battingStyle : battingStyle // ignore: cast_nullable_to_non_nullable
as BattingStyle?,bowlingStyle: freezed == bowlingStyle ? _self.bowlingStyle : bowlingStyle // ignore: cast_nullable_to_non_nullable
as BowlingStyle?,bowlingType: freezed == bowlingType ? _self.bowlingType : bowlingType // ignore: cast_nullable_to_non_nullable
as BowlingType?,experienceLevel: freezed == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as ExperienceLevel?,jerseyNumber: freezed == jerseyNumber ? _self.jerseyNumber : jerseyNumber // ignore: cast_nullable_to_non_nullable
as int?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? phone,  String? name,  String? email,  String? profilePhoto, @JsonKey(unknownEnumValue: ProfileStatus.active)  ProfileStatus? profileStatus, @JsonKey(unknownEnumValue: PlayingRole.batter)  PlayingRole? playingRole, @JsonKey(unknownEnumValue: BattingStyle.rightHand)  BattingStyle? battingStyle, @JsonKey(unknownEnumValue: BowlingStyle.rightArm)  BowlingStyle? bowlingStyle, @JsonKey(unknownEnumValue: BowlingType.medium)  BowlingType? bowlingType, @JsonKey(unknownEnumValue: ExperienceLevel.local)  ExperienceLevel? experienceLevel,  int? jerseyNumber,  DateTime? dateOfBirth,  String? gender,  String? city,  String? state)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.phone,_that.name,_that.email,_that.profilePhoto,_that.profileStatus,_that.playingRole,_that.battingStyle,_that.bowlingStyle,_that.bowlingType,_that.experienceLevel,_that.jerseyNumber,_that.dateOfBirth,_that.gender,_that.city,_that.state);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? phone,  String? name,  String? email,  String? profilePhoto, @JsonKey(unknownEnumValue: ProfileStatus.active)  ProfileStatus? profileStatus, @JsonKey(unknownEnumValue: PlayingRole.batter)  PlayingRole? playingRole, @JsonKey(unknownEnumValue: BattingStyle.rightHand)  BattingStyle? battingStyle, @JsonKey(unknownEnumValue: BowlingStyle.rightArm)  BowlingStyle? bowlingStyle, @JsonKey(unknownEnumValue: BowlingType.medium)  BowlingType? bowlingType, @JsonKey(unknownEnumValue: ExperienceLevel.local)  ExperienceLevel? experienceLevel,  int? jerseyNumber,  DateTime? dateOfBirth,  String? gender,  String? city,  String? state)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.id,_that.phone,_that.name,_that.email,_that.profilePhoto,_that.profileStatus,_that.playingRole,_that.battingStyle,_that.bowlingStyle,_that.bowlingType,_that.experienceLevel,_that.jerseyNumber,_that.dateOfBirth,_that.gender,_that.city,_that.state);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? phone,  String? name,  String? email,  String? profilePhoto, @JsonKey(unknownEnumValue: ProfileStatus.active)  ProfileStatus? profileStatus, @JsonKey(unknownEnumValue: PlayingRole.batter)  PlayingRole? playingRole, @JsonKey(unknownEnumValue: BattingStyle.rightHand)  BattingStyle? battingStyle, @JsonKey(unknownEnumValue: BowlingStyle.rightArm)  BowlingStyle? bowlingStyle, @JsonKey(unknownEnumValue: BowlingType.medium)  BowlingType? bowlingType, @JsonKey(unknownEnumValue: ExperienceLevel.local)  ExperienceLevel? experienceLevel,  int? jerseyNumber,  DateTime? dateOfBirth,  String? gender,  String? city,  String? state)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.phone,_that.name,_that.email,_that.profilePhoto,_that.profileStatus,_that.playingRole,_that.battingStyle,_that.bowlingStyle,_that.bowlingType,_that.experienceLevel,_that.jerseyNumber,_that.dateOfBirth,_that.gender,_that.city,_that.state);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfile implements UserProfile {
  const _UserProfile({required this.id, this.phone, this.name, this.email, this.profilePhoto, @JsonKey(unknownEnumValue: ProfileStatus.active) this.profileStatus, @JsonKey(unknownEnumValue: PlayingRole.batter) this.playingRole, @JsonKey(unknownEnumValue: BattingStyle.rightHand) this.battingStyle, @JsonKey(unknownEnumValue: BowlingStyle.rightArm) this.bowlingStyle, @JsonKey(unknownEnumValue: BowlingType.medium) this.bowlingType, @JsonKey(unknownEnumValue: ExperienceLevel.local) this.experienceLevel, this.jerseyNumber, this.dateOfBirth, this.gender, this.city, this.state});
  factory _UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

@override final  String id;
@override final  String? phone;
@override final  String? name;
@override final  String? email;
@override final  String? profilePhoto;
@override@JsonKey(unknownEnumValue: ProfileStatus.active) final  ProfileStatus? profileStatus;
@override@JsonKey(unknownEnumValue: PlayingRole.batter) final  PlayingRole? playingRole;
@override@JsonKey(unknownEnumValue: BattingStyle.rightHand) final  BattingStyle? battingStyle;
@override@JsonKey(unknownEnumValue: BowlingStyle.rightArm) final  BowlingStyle? bowlingStyle;
@override@JsonKey(unknownEnumValue: BowlingType.medium) final  BowlingType? bowlingType;
@override@JsonKey(unknownEnumValue: ExperienceLevel.local) final  ExperienceLevel? experienceLevel;
@override final  int? jerseyNumber;
@override final  DateTime? dateOfBirth;
@override final  String? gender;
@override final  String? city;
@override final  String? state;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.profilePhoto, profilePhoto) || other.profilePhoto == profilePhoto)&&(identical(other.profileStatus, profileStatus) || other.profileStatus == profileStatus)&&(identical(other.playingRole, playingRole) || other.playingRole == playingRole)&&(identical(other.battingStyle, battingStyle) || other.battingStyle == battingStyle)&&(identical(other.bowlingStyle, bowlingStyle) || other.bowlingStyle == bowlingStyle)&&(identical(other.bowlingType, bowlingType) || other.bowlingType == bowlingType)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&(identical(other.jerseyNumber, jerseyNumber) || other.jerseyNumber == jerseyNumber)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,phone,name,email,profilePhoto,profileStatus,playingRole,battingStyle,bowlingStyle,bowlingType,experienceLevel,jerseyNumber,dateOfBirth,gender,city,state);

@override
String toString() {
  return 'UserProfile(id: $id, phone: $phone, name: $name, email: $email, profilePhoto: $profilePhoto, profileStatus: $profileStatus, playingRole: $playingRole, battingStyle: $battingStyle, bowlingStyle: $bowlingStyle, bowlingType: $bowlingType, experienceLevel: $experienceLevel, jerseyNumber: $jerseyNumber, dateOfBirth: $dateOfBirth, gender: $gender, city: $city, state: $state)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String? phone, String? name, String? email, String? profilePhoto,@JsonKey(unknownEnumValue: ProfileStatus.active) ProfileStatus? profileStatus,@JsonKey(unknownEnumValue: PlayingRole.batter) PlayingRole? playingRole,@JsonKey(unknownEnumValue: BattingStyle.rightHand) BattingStyle? battingStyle,@JsonKey(unknownEnumValue: BowlingStyle.rightArm) BowlingStyle? bowlingStyle,@JsonKey(unknownEnumValue: BowlingType.medium) BowlingType? bowlingType,@JsonKey(unknownEnumValue: ExperienceLevel.local) ExperienceLevel? experienceLevel, int? jerseyNumber, DateTime? dateOfBirth, String? gender, String? city, String? state
});




}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? phone = freezed,Object? name = freezed,Object? email = freezed,Object? profilePhoto = freezed,Object? profileStatus = freezed,Object? playingRole = freezed,Object? battingStyle = freezed,Object? bowlingStyle = freezed,Object? bowlingType = freezed,Object? experienceLevel = freezed,Object? jerseyNumber = freezed,Object? dateOfBirth = freezed,Object? gender = freezed,Object? city = freezed,Object? state = freezed,}) {
  return _then(_UserProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,profilePhoto: freezed == profilePhoto ? _self.profilePhoto : profilePhoto // ignore: cast_nullable_to_non_nullable
as String?,profileStatus: freezed == profileStatus ? _self.profileStatus : profileStatus // ignore: cast_nullable_to_non_nullable
as ProfileStatus?,playingRole: freezed == playingRole ? _self.playingRole : playingRole // ignore: cast_nullable_to_non_nullable
as PlayingRole?,battingStyle: freezed == battingStyle ? _self.battingStyle : battingStyle // ignore: cast_nullable_to_non_nullable
as BattingStyle?,bowlingStyle: freezed == bowlingStyle ? _self.bowlingStyle : bowlingStyle // ignore: cast_nullable_to_non_nullable
as BowlingStyle?,bowlingType: freezed == bowlingType ? _self.bowlingType : bowlingType // ignore: cast_nullable_to_non_nullable
as BowlingType?,experienceLevel: freezed == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as ExperienceLevel?,jerseyNumber: freezed == jerseyNumber ? _self.jerseyNumber : jerseyNumber // ignore: cast_nullable_to_non_nullable
as int?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
