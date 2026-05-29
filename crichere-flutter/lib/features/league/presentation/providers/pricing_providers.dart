import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'league_repository_provider.dart';
import '../../domain/entities/league_prices.dart';

part 'pricing_providers.g.dart';

@riverpod
Future<List<CategoryPrice>> categoryPrices(Ref ref, String leagueId) {
  return ref.watch(leagueRepositoryProvider).getCategoryPrices(leagueId);
}

@riverpod
Future<List<TagPrice>> tagPrices(Ref ref, String leagueId) {
  return ref.watch(leagueRepositoryProvider).getTagPrices(leagueId);
}
