import '../../../core/database/app_database.dart' hide Franchise, LeaguePlayer, League;
import '../domain/entities/league.dart' as domain;
import '../domain/entities/league_player.dart';
import '../../franchise/domain/entities/franchise.dart';
import '../domain/repositories/league_repository.dart';
import 'league_api.dart';
import 'models/league_request.dart';
import '../../financials/domain/entities/fee_entities.dart';
import '../../financials/domain/entities/forfeit_entities.dart';
import '../domain/entities/waitlist_entities.dart';
import '../domain/entities/league_prices.dart';
import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

class LeagueRepositoryImpl implements LeagueRepository {
  final LeagueApi _api;
  final AppDatabase _db;

  LeagueRepositoryImpl(this._api, this._db);

  // The Drift/WASM executor on web can not only throw but *hang* — e.g. when
  // IndexedDB.open never fires success/error (DB blocked, private mode, some
  // hosting setups). An awaited hang would leave the leagues provider stuck in
  // `loading` forever (the white shimmer rectangle). So every cache touch is
  // both swallowed AND time-bounded; the network is always the source of truth.
  static const _cacheTimeout = Duration(seconds: 2);

  @override
  Future<List<domain.League>> getLeagues({bool forceRefresh = false, int? page, int? size}) async {
    if (!forceRefresh && page == null) {
      try {
        final cached = await (_db.select(_db.leagues)).get().timeout(_cacheTimeout);
        if (cached.isNotEmpty) {
          return cached.map((e) => domain.League(
            id: e.id,
            name: e.name,
            format: e.format,
            rulesUrl: e.rulesUrl,
            mustSellAll: e.mustSellAll,
            playerOrderMode: e.playerOrderMode,
            waitingListMode: e.waitingListMode,
            logoUrl: e.logoUrl,
            bannerUrl: e.bannerUrl,
            status: e.status,
            auctionDate: e.auctionDate,
            createdBy: e.createdBy,
          )).toList();
        }
      } catch (e) {
        // Includes TimeoutException when the web executor hangs.
        debugPrint('League cache read skipped (ignored): $e');
      }
    }

    final paged = await _api.getLeagues(page: page, size: size);
    final remote = paged.content;

    // Fire-and-forget the cache write: it must never block (or fail) the
    // network result the UI is waiting on.
    if (page == null || page == 0) {
      unawaited(_cacheLeagues(remote));
    }

    return remote;
  }

  Future<void> _cacheLeagues(List<domain.League> remote) async {
    try {
      await _db.batch((batch) {
        batch.deleteAll(_db.leagues);
        batch.insertAll(_db.leagues, remote.map((e) => LeaguesCompanion.insert(
          id: e.id,
          name: e.name,
          format: Value(e.format),
          rulesUrl: Value(e.rulesUrl),
          mustSellAll: Value(e.mustSellAll),
          playerOrderMode: Value(e.playerOrderMode),
          waitingListMode: Value(e.waitingListMode),
          logoUrl: Value(e.logoUrl),
          bannerUrl: Value(e.bannerUrl),
          status: e.status,
          auctionDate: Value(e.auctionDate),
          createdBy: e.createdBy,
        )).toList());
      }).timeout(_cacheTimeout);
    } catch (e) {
      debugPrint('League cache write skipped (ignored): $e');
    }
  }

  @override
  Future<domain.League> getLeagueDetail(String id) async {
    return await _api.getLeagueDetail(id);
  }

  @override
  Future<domain.League> createLeague(LeagueCreateRequest request) async {
    return await _api.createLeague(request);
  }

  @override
  Future<domain.League> updateLeagueStatus(String leagueId, String status) async {
    return await _api.updateLeagueStatus(leagueId, {'status': status});
  }

  @override
  Future<void> importPlayers(String leagueId, List<Map<String, dynamic>> players) async {
    await _api.importPlayers(leagueId, players);
  }

  @override
  Future<List<Franchise>> getFranchises(String leagueId) async {
    return await _api.getFranchises(leagueId);
  }

  @override
  Future<List<LeaguePlayer>> getLeaguePlayers(String leagueId, {int? page, int? size}) async {
    final paged = await _api.getLeaguePlayers(leagueId, page: page, size: size);
    return paged.content;
  }

  @override
  Future<LeaguePlayer> updatePlayerEligibility(String leagueId, String playerId, bool eligible) async {
    return await _api.updatePlayerEligibility(leagueId, playerId, {'eligible': eligible});
  }

