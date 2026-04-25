import '../entities/league.dart';

abstract class LeagueRepository {
  Future<List<League>> getLeagues({bool forceRefresh = false});
  Future<League> getLeagueDetail(String id);
}
