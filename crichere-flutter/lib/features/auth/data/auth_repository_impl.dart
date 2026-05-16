import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/entities/auth_enums.dart';
import 'auth_api.dart';
import 'models/auth_request.dart';
import 'models/auth_response.dart';
import '../../../core/network/page_response.dart';
import '../../league/domain/entities/league.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi _api;
  final FlutterSecureStorage _storage;

  AuthRepositoryImpl(this._api, this._storage);

  @override
  Future<void> sendOtp(String phone) async {
    await _api.sendOtp(LoginRequest(phone: phone));
  }

  @override
  Future<AuthResponse> verifyOtp(String phone, String code) async {
    final response = await _api.verifyOtp(VerifyRequest(phone: phone, code: code));
    if (response.accessToken != null) {
      await _storage.write(key: 'accessToken', value: response.accessToken);
      await _storage.write(key: 'refreshToken', value: response.refreshToken);
    }
    return response;
  }

  @override
  Future<void> claimProfile({
    required String name,
    required PlayingRole playingRole,
    required ExperienceLevel experienceLevel,
    required BattingStyle battingStyle,
    required BowlingType bowlingType,
    String? city,
    String? jerseyNumber,
  }) async {
    await _api.claimProfile(ClaimRequest(
      name: name,
      playingRole: playingRole,
      experienceLevel: experienceLevel,
      battingStyle: battingStyle,
      bowlingType: bowlingType,
      city: city,
      jerseyNumber: int.tryParse(jerseyNumber ?? ''),
    ));
  }

  @override
  Future<void> logout() async {
    try {
      await _api.logout();
    } finally {
      await _storage.deleteAll();
    }
  }

  @override
  Future<AuthResponse> getCurrentUser() async {
    return await _api.getCurrentUser();
  }

  @override
  Future<AuthResponse> getUser(String id) async {
    return await _api.getUser(id);
  }

  @override
  Future<List<League>> getUserLeagues(String id) async {
    return await _api.getUserLeagues(id);
  }

  @override
  Future<AuthResponse> refreshToken(String token) async {
    final response = await _api.refreshToken(RefreshRequest(refreshToken: token));
    if (response.accessToken != null) {
      await _storage.write(key: 'accessToken', value: response.accessToken);
      await _storage.write(key: 'refreshToken', value: response.refreshToken);
    }
    return response;
  }

  @override
  Future<void> updateCricketProfile(String userId, PlayingRole role, String battingStyle, String bowlingStyle) async {
    BattingStyle? batStyle;
    if (battingStyle.toUpperCase() == 'RHB') batStyle = BattingStyle.rightHand;
    if (battingStyle.toUpperCase() == 'LHB') batStyle = BattingStyle.leftHand;
    
    BowlingStyle? bowlStyle;
    if (bowlingStyle.toUpperCase() == 'RAB') bowlStyle = BowlingStyle.rightArm;
    if (bowlingStyle.toUpperCase() == 'LAB') bowlStyle = BowlingStyle.leftArm;

    await _api.updateCricketProfile(
      userId,
      CricketProfileRequest(
        playingRole: role,
        battingStyle: batStyle,
        bowlingStyle: bowlStyle,
      ),
    );
  }

  @override
  Future<PageResponse<AuthResponse>> searchUsers(String query, {int? page, int? size}) async {
    return await _api.searchUsers(query, page: page, size: size);
  }
}
