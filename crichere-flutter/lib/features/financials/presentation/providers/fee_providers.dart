import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/fee_entities.dart';
import '../../../league/presentation/providers/league_repository_provider.dart';

part 'fee_providers.g.dart';

@riverpod
Future<List<FeeObligation>> feeObligations(Ref ref, String leagueId) {
  return ref.watch(leagueRepositoryProvider).getFeeObligations(leagueId);
}

/// Authoritative fee totals from the backend (`GET /leagues/{id}/fees/summary`).
@riverpod
Future<FeeSummary> feeSummary(Ref ref, String leagueId) {
  return ref.watch(leagueRepositoryProvider).getFeeSummary(leagueId);
}
