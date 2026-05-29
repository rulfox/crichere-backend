import '../domain/repositories/admin_repository.dart';
import '../domain/entities/admin_user.dart';
import '../../league/domain/entities/league.dart';
import 'admin_api.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminApi _api;

  AdminRepositoryImpl(this._api);

  /// Extracts the list payload from a (possibly) Spring `Page` response after the
  /// Dio interceptor has already unwrapped the `ApiResponse.data` envelope.
  List<Map<String, dynamic>> _pageContent(dynamic response) {
    final List raw;
    if (response is List) {
      raw = response;
    } else if (response is Map && response['content'] is List) {
      raw = response['content'] as List;
    } else {
      return const [];
    }
    return raw.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }

  // F2: parse paginated Spring Page response — content field holds the list
  @override
  Future<List<League>> getLeagues({String? status, String? search, int page = 0, int size = 50}) async {
    final response = await _api.getLeagues(status: status, search: search, page: page, size: size);
    return _pageContent(response).map(League.fromJson).toList();
  }

  @override
  Future<void> suspendLeague(String leagueId, bool suspended, String? reason) async {
    await _api.suspendLeague(leagueId, {
      'suspended': suspended,
      'reason': reason,
    });
  }

  // User management
  @override
  Future<List<AdminUser>> getUsers({String? profileStatus, String? search, int page = 0, int size = 50}) async {
    final response = await _api.getUsers(profileStatus: profileStatus, search: search, page: page, size: size);
    return _pageContent(response).map(AdminUser.fromJson).toList();
  }

  @override
  Future<void> setPlatformAdmin(String userId, bool isAdmin) async {
    await _api.updateUserRole(userId, {'action': isAdmin ? 'ADD' : 'REMOVE'});
  }

  @override
  Future<void> suspendUser(String userId, bool suspended, {String? reason}) async {
    await _api.suspendUser(userId, {
      'suspended': suspended,
      if (reason != null) 'reason': reason,
    });
  }
}
