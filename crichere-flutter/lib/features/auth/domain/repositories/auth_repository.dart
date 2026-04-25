import '../../data/models/auth_response.dart';

abstract class AuthRepository {
  Future<AuthResponse> login(String phone);
  Future<AuthResponse> verify(String phone, String otp);
  Future<void> claimProfile(String profileId);
  Future<void> logout();
}
