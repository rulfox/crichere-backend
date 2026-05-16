import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:crichere_flutter/core/network/api_endpoints.dart';
import 'package:crichere_flutter/core/providers/auth_provider.dart';
import '../../data/auction_api.dart';
import '../../data/auction_repository_impl.dart';
import '../../domain/repositories/auction_repository.dart';
import '../../domain/entities/auction_event.dart';
import '../../domain/entities/auction_summary.dart';

part 'auction_provider.g.dart';

@riverpod
Stream<AuctionEvent> auctionEvents(Ref ref, String auctionId) async* {
  final api = ref.watch(auctionApiProvider);
  final dio = ref.watch(dioClientProvider).dio;
  int backoffSeconds = 2;
  const int maxBackoff = 30;

  while (true) {
    try {
      // 1. Mandated Sync: Fetch current state first
      await api.getAuctionState(auctionId);

      // 2. Open SSE stream via dio (replaces eventsource package)
      final url = '${ApiEndpoints.baseUrl}/auctions/$auctionId/events';
      final response = await dio.get<ResponseBody>(
        url,
        options: Options(
          responseType: ResponseType.stream,
          headers: {
            'Accept': 'text/event-stream',
            'Cache-Control': 'no-cache',
          },
        ),
      );

      backoffSeconds = 2;

      final lines = response.data!.stream
          .cast<List<int>>()
          .transform(utf8.decoder)
          .transform(const LineSplitter());

      await for (final line in lines) {
        if (line.startsWith('data:')) {
          final data = line.substring(5).trim();
          if (data.isNotEmpty) {
            final json = jsonDecode(data);
            yield AuctionEvent.fromJson(json);
          }
        }
      }
    } catch (e) {
      await Future.delayed(Duration(seconds: backoffSeconds));
      backoffSeconds = (backoffSeconds * 2).clamp(2, maxBackoff);
    }
  }
}

@riverpod
AuctionApi auctionApi(Ref ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return AuctionApi(dio);
}

@riverpod
AuctionRepository auctionRepository(Ref ref) {
  final api = ref.watch(auctionApiProvider);
  return AuctionRepositoryImpl(api);
}

@riverpod
Future<AuctionSummary> getAuctionSummary(Ref ref, String auctionId) {
  return ref.watch(auctionRepositoryProvider).getAuctionSummary(auctionId);
}
