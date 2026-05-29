import 'package:freezed_annotation/freezed_annotation.dart';
import 'auth_enums.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

/// Mirrors backend `UserResponse` — used for `/auth/me` and `/users/{id}`.
///
/// Token-bearing payloads (OTP verify / refresh) are modeled separately by
/// `AuthResponse`; this type represents the canonical user profile only.
@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    String? phone,
    String? name,
    String? email,
    String? profilePhoto,
    @JsonKey(unknownEnumValue: ProfileStatus.active) ProfileStatus? profileStatus,
    @JsonKey(unknownEnumValue: PlayingRole.batter) PlayingRole? playingRole,
    @JsonKey(unknownEnumValue: BattingStyle.rightHand) BattingStyle? battingStyle,
    @JsonKey(unknownEnumValue: BowlingStyle.rightArm) BowlingStyle? bowlingStyle,
    @JsonKey(unknownEnumValue: BowlingType.medium) BowlingType? bowlingType,
    @JsonKey(unknownEnumValue: ExperienceLevel.local) ExperienceLevel? experienceLevel,
    int? jerseyNumber,
    DateTime? dateOfBirth,
    String? gender,
    String? city,
    String? state,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
