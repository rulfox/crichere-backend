import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/forfeit_entities.dart';
import '../../../league/presentation/providers/league_repository_provider.dart';

part 'forfeit_providers.g.dart';

@riverpod
Future<List<ForfeitRequest>> forfeitRequests(Ref ref, String leagueId) {
  return ref.watch(leagueRepositoryProvider).getForfeitRequests(leagueId);
}
