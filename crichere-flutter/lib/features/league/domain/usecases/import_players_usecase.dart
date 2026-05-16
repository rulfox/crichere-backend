import '../repositories/league_repository.dart';

class ImportPlayersUseCase {
  final LeagueRepository _repository;
  ImportPlayersUseCase(this._repository);

  // B3: Changed from File CSV to JSON list matching backend PlayerImportRequest
  Future<void> call(String leagueId, List<Map<String, dynamic>> players) {
    return _repository.importPlayers(leagueId, players);
  }
}
