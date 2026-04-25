import '../repositories/auth_repository.dart';
import '../../data/models/auth_response.dart';

class LoginUseCase {
  final AuthRepository _repository;
  LoginUseCase(this._repository);

  Future<AuthResponse> call(String phone) {
    return _repository.login(phone);
  }
}
