import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'api_endpoints.dart';

class DioClient {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  // Refresh mutex: when several requests 401 at once, only one refresh runs;
  // the rest await the same future instead of stampeding the refresh endpoint.
  Future<String?>? _refreshFuture;

  DioClient(this._storage)
      : _dio = Dio(
          BaseOptions(
            baseUrl: ApiEndpoints.baseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            contentType: 'application/json',
          ),
        ) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: 'accessToken');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Use `is Map` (not `is Map<String, dynamic>`) because in Flutter Web
        // (dart2js), XHR JSON responses are JavaScript objects that satisfy
        // `Map` but NOT the generic `Map<String, dynamic>` type check.
        if (response.data is Map) {
          final map = response.data as Map;
          if (map.containsKey('data')) {
            response.data = map['data'];
          }
        }
        return handler.next(response);
      },
      onError: (DioException e, handler) async {
        // Only attempt refresh on 401, and never for the refresh call itself
        // (avoids an infinite refresh loop).
        final path = e.requestOptions.path;
        if (e.response?.statusCode == 401 && !path.contains(ApiEndpoints.authRefresh)) {
          final newToken = await _refreshAccessToken();
          if (newToken != null) {
            try {
              e.requestOptions.headers['Authorization'] = 'Bearer $newToken';
              final response = await _dio.fetch(e.requestOptions);
              return handler.resolve(response);
            } catch (_) {
              // Retry failed — fall through to the original error.
            }
          }
        }
        return handler.next(e);
      },
    ));
    
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    }
  }

  /// Refreshes the access token, coalescing concurrent callers onto a single
  /// in-flight refresh. Returns the new access token, or null if refresh failed
  /// (in which case stored credentials are cleared).
  Future<String?> _refreshAccessToken() {
    return _refreshFuture ??= _doRefresh().whenComplete(() => _refreshFuture = null);
  }

  Future<String?> _doRefresh() async {
    final refreshToken = await _storage.read(key: 'refreshToken');
    if (refreshToken == null) return null;
    try {
      // Bare Dio (no interceptors) so a 401 here doesn't recurse.
      final refreshResponse = await Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl)).post(
        ApiEndpoints.authRefresh,
        data: {'refreshToken': refreshToken},
      );
      if (refreshResponse.statusCode == 200) {
        final data = refreshResponse.data is Map && (refreshResponse.data as Map).containsKey('data')
            ? (refreshResponse.data as Map)['data']
            : refreshResponse.data;
        final newAccessToken = data['accessToken'] as String?;
        final newRefreshToken = data['refreshToken'] as String?;
        if (newAccessToken != null) {
          await _storage.write(key: 'accessToken', value: newAccessToken);
          if (newRefreshToken != null) {
            await _storage.write(key: 'refreshToken', value: newRefreshToken);
          }
          return newAccessToken;
        }
      }
    } catch (_) {
      // Refresh failed — clear credentials so the app routes back to login.
      await _storage.deleteAll();
    }
    return null;
  }

  Dio get dio => _dio;
}
