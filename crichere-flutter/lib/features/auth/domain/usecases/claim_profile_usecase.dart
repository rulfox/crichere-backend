import '../repositories/auth_repository.dart';
import '../entities/auth_enums.dart';

class ClaimProfileUseCase {
  final AuthRepository _repository;
  ClaimProfileUseCase(this._repository);

  Future<void> call(String name, PlayingRole playingRole) {
    return _repository.claimProfile(name, playingRole);
  }
}
