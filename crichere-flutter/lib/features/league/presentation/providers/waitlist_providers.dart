import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/waitlist_entities.dart';
import '../../../league/presentation/providers/league_repository_provider.dart';

part 'waitlist_providers.g.dart';

@riverpod
Future<List<WaitlistEntry>> waitlist(Ref ref, String leagueId) {
  return ref.watch(leagueRepositoryProvider).getWaitlist(leagueId);
}
