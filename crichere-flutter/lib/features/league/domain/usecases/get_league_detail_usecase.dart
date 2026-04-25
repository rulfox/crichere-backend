import '../repositories/league_repository.dart';
import '../entities/league.dart';

class GetLeagueDetailUseCase {
  final LeagueRepository _repository;
  GetLeagueDetailUseCase(this._repository);

  Future<League> call(String id) {
    return _repository.getLeagueDetail(id);
  }
}
