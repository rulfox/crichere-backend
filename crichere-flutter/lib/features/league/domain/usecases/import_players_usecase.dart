import '../repositories/league_repository.dart';
import 'dart:io';

class ImportPlayersUseCase {
  final LeagueRepository _repository;
  ImportPlayersUseCase(this._repository);

  Future<void> call(String leagueId, File csvFile) {
    return _repository.importPlayers(leagueId, csvFile);
  }
}
