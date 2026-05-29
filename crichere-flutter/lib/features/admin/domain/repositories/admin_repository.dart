import '../../../../features/league/domain/entities/league.dart';
import '../entities/admin_user.dart';

abstract class AdminRepository {
  // F1: getMetrics() removed — /admin/metrics does not exist in backend
  Future<List<League>> getLeagues({String? status, String? search, int page = 0, int size = 50});
  Future<void> suspendLeague(String leagueId, bool suspended, String? reason);

  // User management
  Future<List<AdminUser>> getUsers({String? profileStatus, String? search, int page = 0, int size = 50});
  /// Adds (`isAdmin = true`) or removes (`false`) the platform-admin role.
  Future<void> setPlatformAdmin(String userId, bool isAdmin);
  Future<void> suspendUser(String userId, bool suspended, {String? reason});
}
