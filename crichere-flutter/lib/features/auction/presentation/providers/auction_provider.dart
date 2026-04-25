import 'dart:async';
import 'dart:convert';
import 'package:eventsource/eventsource.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:crichere_flutter/core/network/api_endpoints.dart';
import 'package:crichere_flutter/core/providers/auth_provider.dart';
import '../providers/auction_state_provider.dart';
import '../../data/auction_api.dart';
import '../../data/auction_repository_impl.dart';
import '../../domain/repositories/auction_repository.dart';
import '../../domain/entities/auction_event.dart';

part 'auction_provider.g.dart';

@riverpod
Stream<AuctionEvent> auctionEvents(Ref ref, String auctionId) async* {
  final api = ref.watch(auctionApiProvider);
  int backoffSeconds = 2;
  const int maxBackoff = 30;

  while (true) {
    try {
      // 1. Mandated Sync: Fetch current state first
      final stateData = await api.getAuctionState(auctionId);
      // We could use this to initialize or verify AuctionStateNotifier
      
      // 2. Open SSE stream
      final url = '${ApiEndpoints.baseUrl}/auctions/$auctionId/events';
      final eventSource = await EventSource.connect(url);
      
      backoffSeconds = 2;

      await for (final event in eventSource) {
        if (event.data != null) {
          final json = jsonDecode(event.data!);
          yield AuctionEvent.fromJson(json);
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
