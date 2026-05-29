import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crichere_flutter/core/providers/auth_provider.dart';
import '../../data/admin_api.dart';
import '../../data/admin_repository_impl.dart';
import '../../domain/repositories/admin_repository.dart';
import '../../domain/entities/admin_user.dart';
import '../../../../features/league/domain/entities/league.dart';

final adminApiProvider = Provider<AdminApi>((ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return AdminApi(dio);
});

final adminRepositoryProvider = Provider<AdminRepository>((ref) {
  final api = ref.watch(adminApiProvider);
  return AdminRepositoryImpl(api);
});

// F1: platformMetricsProvider removed — /admin/metrics endpoint does not exist

final adminLeaguesProvider = FutureProvider<List<League>>((ref) {
  return ref.watch(adminRepositoryProvider).getLeagues();
});

/// Platform-admin user list, optionally filtered by a search string.
final adminUsersProvider = FutureProvider.family<List<AdminUser>, String?>((ref, search) {
  return ref.watch(adminRepositoryProvider).getUsers(
        search: (search != null && search.trim().isNotEmpty) ? search.trim() : null,
      );
});
