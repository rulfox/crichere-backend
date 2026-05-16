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
import 'package:drift/drift.dart';

class LeagueRepositoryImpl implements LeagueRepository {
  final LeagueApi _api;
  final AppDatabase _db;

  LeagueRepositoryImpl(this._api, this._db);

  @override
  Future<List<domain.League>> getLeagues({bool forceRefresh = false, int? page, int? size}) async {
    if (!forceRefresh && page == null) {
      final cached = await (_db.select(_db.leagues)).get();
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
    }

    final paged = await _api.getLeagues(page: page, size: size);
    final remote = paged.content;
    
    if (page == null || page == 0) {
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
      });
    }

    return remote;
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

  // Fees
  @override
  Future<List<FeeObligation>> getFeeObligations(String leagueId) async {
    final paged = await _api.getFeeObligations(leagueId);
    return paged.obligations.map((detail) => detail.obligation).toList();
  }

  @override
  Future<FeePayment> recordPayment(String leagueId, String obligationId, int amount, String paymentMode, String? notes) async {
    return await _api.recordPayment(leagueId, obligationId, {
      'amount': amount,
      'paymentMode': paymentMode,
      'notes': notes,
    });
  }

  @override
  Future<void> waiveFee(String leagueId, String obligationId, int refundAmount, String? notes) async {
    await _api.waiveFee(leagueId, obligationId, {
      'refundAmount': refundAmount,
      'notes': notes,
    });
  }

  // Forfeits
  @override
  Future<List<ForfeitRequest>> getForfeitRequests(String leagueId) async {
    final paged = await _api.getForfeitRequests(leagueId);
    return paged.requests;
  }

  @override
  Future<ForfeitRequest> submitForfeit(String leagueId, String entityId, String type, String reason) async {
    return await _api.submitForfeit(leagueId, {
      'entityId': entityId,
      'type': type,
      'reason': reason,
    });
  }

  @override
  Future<void> approveForfeit(String leagueId, String requestId, int refundAmount, bool promoteNext) async {
    await _api.approveForfeit(leagueId, requestId, {
      'refundAmount': refundAmount,
      'promoteNext': promoteNext,
    });
  }

  // Waitlist
  @override
  Future<List<WaitlistEntry>> getWaitlist(String leagueId) async {
    final paged = await _api.getWaitlist(leagueId);
    return paged.entries;
  }

  @override
  Future<WaitlistEntry> joinWaitlist(String leagueId) async {
    return await _api.joinWaitlist(leagueId, {'type': 'PLAYER'});
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
