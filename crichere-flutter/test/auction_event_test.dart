import 'package:flutter_test/flutter_test.dart';
import 'package:crichere_flutter/core/enums/backend_enums.dart';
import 'package:crichere_flutter/features/auction/domain/entities/auction_event.dart';
import 'package:crichere_flutter/features/auction/domain/entities/auction_state_snapshot.dart';

void main() {
  group('AuctionEvent.fromEnvelope', () {
    test('PLAYER_UP maps backend payload keys', () {
      final event = AuctionEvent.fromEnvelope('PLAYER_UP', {
        'leaguePlayerId': 'lp-1',
        'playerName': 'V Kohli',
        'basePrice': 2000,
        'roundId': 'r-1',
      });
      expect(event, isA<PlayerUpEvent>());
      final e = event as PlayerUpEvent;
      expect(e.leaguePlayerId, 'lp-1');
      expect(e.playerName, 'V Kohli');
      expect(e.basePrice, 2000);
      expect(e.roundId, 'r-1');
    });

    test('BID_PLACED maps bidAmount and previous bidder', () {
      final e = AuctionEvent.fromEnvelope('BID_PLACED', {
        'leaguePlayerId': 'lp-1',
        'franchiseId': 'f-9',
        'bidAmount': 3500,
        'previousHighestBid': 3000,
        'previousHighestBidder': 'f-2',
      }) as BidPlacedEvent;
      expect(e.franchiseId, 'f-9');
      expect(e.bidAmount, 3500);
      expect(e.previousHighestBid, 3000);
      expect(e.previousHighestBidder, 'f-2');
    });

    test('PLAYER_SOLD maps finalPrice', () {
      final e = AuctionEvent.fromEnvelope('PLAYER_SOLD', {
        'leaguePlayerId': 'lp-1',
        'franchiseId': 'f-9',
        'finalPrice': 5000,
        'roundId': 'r-1',
      }) as PlayerSoldEvent;
      expect(e.finalPrice, 5000);
      expect(e.franchiseId, 'f-9');
    });

    test('TIMER_STARTED tolerates ISO startedAt and numeric fields', () {
      final e = AuctionEvent.fromEnvelope('TIMER_STARTED', {
        'durationSeconds': 60,
        'startedAt': '2026-05-29T10:00:00Z',
        'antiSnipeSeconds': 10,
        'leaguePlayerId': 'lp-1',
      }) as TimerStartedEvent;
      expect(e.durationSeconds, 60);
      expect(e.antiSnipeSeconds, 10);
      expect(e.startedAt, isNotNull);
    });

    test('SNAPSHOT decodes a full AuctionStateSnapshot', () {
      final event = AuctionEvent.fromEnvelope('SNAPSHOT', {
        'leagueName': 'CPL 2026',
        'auctionStatus': 'LIVE',
        'currentHighestBid': 4000,
        'currentHighestBidderId': 'f-1',
        'franchisePurseStates': [
          {
            'id': 'ps-1',
            'franchiseId': 'f-1',
            'currentAmount': 100000,
            'reservedAmount': 0,
            'franchiseName': 'Royals',
          },
        ],
        'lastSequenceNumber': 42,
      });
      expect(event, isA<AuctionSnapshotEvent>());
      final snap = (event as AuctionSnapshotEvent).snapshot;
      expect(snap.leagueName, 'CPL 2026');
      expect(snap.auctionStatus, AuctionStatus.live);
      expect(snap.franchisePurseStates.single.franchiseName, 'Royals');
      expect(snap.lastSequenceNumber, 42);
    });

    test('unknown server action falls back to UnknownAuctionEvent', () {
      final event = AuctionEvent.fromEnvelope('SOME_NEW_ACTION', {'x': 1});
      expect(event, isA<UnknownAuctionEvent>());
      expect((event as UnknownAuctionEvent).event, 'SOME_NEW_ACTION');
    });

    test('unknown enum value deserializes to .unknown (no crash)', () {
      final snap = AuctionStateSnapshot.fromJson({
        'leagueName': 'X',
        'auctionStatus': 'SOME_FUTURE_STATUS',
        'lastSequenceNumber': 0,
      });
      expect(snap.auctionStatus, AuctionStatus.unknown);
    });
  });
}
