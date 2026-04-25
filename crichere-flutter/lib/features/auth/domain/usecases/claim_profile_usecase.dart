import '../repositories/auth_repository.dart';

class ClaimProfileUseCase {
  final AuthRepository _repository;
  ClaimProfileUseCase(this._repository);

  Future<void> call(String profileId) {
    return _repository.claimProfile(profileId);
  }
}
