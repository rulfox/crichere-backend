import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:crichere_flutter/core/providers/auth_provider.dart';
import 'package:crichere_flutter/core/network/storage_api.dart';
import 'package:crichere_flutter/core/network/photo_upload_service.dart';
import 'package:crichere_flutter/features/auth/presentation/providers/auth_repository_provider.dart';
import '../../data/player_api.dart';
import '../../../league/domain/entities/league_player.dart';

part 'player_providers.g.dart';

@riverpod
PlayerApi playerApi(Ref ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return PlayerApi(dio);
}

@riverpod
StorageApi storageApi(Ref ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return StorageApi(dio);
}

@riverpod
PhotoUploadService photoUploadService(Ref ref) {
  return PhotoUploadService(
    ref.watch(storageApiProvider),
    ref.watch(authApiProvider),
  );
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
