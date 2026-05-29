import '../../data/models/auth_response.dart';
import '../entities/auth_enums.dart';
import '../entities/user_profile.dart';
import '../../../../core/network/page_response.dart';
import '../../../league/domain/entities/league.dart';

abstract class AuthRepository {
  Future<void> sendOtp(String phone);
  Future<AuthResponse> verifyOtp(String phone, String code);
  Future<void> claimProfile({
    required String name,
    required PlayingRole playingRole,
    required ExperienceLevel experienceLevel,
    required BattingStyle battingStyle,
    required BowlingType bowlingType,
    String? city,
    String? jerseyNumber,
  });
  Future<void> logout();
  Future<UserProfile> getCurrentUser();
  Future<UserProfile> getUser(String id);
  Future<List<League>> getUserLeagues(String id);
  Future<AuthResponse> refreshToken(String token);
  Future<void> updateCricketProfile(String userId, PlayingRole role, String battingStyle, String bowlingStyle);
  Future<PageResponse<AuthResponse>> searchUsers(String query, {int? page, int? size});
}
