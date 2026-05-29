import '../domain/entities/auction_summary.dart';
import '../domain/entities/auction_state_snapshot.dart';
import '../domain/entities/auction_models.dart';
import '../domain/repositories/auction_repository.dart';
import 'auction_api.dart';

class AuctionRepositoryImpl implements AuctionRepository {
  final AuctionApi _api;

  AuctionRepositoryImpl(this._api);

  // ---- Create / read ----

  @override
  Future<AuctionResponse> createAuction(
      String leagueId, String auctioneerId, List<Map<String, dynamic>> rounds) {
    return _api.createAuction(leagueId, {
      'auctioneerId': auctioneerId,
      'rounds': rounds,
    });
  }

  @override
  Future<AuctionResponse> getAuction(String auctionId) =>
      _api.getAuction(auctionId);

  @override
  Future<AuctionStateSnapshot> getAuctionState(String auctionId) =>
      _api.getAuctionState(auctionId);

  // ---- Lifecycle ----

  @override
  Future<AuctionResponse> startAuction(String auctionId) =>
      _api.startAuction(auctionId);

  @override
  Future<AuctionResponse> pauseAuction(String auctionId, {String? reason}) =>
      _api.pauseAuction(auctionId, {if (reason != null) 'reason': reason});

  @override
  Future<AuctionResponse> resumeAuction(String auctionId) =>
      _api.resumeAuction(auctionId);

  @override
  Future<AuctionResponse> completeAuction(String auctionId) =>
      _api.completeAuction(auctionId);

  @override
  Future<AuctionResponse> cancelAuction(String auctionId, {String? reason}) =>
      _api.cancelAuction(auctionId, {if (reason != null) 'reason': reason});

  // ---- Rounds ----

  @override
  Future<List<RoundConfig>> getRounds(String auctionId) =>
      _api.getRounds(auctionId);

  @override
  Future<RoundConfig> getRound(String auctionId, String roundId) =>
      _api.getRound(auctionId, roundId);

  @override
  Future<RoundConfig> addRound(String auctionId, Map<String, dynamic> config) =>
      _api.addRound(auctionId, config);

  @override
  Future<RoundConfig> updateRound(
          String auctionId, String roundId, Map<String, dynamic> config) =>
      _api.updateRound(auctionId, roundId, config);

  @override
  Future<void> deleteRound(String auctionId, String roundId) =>
      _api.deleteRound(auctionId, roundId);

  @override
  Future<void> startRound(String auctionId, String roundId) =>
      _api.startRound(auctionId, roundId);

  @override
  Future<void> completeRound(String auctionId, String roundId) =>
      _api.completeRound(auctionId, roundId);

  @override
  Future<dynamic> getPlayerPool(String auctionId, String roundId) =>
      _api.getPlayerPool(auctionId, roundId);

  @override
  Future<void> updateRoundPool(
          String auctionId, String roundId, List<String> playerIds) =>
      _api.updatePlayerPool(auctionId, roundId, {'playerIds': playerIds});

  @override
  Future<List<CategoryIncrement>> getCategoryIncrements(
          String auctionId, String roundId) =>
      _api.getCategoryIncrements(auctionId, roundId);

  @override
  Future<CategoryIncrement> updateCategoryIncrements(
          String auctionId, String roundId, Map<String, dynamic> body) =>
      _api.updateCategoryIncrements(auctionId, roundId, body);

  // ---- Player operations ----

  @override
  Future<void> putRandomPlayer(String auctionId) =>
      _api.putPlayer(auctionId, {});

  @override
  Future<void> putSpecificPlayer(String auctionId, String playerId) =>
      _api.putPlayer(auctionId, {'leaguePlayerId': playerId});

  @override
  Future<BidResponse> recordBid(String auctionId, String franchiseId, int amount) =>
      _api.placeBid(auctionId, {
        'franchiseId': franchiseId,
        'bidAmount': amount,
      });

