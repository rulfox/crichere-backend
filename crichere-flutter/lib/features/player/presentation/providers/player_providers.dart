import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:crichere_flutter/core/providers/auth_provider.dart';
import '../../data/player_api.dart';
import '../../../league/domain/entities/league_player.dart';

part 'player_providers.g.dart';

@riverpod
PlayerApi playerApi(Ref ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return PlayerApi(dio);
}

/// Registers a user into a league as a player.
@riverpod
Future<LeaguePlayer> registerPlayer(
  Ref ref, {
  required String leagueId,
  required String userId,
  int? basePrice,
  String? category,
  String? tag,
}) {
  return ref.read(playerApiProvider).registerPlayer({
    'leagueId': leagueId,
    'userId': userId,
    if (basePrice != null) 'basePrice': basePrice,
    if (category != null) 'category': category,
    if (tag != null) 'tag': tag,
  });
}

@riverpod
Future<LeaguePlayer> playerById(Ref ref, String id) {
  return ref.read(playerApiProvider).getPlayer(id);
}
