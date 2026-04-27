import '../repositories/auth_repository.dart';
import '../../data/models/auth_response.dart';

class VerifyOtpUseCase {
  final AuthRepository _repository;
  VerifyOtpUseCase(this._repository);

  Future<AuthResponse> call(String phone, String code) {
    return _repository.verifyOtp(phone, code);
  }
}
