import 'dart:async';
import 'dart:convert';
import 'package:eventsource/eventsource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../domain/entities/auction_event.dart';

final auctionEventsProvider = StreamProvider.family<AuctionEvent, String>((ref, auctionId) async* {
  int backoffSeconds = 2;
  const int maxBackoff = 30;

  while (true) {
    try {
      final url = '${ApiEndpoints.baseUrl}/auctions/$auctionId/events';
      final eventSource = await EventSource.connect(url);
      
      backoffSeconds = 2; // Reset backoff on successful connection

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
});
