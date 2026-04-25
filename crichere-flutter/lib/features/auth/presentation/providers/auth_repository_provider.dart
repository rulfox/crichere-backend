import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:crichere_flutter/core/providers/auth_provider.dart';
import 'package:crichere_flutter/features/auth/data/auth_api.dart';
import 'package:crichere_flutter/features/auth/data/auth_repository_impl.dart';
import 'package:crichere_flutter/features/auth/domain/repositories/auth_repository.dart';

part 'auth_repository_provider.g.dart';

@riverpod
AuthApi authApi(Ref ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return AuthApi(dio);
}

@riverpod
AuthRepository authRepository(Ref ref) {
  final api = ref.watch(authApiProvider);
  final storage = ref.watch(storageProvider);
  return AuthRepositoryImpl(api, storage);
}
