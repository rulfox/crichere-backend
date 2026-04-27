import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/entities/auth_enums.dart';
import 'auth_api.dart';
import 'models/auth_request.dart';
import 'models/auth_response.dart';

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
  Future<void> claimProfile(String name, PlayingRole playingRole) async {
    await _api.claimProfile(ClaimRequest(name: name, playingRole: playingRole));
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
  Future<AuthResponse> refreshToken(String token) async {
    final response = await _api.refreshToken(RefreshRequest(refreshToken: token));
    if (response.accessToken != null) {
      await _storage.write(key: 'accessToken', value: response.accessToken);
      await _storage.write(key: 'refreshToken', value: response.refreshToken);
    }
    return response;
  }
}
