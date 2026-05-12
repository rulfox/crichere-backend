import '../entities/admin_entities.dart';
import '../../../../features/league/domain/entities/league.dart';

abstract class AdminRepository {
  Future<PlatformMetrics> getMetrics();
  Future<List<League>> getLeagues({String? status, String? search, int page = 0, int size = 20});
  Future<void> suspendLeague(String leagueId, bool suspended, String? reason);
}
