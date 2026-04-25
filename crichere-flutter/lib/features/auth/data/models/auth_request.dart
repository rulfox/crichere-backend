import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_request.freezed.dart';
part 'auth_request.g.dart';

@freezed
class LoginRequest with _$LoginRequest {
  const LoginRequest._();

  const factory LoginRequest({
    required String phone,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);
}

@freezed
class VerifyRequest with _$VerifyRequest {
  const VerifyRequest._();

  const factory VerifyRequest({
    required String phone,
    required String otp,
  }) = _VerifyRequest;

  factory VerifyRequest.fromJson(Map<String, dynamic> json) => _$VerifyRequestFromJson(json);
}

@freezed
class RefreshRequest with _$RefreshRequest {
  const RefreshRequest._();

  const factory RefreshRequest({
    required String refreshToken,
  }) = _RefreshRequest;

  factory RefreshRequest.fromJson(Map<String, dynamic> json) => _$RefreshRequestFromJson(json);
}

@freezed
class ClaimRequest with _$ClaimRequest {
  const ClaimRequest._();

  const factory ClaimRequest({
    required String profileId,
  }) = _ClaimRequest;

  factory ClaimRequest.fromJson(Map<String, dynamic> json) => _$ClaimRequestFromJson(json);
}
