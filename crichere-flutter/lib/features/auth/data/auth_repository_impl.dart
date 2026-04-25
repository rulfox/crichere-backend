import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../domain/repositories/auth_repository.dart';
import 'auth_api.dart';
import 'models/auth_request.dart';
import 'models/auth_response.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi _api;
  final FlutterSecureStorage _storage;

  AuthRepositoryImpl(this._api, this._storage);

  @override
  Future<AuthResponse> login(String phone) async {
    return await _api.login(LoginRequest(phone: phone));
  }

  @override
  Future<AuthResponse> verify(String phone, String otp) async {
    final response = await _api.verify(VerifyRequest(phone: phone, otp: otp));
    if (response.accessToken != null) {
      await _storage.write(key: 'accessToken', value: response.accessToken);
      await _storage.write(key: 'refreshToken', value: response.refreshToken);
    }
    return response;
  }

  @override
  Future<void> claimProfile(String profileId) async {
    await _api.claim(ClaimRequest(profileId: profileId));
  }

  @override
  Future<void> logout() async {
    await _storage.deleteAll();
  }
}
