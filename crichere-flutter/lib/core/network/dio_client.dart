import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'api_endpoints.dart';

class DioClient {
  final Dio _dio;
  final FlutterSecureStorage _storage;

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
        if (e.response?.statusCode == 401) {
          final refreshToken = await _storage.read(key: 'refreshToken');
          if (refreshToken != null) {
            try {
              final refreshResponse = await Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl)).post(
                ApiEndpoints.authRefresh,
                data: {'refreshToken': refreshToken},
              );
              
              if (refreshResponse.statusCode == 200) {
                final newAccessToken = refreshResponse.data['accessToken'];
                final newRefreshToken = refreshResponse.data['refreshToken'];
                
                await _storage.write(key: 'accessToken', value: newAccessToken);
                await _storage.write(key: 'refreshToken', value: newRefreshToken);
                
                // Retry the original request
                e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
                final response = await _dio.fetch(e.requestOptions);
                return handler.resolve(response);
              }
            } catch (refreshError) {
              // Refresh failed, logout user
              await _storage.deleteAll();
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

  Dio get dio => _dio;
}
