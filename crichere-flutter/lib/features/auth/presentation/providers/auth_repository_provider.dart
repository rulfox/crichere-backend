import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:crichere_flutter/core/providers/auth_provider.dart';
import 'package:crichere_flutter/features/auth/data/auth_api.dart';
import 'package:crichere_flutter/features/auth/data/auth_repository_impl.dart';
import 'package:crichere_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:crichere_flutter/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:crichere_flutter/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:crichere_flutter/features/auth/domain/usecases/claim_profile_usecase.dart';
import 'package:crichere_flutter/features/auth/domain/usecases/logout_usecase.dart';
import 'package:crichere_flutter/features/auth/domain/entities/user_profile.dart';

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
Future<UserProfile> currentUser(Ref ref) {
  return ref.watch(authRepositoryProvider).getCurrentUser();
}

/// Resolves a user by id (e.g. to show a league organiser's name instead of a
/// raw UUID). Backend `LeagueResponse` carries only `createdBy: UUID`, so the
/// name has to be fetched separately — see BACKEND_CHANGES_REQUIRED.md.
@riverpod
Future<UserProfile> userById(Ref ref, String id) {
  return ref.watch(authRepositoryProvider).getUser(id);
}

@riverpod
SendOtpUseCase sendOtpUseCase(Ref ref) => SendOtpUseCase(ref.watch(authRepositoryProvider));

@riverpod
VerifyOtpUseCase verifyOtpUseCase(Ref ref) => VerifyOtpUseCase(ref.watch(authRepositoryProvider));

@riverpod
ClaimProfileUseCase claimProfileUseCase(Ref ref) => ClaimProfileUseCase(ref.watch(authRepositoryProvider));

@riverpod
LogoutUseCase logoutUseCase(Ref ref) => LogoutUseCase(ref.watch(authRepositoryProvider));
