import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:crichere_flutter/core/database/app_database.dart';
import 'package:crichere_flutter/core/providers/auth_provider.dart';
import 'package:crichere_flutter/features/league/data/league_api.dart';
import 'package:crichere_flutter/features/league/data/league_repository_impl.dart';
import 'package:crichere_flutter/features/league/domain/repositories/league_repository.dart';
import 'package:crichere_flutter/features/league/domain/entities/league.dart' as domain;

part 'league_repository_provider.g.dart';

@riverpod
AppDatabase appDatabase(Ref ref) {
  return AppDatabase();
}

@riverpod
LeagueApi leagueApi(Ref ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return LeagueApi(dio);
}

@riverpod
LeagueRepository leagueRepository(Ref ref) {
  final api = ref.watch(leagueApiProvider);
  final db = ref.watch(appDatabaseProvider);
  return LeagueRepositoryImpl(api, db);
}

@riverpod
Future<List<domain.League>> leagues(Ref ref) async {
  return ref.watch(leagueRepositoryProvider).getLeagues();
}
