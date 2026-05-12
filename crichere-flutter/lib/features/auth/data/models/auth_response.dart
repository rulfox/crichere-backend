import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/auth_enums.dart';

part 'auth_response.freezed.dart';
part 'auth_response.g.dart';

@freezed
abstract class AuthResponse with _$AuthResponse {
  const AuthResponse._();

  const factory AuthResponse({
    String? accessToken,
    String? refreshToken,
    String? userId,
    String? phone,
    String? name,
    ProfileStatus? profileStatus,
    @Default(false) bool isNewUser,
    String? profileId,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);
}
