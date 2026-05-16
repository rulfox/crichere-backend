import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crichere_flutter/core/network/dio_client.dart';
import 'package:crichere_flutter/core/notification/notification_service.dart';
import 'package:crichere_flutter/features/league/presentation/providers/league_repository_provider.dart';

part 'auth_provider.g.dart';

@riverpod
FlutterSecureStorage storage(Ref ref) {
  return const FlutterSecureStorage(
    webOptions: WebOptions(
      dbName: 'crichere_secure',
      useSessionStorage: false,
    ),
  );
}

@riverpod
DioClient dioClient(Ref ref) {
  final storage = ref.watch(storageProvider);
  return DioClient(storage);
}

enum AuthState { authenticated, unauthenticated, initial }

@riverpod
class AuthStateNotifier extends _$AuthStateNotifier {
  @override
  AuthState build() => AuthState.initial;

  void setAuthenticated() => state = AuthState.authenticated;
  void setUnauthenticated() => state = AuthState.unauthenticated;
}

@riverpod
Future<void> authCheck(Ref ref) async {
  final storage = ref.watch(storageProvider);
  final token = await storage.read(key: 'accessToken');
  if (token != null) {
    ref.read(authStateProvider.notifier).setAuthenticated();
  } else {
    ref.read(authStateProvider.notifier).setUnauthenticated();
  }
}

@riverpod
NotificationService notificationService(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  final dio = ref.watch(dioClientProvider).dio;
  return NotificationService(db, dio);
}
