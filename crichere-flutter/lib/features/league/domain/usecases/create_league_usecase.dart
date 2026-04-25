import '../repositories/league_repository.dart';
import '../entities/league.dart';
import '../../data/models/league_request.dart';

class CreateLeagueUseCase {
  final LeagueRepository _repository;
  CreateLeagueUseCase(this._repository);

  Future<League> call(LeagueCreateRequest request) {
    return _repository.createLeague(request);
  }
}
