import 'package:flutter_test/flutter_test.dart';
import 'package:crichere_flutter/core/enums/backend_enums.dart';
import 'package:crichere_flutter/features/auth/domain/entities/user_profile.dart';
import 'package:crichere_flutter/features/auth/domain/entities/auth_enums.dart';
import 'package:crichere_flutter/features/league/domain/entities/league.dart';
import 'package:crichere_flutter/features/league/domain/entities/league_prices.dart';
import 'package:crichere_flutter/features/auction/domain/entities/auction_summary.dart';
import 'package:crichere_flutter/features/auction/domain/entities/auction_models.dart';
import 'package:crichere_flutter/features/auction/domain/entities/auction_state_snapshot.dart';
import 'package:crichere_flutter/features/financials/domain/entities/fee_entities.dart';
import 'package:crichere_flutter/features/notifications/domain/entities/notification_entities.dart';

void main() {
  group('League', () {
    test('parses auctionIds and derives currentAuctionId', () {
      final league = League.fromJson({
        'id': 'l-1',
        'name': 'CPL',
        'status': 'OPEN',
        'createdBy': 'u-1',
        'auctionIds': ['a-1', 'a-2'],
      });
      expect(league.auctionIds, ['a-1', 'a-2']);
      expect(league.currentAuctionId, 'a-1');
    });

    test('currentAuctionId is null when no auctions', () {
      final league = League.fromJson({
        'id': 'l-1',
        'name': 'CPL',
        'status': 'DRAFT',
        'createdBy': 'u-1',
      });
      expect(league.auctionIds, isEmpty);
      expect(league.currentAuctionId, isNull);
    });
  });

  group('UserProfile', () {
    test('parses full profile', () {
      final u = UserProfile.fromJson({
        'id': 'u-1',
        'phone': '+10000000000',
        'name': 'Rohit',
        'email': 'r@x.com',
        'playingRole': 'ALL_ROUNDER',
        'battingStyle': 'LEFT_HAND',
        'jerseyNumber': 45,
        'city': 'Mumbai',
      });
      expect(u.id, 'u-1');
      expect(u.playingRole, PlayingRole.allRounder);
      expect(u.battingStyle, BattingStyle.leftHand);
      expect(u.jerseyNumber, 45);
    });

    test('unknown enum value falls back instead of throwing', () {
      final u = UserProfile.fromJson({
        'id': 'u-1',
        'playingRole': 'SOMETHING_NEW',
      });
      // unknownEnumValue maps to the configured fallback (PlayingRole.batter).
      expect(u.playingRole, PlayingRole.batter);
    });
  });

  group('AuctionSummary', () {
    test('reads backend field names and Long totalSpent as int', () {
      final s = AuctionSummary.fromJson({
        'auctionId': 'a-1',
        'leagueId': 'l-1',
        'leagueName': 'CPL',
        'status': 'COMPLETED',
        'totalPlayers': 50,
        'totalSold': 40,
        'totalUnsold': 8,
        'totalWithdrawn': 2,
        'totalSpent': 1250000,
        'highestSale': {'playerName': 'V', 'franchiseName': 'RR', 'amount': 90000},
        'franchiseSummaries': [
          {'franchiseId': 'f-1', 'franchiseName': 'RR', 'squadCount': 11, 'totalSpent': 400000, 'remainingPurse': 100000},
        ],
      });
      expect(s.status, AuctionStatus.completed);
      expect(s.totalSpent, 1250000);
      expect(s.totalWithdrawn, 2);
      expect(s.highestSale?.amount, 90000);
      expect(s.franchiseSummaries.single.squadCount, 11);
    });
  });

  group('Auction models', () {
    test('BidResponse parses status enum', () {
      final b = BidResponse.fromJson({
        'id': 'b-1',
        'auctionId': 'a-1',
        'roundId': 'r-1',
        'leaguePlayerId': 'lp-1',
        'franchiseId': 'f-1',
        'bidAmount': 3000,
        'status': 'ACTIVE',
      });
      expect(b.status, BidStatus.active);
      expect(b.bidAmount, 3000);
    });

    test('AuditLogResponse keeps payload map + action enum', () {
      final a = AuditLogResponse.fromJson({
        'id': 'al-1',
        'auctionId': 'a-1',
        'sequenceNumber': 7,
        'action': 'BID_PLACED',
        'payload': {'bidAmount': 3000, 'franchiseId': 'f-1'},
      });
      expect(a.action, AuctionAction.bidPlaced);
      expect(a.sequenceNumber, 7);
      expect(a.payload['bidAmount'], 3000);
    });

    test('RoundConfig parses enums and defaults slabs', () {
      final r = RoundConfig.fromJson({
        'roundNumber': 1,
        'currencyType': 'POINTS',
        'purseSource': 'FRESH',
        'bidMode': 'EACH_BID_RECORDED',
        'playerPoolSource': 'ALL_REGISTERED',
        'franchiseEligibilityRule': 'ALL',
        'completionTrigger': 'AUCTIONEER_MANUAL',
      });
      expect(r.currencyType, CurrencyType.points);
      expect(r.bidMode, BidMode.eachBidRecorded);
      expect(r.bidIncrementSlabs, isEmpty);
    });

    test('FranchisePurseState parses amounts', () {
      final p = FranchisePurseState.fromJson({
        'id': 'ps-1',
        'franchiseId': 'f-1',
        'currentAmount': 80000,
        'reservedAmount': 5000,
        'franchiseName': 'RR',
      });
      expect(p.currentAmount, 80000);
      expect(p.reservedAmount, 5000);
    });
  });

  group('Financials & misc', () {
    test('FeeSummary parses totals', () {
      final f = FeeSummary.fromJson({
        'totalExpected': 100000,
        'totalCollected': 60000,
        'balanceDue': 40000,
        'unpaidCount': 3,
        'partiallyPaidCount': 1,
        'paidCount': 6,
        'waivedCount': 0,
      });
      expect(f.totalCollected, 60000);
      expect(f.balanceDue, 40000);
      expect(f.paidCount, 6);
    });

    test('CategoryPrice / TagPrice parse', () {
      expect(CategoryPrice.fromJson({'id': 'c-1', 'category': 'ICON', 'price': 5000}).price, 5000);
      expect(TagPrice.fromJson({'id': 't-1', 'tag': 'MARQUEE', 'price': 8000}).tag, 'MARQUEE');
    });

    test('AppNotification falls back on unknown type', () {
      final n = AppNotification.fromJson({
        'id': 'n-1',
        'userId': 'u-1',
        'type': 'FUTURE_TYPE',
        'title': 'Hi',
        'body': 'There',
      });
      expect(n.type, NotificationType.unknown);
      expect(n.readAt, isNull);
    });
  });
}
