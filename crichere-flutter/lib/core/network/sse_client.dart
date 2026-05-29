import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';

import '../../features/auction/domain/entities/auction_event.dart';

/// Connection lifecycle for an SSE stream, surfaced to the UI.
enum SseConnectionStatus { connecting, open, reconnecting, closed }

/// A resilient Server-Sent-Events client for the auction stream.
///
/// Responsibilities:
///  - Buffers `id:`/`event:`/`data:` lines into blank-line-delimited frames
///    (a naive per-line parser breaks on multi-line `data:` payloads).
///  - Dispatches on the JSON envelope inside each `data:` line — the backend's
///    live frames carry only `data:`, with `event` and the sequence `id` *inside*
///    the JSON (`{"id":<seq>,"event":"<ACTION>","data":{…}}`).
///  - Tracks the last sequence number and resends it as `Last-Event-ID` on
///    reconnect, so a dropped mobile connection resumes via server replay instead
///    of losing events. The SNAPSHOT frame seeds the cursor from
///    `lastSequenceNumber`.
///  - Reconnects automatically with exponential backoff + jitter (2 → 30s).
///  - The auth bearer token is attached by the shared Dio interceptor, so no
///    header wiring is needed here.
class AuctionSseClient {
  AuctionSseClient({
    required Dio dio,
    required String url,
    void Function(SseConnectionStatus status)? onStatus,
    String? initialLastEventId,
  })  : _dio = dio,
        _url = url,
        _onStatus = onStatus,
        _lastEventId = initialLastEventId;

  final Dio _dio;
  final String _url;
  final void Function(SseConnectionStatus status)? _onStatus;
  final Random _rng = Random();

  String? _lastEventId;
  bool _closed = false;

  /// The last sequence number seen, exposed for diagnostics / resume.
  String? get lastEventId => _lastEventId;

  /// Opens the stream and yields parsed [AuctionEvent]s, reconnecting forever
  /// until [close] is called. Transient errors do not surface to the consumer;
  /// they trigger a backoff + reconnect with `Last-Event-ID` replay.
  Stream<AuctionEvent> connect() async* {
    var attempt = 0;
    while (!_closed) {
      _onStatus?.call(
        attempt == 0 ? SseConnectionStatus.connecting : SseConnectionStatus.reconnecting,
      );
      try {
        final headers = <String, String>{
          'Accept': 'text/event-stream',
          'Cache-Control': 'no-cache',
        };
        if (_lastEventId != null) {
          headers['Last-Event-ID'] = _lastEventId!;
        }

        final response = await _dio.get<ResponseBody>(
          _url,
          options: Options(responseType: ResponseType.stream, headers: headers),
        );

        attempt = 0;
        _onStatus?.call(SseConnectionStatus.open);

        final dataLines = <String>[];
        final lines = response.data!.stream
            .cast<List<int>>()
            .transform(utf8.decoder)
            .transform(const LineSplitter());

        await for (final raw in lines) {
          if (_closed) break;

          // Blank line terminates a frame.
          if (raw.isEmpty) {
            if (dataLines.isNotEmpty) {
              final event = _parseFrame(dataLines.join('\n'));
              dataLines.clear();
              if (event != null) yield event;
            }
            continue;
          }
          // Comment / keep-alive (`: ping`).
          if (raw.startsWith(':')) continue;

          final idx = raw.indexOf(':');
          final field = idx == -1 ? raw : raw.substring(0, idx);
          var value = idx == -1 ? '' : raw.substring(idx + 1);
          if (value.startsWith(' ')) value = value.substring(1);

          // We dispatch on the JSON envelope, so only `data:` matters here;
          // the SSE-level `id:` is tracked as a fallback cursor.
          switch (field) {
            case 'data':
              dataLines.add(value);
              break;
            case 'id':
              if (value.isNotEmpty) _lastEventId = value;
              break;
          }
        }
        // Stream completed cleanly — fall through to reconnect.
      } catch (_) {
        // Swallow; backoff + reconnect below.
      }

      if (_closed) break;
      attempt++;
      final backoffSeconds = (2 * (1 << (attempt - 1))).clamp(2, 30);
      final jitterMs = _rng.nextInt(1000);
      await Future<void>.delayed(
        Duration(seconds: backoffSeconds, milliseconds: jitterMs),
      );
    }
    _onStatus?.call(SseConnectionStatus.closed);
  }

  /// Decodes one frame's `data:` JSON envelope into an [AuctionEvent], updating
  /// the `Last-Event-ID` cursor from the envelope's sequence `id` (or, for the
  /// SNAPSHOT frame, from `lastSequenceNumber`). Returns null on malformed JSON.
  AuctionEvent? _parseFrame(String dataStr) {
    if (dataStr.trim().isEmpty) return null;
    try {
      final decoded = jsonDecode(dataStr);
      if (decoded is! Map) return null;
      final map = Map<String, dynamic>.from(decoded);

      final eventName = map['event']?.toString() ?? 'unknown';
      final id = map['id'];
      if (id != null) _lastEventId = id.toString();

      final rawData = map['data'];
      final data = rawData is Map
          ? Map<String, dynamic>.from(rawData)
          : <String, dynamic>{};

      if (eventName == 'SNAPSHOT') {
        final seq = data['lastSequenceNumber'];
        if (seq != null) _lastEventId = seq.toString();
      }

      return AuctionEvent.fromEnvelope(eventName, data);
    } catch (_) {
      return null;
    }
  }

  void close() => _closed = true;
}
