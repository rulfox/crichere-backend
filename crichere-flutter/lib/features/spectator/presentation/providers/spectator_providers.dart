import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:crichere_flutter/core/network/api_endpoints.dart';
import 'package:crichere_flutter/core/network/sse_client.dart';
import '../../../auction/domain/entities/auction_event.dart';
import '../../../auction/domain/entities/auction_state_snapshot.dart';
import '../../data/public_auction_api.dart';

part 'spectator_providers.g.dart';

/// A Dio instance for the public spectator endpoints: NO auth interceptor and
/// NO 401-refresh, but it still unwraps the `ApiResponse` envelope so Retrofit
/// deserializes the inner payload.
@riverpod
Dio publicDio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      contentType: 'application/json',
    ),
  );
  dio.interceptors.add(
    InterceptorsWrapper(
      onResponse: (response, handler) {
        // `is Map` (not `Map<String, dynamic>`) for dart2js web compatibility.
        if (response.data is Map) {
          final map = response.data as Map;
          if (map.containsKey('data')) {
            response.data = map['data'];
          }
        }
        return handler.next(response);
      },
    ),
  );
  return dio;
}

@riverpod
PublicAuctionApi publicAuctionApi(Ref ref) {
  return PublicAuctionApi(ref.watch(publicDioProvider));
}

@riverpod
Future<AuctionStateSnapshot> publicAuctionState(Ref ref, String auctionId) {
  return ref.watch(publicAuctionApiProvider).getPublicState(auctionId);
}

@riverpod
Future<AuctionStateSnapshot> publicAuctionView(Ref ref, String token) {
  return ref.watch(publicAuctionApiProvider).getPublicView(token);
}

@riverpod
Future<dynamic> publicViewStatus(Ref ref, String token) {
  return ref.watch(publicAuctionApiProvider).getViewStatus(token);
}

/// Public live event stream by auction id (no auth). Auto-reconnects with
/// `Last-Event-ID` replay; first event is the [AuctionEvent.snapshot].
@riverpod
Stream<AuctionEvent> publicAuctionEvents(Ref ref, String auctionId) {
  final dio = ref.watch(publicDioProvider);
  final client = AuctionSseClient(
    dio: dio,
    url: '${ApiEndpoints.baseUrl}/public/auctions/$auctionId/events',
  );
  ref.onDispose(client.close);
  return client.connect();
}

/// Public live event stream by share token (no auth).
@riverpod
Stream<AuctionEvent> publicViewEvents(Ref ref, String token) {
  final dio = ref.watch(publicDioProvider);
  final client = AuctionSseClient(
    dio: dio,
    url: '${ApiEndpoints.baseUrl}/public/auctions/view/$token/events',
  );
  ref.onDispose(client.close);
  return client.connect();
}
