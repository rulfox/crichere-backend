import '../domain/entities/admin_entities.dart';
import '../domain/repositories/admin_repository.dart';
import '../../league/domain/entities/league.dart';
import 'admin_api.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminApi _api;

  AdminRepositoryImpl(this._api);

  @override
  Future<PlatformMetrics> getMetrics() async {
    return await _api.getMetrics();
  }

  @override
  Future<List<League>> getLeagues({String? status, String? search, int page = 0, int size = 20}) async {
    return await _api.getLeagues(status: status, search: search, page: page, size: size);
  }

  @override
  Future<void> suspendLeague(String leagueId, bool suspended, String? reason) async {
    await _api.suspendLeague(leagueId, {
      'suspended': suspended,
      'reason': reason,
    });
  }
}
