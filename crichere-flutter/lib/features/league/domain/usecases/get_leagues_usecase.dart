import '../repositories/league_repository.dart';
import '../entities/league.dart';

class GetLeaguesUseCase {
  final LeagueRepository _repository;
  GetLeaguesUseCase(this._repository);

  Future<List<League>> call({bool forceRefresh = false}) {
    return _repository.getLeagues(forceRefresh: forceRefresh);
  }
}