  @override
  Future<void> removePlayer(String leagueId, String playerId) async {
    await _api.removePlayer(leagueId, playerId);
  }

  // Category / tag prices
  @override
  Future<List<CategoryPrice>> getCategoryPrices(String leagueId) =>
      _api.getCategoryPrices(leagueId);

  @override
  Future<CategoryPrice> updateCategoryPrice(String leagueId, String category, int price) =>
      _api.updateCategoryPrice(leagueId, {'category': category, 'price': price});

  @override
  Future<List<TagPrice>> getTagPrices(String leagueId) => _api.getTagPrices(leagueId);

  @override
  Future<TagPrice> updateTagPrice(String leagueId, String tag, int price) =>
      _api.updateTagPrice(leagueId, {'tag': tag, 'price': price});

  @override
  Future<dynamic> getLeagueAuctions(String leagueId) =>
      _api.getLeagueAuctions(leagueId);

  // Fees
  @override
  Future<List<FeeObligation>> getFeeObligations(String leagueId) async {
    final paged = await _api.getFeeObligations(leagueId);
    return paged.obligations.map((detail) => detail.obligation).toList();
  }

  @override
  Future<FeeObligation> createFeeObligation(String leagueId, Map<String, dynamic> body) =>
      _api.createFeeObligation(leagueId, body);

  @override
  Future<FeeObligationDetail> getFeeObligationForUser(String leagueId, String userId) =>
      _api.getFeeObligationForUser(leagueId, userId);

  @override
  Future<FeeSummary> getFeeSummary(String leagueId) => _api.getFeeSummary(leagueId);

  @override
  Future<FeeObligation> recordPayment(String leagueId, String obligationId, int amount, String paymentMode, String? notes) async {
    return await _api.recordPayment(leagueId, obligationId, {
      'amount': amount,
      'paymentMode': paymentMode,
      if (notes != null) 'notes': notes,
    });
  }

  @override
  Future<FeeObligation> waiveFee(String leagueId, String obligationId, String reason) async {
    return await _api.waiveFee(leagueId, obligationId, {'reason': reason});
  }

  // Forfeits
  @override
  Future<List<ForfeitRequest>> getForfeitRequests(String leagueId) async {
    final paged = await _api.getForfeitRequests(leagueId);
    return paged.requests;
  }

  @override
  Future<ForfeitRequest> submitForfeit(String leagueId, String type, String reason, {String? franchiseId}) async {
    return await _api.submitForfeit(leagueId, {
      'type': type,
      if (franchiseId != null) 'franchiseId': franchiseId,
      'reason': reason,
    });
  }

  @override
  Future<ForfeitRequest> approveForfeit(String leagueId, String requestId, String feeRefundDecision, {int? feeRefundAmount, String? adminNotes}) async {
    return await _api.approveForfeit(leagueId, requestId, {
      'feeRefundDecision': feeRefundDecision,
      if (feeRefundAmount != null) 'feeRefundAmount': feeRefundAmount,
      if (adminNotes != null) 'adminNotes': adminNotes,
    });
  }

  @override
  Future<ForfeitRequest> rejectForfeit(String leagueId, String requestId, String adminNotes) async {
    return await _api.rejectForfeit(leagueId, requestId, {'adminNotes': adminNotes});
  }

  @override
  Future<ForfeitRequest> cancelForfeit(String leagueId, String requestId) =>
      _api.cancelForfeit(leagueId, requestId);

  // Waitlist
  @override
  Future<List<WaitlistEntry>> getWaitlist(String leagueId) async {
    final paged = await _api.getWaitlist(leagueId);
    return paged.entries;
  }

  @override
  Future<WaitlistEntry> getMyWaitlistPosition(String leagueId) =>
      _api.getMyWaitlistPosition(leagueId);

  @override
  Future<WaitlistEntry> joinWaitlist(String leagueId, {String type = 'PLAYER', String? franchiseId}) async {
    return await _api.joinWaitlist(leagueId, {
      'type': type,
      if (franchiseId != null) 'franchiseId': franchiseId,
    });
  }

  @override
  Future<void> promoteFromWaitlist(String leagueId, String entryId) async {
    await _api.promoteFromWaitlist(leagueId, entryId);
  }

  @override
  Future<void> withdrawFromWaitlist(String leagueId, String entryId) async {
    await _api.withdrawFromWaitlist(leagueId, entryId);
  }
}
