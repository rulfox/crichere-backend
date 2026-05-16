import '../../../../features/league/domain/entities/league.dart';

abstract class AdminRepository {
  // F1: getMetrics() removed — /admin/metrics does not exist in backend
  Future<List<League>> getLeagues({String? status, String? search, int page = 0, int size = 50});
  Future<void> suspendLeague(String leagueId, bool suspended, String? reason);
}
