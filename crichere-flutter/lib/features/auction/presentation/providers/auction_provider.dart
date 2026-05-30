import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:crichere_flutter/core/network/api_endpoints.dart';
import 'package:crichere_flutter/core/network/sse_client.dart';
import 'package:crichere_flutter/core/providers/auth_provider.dart';
import '../../data/auction_api.dart';
import '../../data/auction_repository_impl.dart';
import '../../domain/repositories/auction_repository.dart';
import '../../domain/entities/auction_event.dart';
import '../../domain/entities/auction_summary.dart';
import '../../domain/entities/auction_state_snapshot.dart';
import '../../domain/entities/auction_models.dart';

part 'auction_provider.g.dart';

/// Tracks the SSE connection lifecycle for an auction so the UI can show
/// connecting / live / reconnecting states. Updated by [auctionEvents].
@riverpod
class AuctionConnection extends _$AuctionConnection {
  @override
  SseConnectionStatus build(String auctionId) => SseConnectionStatus.connecting;

  // ignore: use_setters_to_change_properties
  void update(SseConnectionStatus status) => state = status;
}

/// Live auction event stream. Auto-reconnects with `Last-Event-ID` replay; the
/// first event is always a [AuctionEvent.snapshot]. The bearer token is attached
/// by the shared Dio interceptor.
@riverpod
Stream<AuctionEvent> auctionEvents(Ref ref, String auctionId) {
  final dio = ref.read(dioClientProvider).dio;
  final client = AuctionSseClient(
    dio: dio,
    url: '${ApiEndpoints.baseUrl}/auctions/$auctionId/events',
    onStatus: (status) {
      // Fired asynchronously while the stream is live; safe to push into the
      // sibling connection provider.
      ref.read(auctionConnectionProvider(auctionId).notifier).update(status);
    },
  );
  ref.onDispose(client.close);
  return client.connect();
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

/// Rounds configured for an auction (League Detail → Rounds tab).
@riverpod
Future<List<RoundConfig>> auctionRounds(Ref ref, String auctionId) {
  return ref.watch(auctionRepositoryProvider).getRounds(auctionId);
}

/// Audit log for an auction, newest first (League Detail → Audit tab).
@riverpod
Future<List<AuditLogResponse>> auctionAuditLog(Ref ref, String auctionId) async {
  final log = await ref.watch(auctionRepositoryProvider).getAuditLog(auctionId);
  return log.reversed.toList();
}
