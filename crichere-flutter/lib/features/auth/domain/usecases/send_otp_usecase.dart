import '../repositories/auth_repository.dart';

class SendOtpUseCase {
  final AuthRepository _repository;
  SendOtpUseCase(this._repository);

  Future<void> call(String phone) {
    return _repository.sendOtp(phone);
  }
}
