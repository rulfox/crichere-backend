import '../entities/league.dart';
import '../../data/models/league_request.dart';
import 'dart:io';

abstract class LeagueRepository {
  Future<List<League>> getLeagues({bool forceRefresh = false});
  Future<League> getLeagueDetail(String id);
  Future<League> createLeague(LeagueCreateRequest request);
  Future<void> importPlayers(String leagueId, File csvFile);
}
