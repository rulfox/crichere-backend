import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:crichere_flutter/core/database/app_database.dart';
import 'package:crichere_flutter/core/providers/auth_provider.dart';
import 'package:crichere_flutter/features/league/data/league_api.dart';
import 'package:crichere_flutter/features/league/data/league_repository_impl.dart';
import 'package:crichere_flutter/features/league/domain/repositories/league_repository.dart';
import 'package:crichere_flutter/features/league/domain/entities/league.dart' as domain;
import 'package:crichere_flutter/features/league/domain/usecases/get_leagues_usecase.dart';
import 'package:crichere_flutter/features/league/domain/usecases/get_league_detail_usecase.dart';
import 'package:crichere_flutter/features/league/domain/usecases/create_league_usecase.dart';
import 'package:crichere_flutter/features/league/domain/usecases/import_players_usecase.dart';

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
