import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crichere_flutter/core/network/dio_client.dart';

part 'auth_provider.g.dart';

@riverpod
FlutterSecureStorage storage(Ref ref) {
  return const FlutterSecureStorage();
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
