import '../domain/repositories/admin_repository.dart';
import '../../league/domain/entities/league.dart';
import 'admin_api.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminApi _api;

  AdminRepositoryImpl(this._api);

  // F2: parse paginated Spring Page response — content field holds the list
  @override
  Future<List<League>> getLeagues({String? status, String? search, int page = 0, int size = 50}) async {
    final dynamic response = await _api.getLeagues(status: status, search: search, page: page, size: size);
    // Spring Page wraps list in 'content' field after Dio interceptor unwraps ApiResponse.data
    if (response is List) {
      return (response as List).map((e) => League.fromJson(Map<String, dynamic>.from(e as Map))).toList();
    }
    if (response is Map && response.containsKey('content')) {
      final content = response['content'] as List;
      return content.map((e) => League.fromJson(Map<String, dynamic>.from(e as Map))).toList();
    }
    return [];
  }

  @override
  Future<void> suspendLeague(String leagueId, bool suspended, String? reason) async {
    await _api.suspendLeague(leagueId, {
      'suspended': suspended,
      'reason': reason,
    });
  }
}
