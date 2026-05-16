import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/auth_enums.dart';

part 'auth_response.freezed.dart';
part 'auth_response.g.dart';

// D1: backend /auth/me returns 'id' but OTP verify returns 'userId'.
// This helper reads whichever field is present.
Object? _readUserId(Map<dynamic, dynamic> json, String key) {
  return json['userId'] ?? json['id'];
}

@freezed
abstract class AuthResponse with _$AuthResponse {
  const AuthResponse._();

  const factory AuthResponse({
    String? accessToken,
    String? refreshToken,
    @JsonKey(readValue: _readUserId) String? userId,
    String? phone,
    String? name,
    ProfileStatus? profileStatus,
    @Default(false) bool isNewUser,
    String? profileId,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);
}
