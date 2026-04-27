import 'package:freezed_annotation/freezed_annotation.dart';
import '../domain/entities/auth_enums.dart';

part 'auth_request.freezed.dart';
part 'auth_request.g.dart';

@freezed
class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String phone,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);
}

@freezed
class VerifyRequest with _$VerifyRequest {
  const factory VerifyRequest({
    required String phone,
    required String code,
  }) = _VerifyRequest;

  factory VerifyRequest.fromJson(Map<String, dynamic> json) => _$VerifyRequestFromJson(json);
}

@freezed
class RefreshRequest with _$RefreshRequest {
  const factory RefreshRequest({
    required String refreshToken,
  }) = _RefreshRequest;

  factory RefreshRequest.fromJson(Map<String, dynamic> json) => _$RefreshRequestFromJson(json);
}

@freezed
class ClaimRequest with _$ClaimRequest {
  const factory ClaimRequest({
    required String name,
    required PlayingRole playingRole,
  }) = _ClaimRequest;

  factory ClaimRequest.fromJson(Map<String, dynamic> json) => _$ClaimRequestFromJson(json);
}

@freezed
class UserBasicInfoRequest with _$UserBasicInfoRequest {
  const factory UserBasicInfoRequest({
    String? name,
    String? email,
  }) = _UserBasicInfoRequest;

  factory UserBasicInfoRequest.fromJson(Map<String, dynamic> json) => _$UserBasicInfoRequestFromJson(json);
}

@freezed
class CricketProfileRequest with _$CricketProfileRequest {
  const factory CricketProfileRequest({
    PlayingRole? playingRole,
    BattingStyle? battingStyle,
    BowlingStyle? bowlingStyle,
    BowlingType? bowlingType,
    ExperienceLevel? experienceLevel,
    int? jerseyNumber,
    String? dateOfBirth, // YYYY-MM-DD
    String? gender,
    String? city,
    String? state,
  }) = _CricketProfileRequest;

  factory CricketProfileRequest.fromJson(Map<String, dynamic> json) => _$CricketProfileRequestFromJson(json);
}
