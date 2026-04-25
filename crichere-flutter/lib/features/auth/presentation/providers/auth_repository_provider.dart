import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:crichere_flutter/core/providers/auth_provider.dart';
import 'package:crichere_flutter/features/auth/data/auth_api.dart';
import 'package:crichere_flutter/features/auth/data/auth_repository_impl.dart';
import 'package:crichere_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:crichere_flutter/features/auth/domain/usecases/login_usecase.dart';
import 'package:crichere_flutter/features/auth/domain/usecases/claim_profile_usecase.dart';
import 'package:crichere_flutter/features/auth/domain/usecases/logout_usecase.dart';

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

@riverpod
LoginUseCase loginUseCase(Ref ref) => LoginUseCase(ref.watch(authRepositoryProvider));

@riverpod
ClaimProfileUseCase claimProfileUseCase(Ref ref) => ClaimProfileUseCase(ref.watch(authRepositoryProvider));

@riverpod
LogoutUseCase logoutUseCase(Ref ref) => LogoutUseCase(ref.watch(authRepositoryProvider));
