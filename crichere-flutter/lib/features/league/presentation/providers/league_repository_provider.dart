import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:crichere_flutter/core/database/app_database.dart' hide Franchise, LeaguePlayer, League;
import 'package:crichere_flutter/core/providers/auth_provider.dart';
import 'package:crichere_flutter/features/league/data/league_api.dart';
import 'package:crichere_flutter/features/league/data/league_repository_impl.dart';
import 'package:crichere_flutter/features/league/domain/repositories/league_repository.dart';
import 'package:crichere_flutter/features/league/domain/entities/league.dart' as domain;
import 'package:crichere_flutter/features/league/domain/entities/league_player.dart';
import 'package:crichere_flutter/features/franchise/domain/entities/franchise.dart';
import 'package:crichere_flutter/features/league/domain/usecases/get_leagues_usecase.dart';
import 'package:crichere_flutter/features/league/domain/usecases/get_league_detail_usecase.dart';
import 'package:crichere_flutter/features/league/domain/usecases/create_league_usecase.dart';
import 'package:crichere_flutter/features/league/domain/usecases/import_players_usecase.dart';

part 'league_repository_provider.g.dart';

// keepAlive: the database must be a single instance for the whole app
// lifetime. As an auto-dispose provider it was torn down whenever its last
// listener dropped (e.g. switching tabs) and re-created on the next watch,
// leaving the old AppDatabase open and racing the new one on the same
// WASM/IndexedDB executor — Drift's "created AppDatabase multiple times"
// warning and the cause of flaky cache reads.
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
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
GetLeaguesUseCase getLeaguesUseCase(Ref ref) => GetLeaguesUseCase(ref.watch(leagueRepositoryProvider));

@riverpod
GetLeagueDetailUseCase getLeagueDetailUseCase(Ref ref) => GetLeagueDetailUseCase(ref.watch(leagueRepositoryProvider));

@riverpod
CreateLeagueUseCase createLeagueUseCase(Ref ref) => CreateLeagueUseCase(ref.watch(leagueRepositoryProvider));

@riverpod
ImportPlayersUseCase importPlayersUseCase(Ref ref) => ImportPlayersUseCase(ref.watch(leagueRepositoryProvider));

@riverpod
Future<List<domain.League>> leagues(Ref ref) async {
  return ref.watch(getLeaguesUseCaseProvider).call();
}

@riverpod
Future<List<Franchise>> leagueFranchises(Ref ref, String leagueId) {
  return ref.watch(leagueRepositoryProvider).getFranchises(leagueId);
}

@riverpod
Future<List<LeaguePlayer>> leaguePlayers(Ref ref, String leagueId) {
  return ref.watch(leagueRepositoryProvider).getLeaguePlayers(leagueId);
}
