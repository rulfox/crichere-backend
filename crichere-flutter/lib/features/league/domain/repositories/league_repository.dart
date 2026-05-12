import 'dart:io';
import '../entities/league.dart';
import '../entities/league_player.dart';
import '../../../franchise/domain/entities/franchise.dart';
import '../../data/models/league_request.dart';

abstract class LeagueRepository {
  Future<List<League>> getLeagues({bool forceRefresh = false});
  Future<League> getLeagueDetail(String id);
  Future<League> createLeague(LeagueCreateRequest request);
  Future<void> importPlayers(String leagueId, File file);
  Future<List<Franchise>> getFranchises(String leagueId);
  Future<List<LeaguePlayer>> getLeaguePlayers(String leagueId);
}


