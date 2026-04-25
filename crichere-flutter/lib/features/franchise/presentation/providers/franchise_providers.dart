import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:crichere_flutter/core/providers/auth_provider.dart';
import '../../data/franchise_api.dart';
import '../../data/franchise_repository_impl.dart';
import '../../domain/repositories/franchise_repository.dart';
import '../../domain/entities/franchise_squad.dart';

part 'franchise_providers.g.dart';

@riverpod
FranchiseApi franchiseApi(Ref ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return FranchiseApi(dio);
}

@riverpod
FranchiseRepository franchiseRepository(Ref ref) {
  final api = ref.watch(franchiseApiProvider);
  return FranchiseRepositoryImpl(api);
}

@riverpod
Future<FranchiseSquad> squad(Ref ref, String franchiseId) {
  return ref.watch(franchiseRepositoryProvider).getSquad(franchiseId);
}
