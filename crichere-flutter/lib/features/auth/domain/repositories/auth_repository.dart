import '../../data/models/auth_response.dart';
import '../entities/auth_enums.dart';

abstract class AuthRepository {
  Future<void> sendOtp(String phone);
  Future<AuthResponse> verifyOtp(String phone, String code);
  Future<void> claimProfile(String name, PlayingRole playingRole);
  Future<void> logout();
  Future<AuthResponse> getCurrentUser();
  Future<AuthResponse> refreshToken(String token);
  Future<void> updateCricketProfile(String userId, PlayingRole role, String battingStyle, String bowlingStyle);
}