  @override
  Future<void> markSold(String auctionId,
          {required String leaguePlayerId,
          required String franchiseId,
          required int finalPrice}) =>
      _api.sellPlayer(auctionId, {
        'leaguePlayerId': leaguePlayerId,
        'franchiseId': franchiseId,
        'finalPrice': finalPrice,
      });

  @override
  Future<void> markUnsold(String auctionId, {required String leaguePlayerId}) =>
      _api.unsoldPlayer(auctionId, {'leaguePlayerId': leaguePlayerId});

  @override
  Future<void> undoBid(String auctionId, {String reason = ''}) =>
      _api.undoBid(auctionId, {'reason': reason});

  @override
  Future<void> undoSold(String auctionId, String leaguePlayerId, String reason) =>
      _api.undoSold(auctionId, {
        'leaguePlayerId': leaguePlayerId,
        'reason': reason,
      });

  @override
  Future<void> forceAssign(
          String auctionId, String playerId, String franchiseId, int price) =>
      _api.forceAssign(auctionId, {
        'leaguePlayerId': playerId,
        'franchiseId': franchiseId,
        'price': price,
      });

  @override
  Future<void> preAssign(String auctionId, String playerId, String franchiseId,
          String type, int price) =>
      _api.preAssign(auctionId, {
        'leaguePlayerId': playerId,
        'franchiseId': franchiseId,
        'assignmentType': type,
        'price': price,
      });

  @override
  Future<void> withdrawPlayer(
          String auctionId, String leaguePlayerId, String reason) =>
      _api.withdrawPlayer(auctionId, {
        'leaguePlayerId': leaguePlayerId,
        'reason': reason,
      });

  // ---- Timer ----

  @override
  Future<void> startTimer(String auctionId, int seconds) =>
      _api.startTimer(auctionId, {'durationSeconds': seconds});

  @override
  Future<void> stopTimer(String auctionId) => _api.stopTimer(auctionId);

  @override
  Future<void> pauseTimer(String auctionId, int seconds) =>
      _api.stopTimer(auctionId);

  @override
  Future<void> resetTimer(String auctionId, int seconds) =>
      _api.startTimer(auctionId, {'durationSeconds': seconds});

  @override
  Future<void> extendTimer(String auctionId, int additionalSeconds) =>
      _api.extendTimer(auctionId, {'additionalSeconds': additionalSeconds});

  @override
  Future<TimerState> getTimerState(String auctionId) =>
      _api.getTimerState(auctionId);

  // ---- Summaries / reads ----

  @override
  Future<AuctionSummary> getAuctionSummary(String auctionId) =>
      _api.getAuctionSummary(auctionId);

  @override
  Future<FranchiseDetailedSummary> getFranchiseDetailedSummary(
          String auctionId, String franchiseId) =>
      _api.getFranchiseDetailedSummary(auctionId, franchiseId);

  @override
  Future<UnsoldPlayersResponse> getUnsoldPlayers(String auctionId,
          {int? page, int? size}) =>
      _api.getUnsoldPlayers(auctionId, page: page, size: size);

  @override
  Future<List<BidResponse>> getBidHistory(
          String auctionId, String leaguePlayerId) =>
      _api.getBidHistory(auctionId, leaguePlayerId);

  @override
  Future<List<AuditLogResponse>> getAuditLog(String auctionId,
          {int? fromSequence}) =>
      _api.getAuditLog(auctionId, fromSequence: fromSequence);

  // ---- Exports ----

  @override
  Future<List<int>> exportSummaryPdf(String auctionId) =>
      _api.exportSummaryPdf(auctionId);

  @override
  Future<List<int>> exportFranchisePdf(String auctionId, String franchiseId) =>
      _api.exportFranchisePdf(auctionId, franchiseId);

  @override
  Future<List<int>> exportFranchiseImage(String auctionId, String franchiseId) =>
      _api.exportFranchiseImage(auctionId, franchiseId);

  // ---- Admin ----

  @override
  Future<void> deleteAuction(String auctionId) =>
      _api.deleteAuction(auctionId);

  @override
  Future<AuctionResponse> regenerateViewToken(String auctionId) =>
      _api.regenerateViewToken(auctionId);
}
