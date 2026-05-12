import '../repositories/auth_repository.dart';
import '../entities/auth_enums.dart';

class ClaimProfileUseCase {
  final AuthRepository _repository;
  ClaimProfileUseCase(this._repository);

  Future<void> call({
    required String name,
    required PlayingRole playingRole,
    required ExperienceLevel experienceLevel,
    required BattingStyle battingStyle,
    required BowlingType bowlingType,
    String? city,
    String? jerseyNumber,
  }) {
    return _repository.claimProfile(
      name: name,
      playingRole: playingRole,
      experienceLevel: experienceLevel,
      battingStyle: battingStyle,
      bowlingType: bowlingType,
      city: city,
      jerseyNumber: jerseyNumber,
    );
  }
}
