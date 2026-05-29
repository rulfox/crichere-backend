import '../entities/auction_summary.dart';
import '../entities/auction_state_snapshot.dart';
import '../entities/auction_models.dart';

abstract class AuctionRepository {
  // ---- Create / read ----
  Future<AuctionResponse> createAuction(String leagueId, String auctioneerId, List<Map<String, dynamic>> rounds);
  Future<AuctionResponse> getAuction(String auctionId);
  Future<AuctionStateSnapshot> getAuctionState(String auctionId);

  // ---- Lifecycle ----
  Future<AuctionResponse> startAuction(String auctionId);
  Future<AuctionResponse> pauseAuction(String auctionId, {String? reason});
  Future<AuctionResponse> resumeAuction(String auctionId);
  Future<AuctionResponse> completeAuction(String auctionId);
  Future<AuctionResponse> cancelAuction(String auctionId, {String? reason});

  // ---- Rounds ----
  Future<List<RoundConfig>> getRounds(String auctionId);
  Future<RoundConfig> getRound(String auctionId, String roundId);
  Future<RoundConfig> addRound(String auctionId, Map<String, dynamic> config);
  Future<RoundConfig> updateRound(String auctionId, String roundId, Map<String, dynamic> config);
  Future<void> deleteRound(String auctionId, String roundId);
  Future<void> startRound(String auctionId, String roundId);
  Future<void> completeRound(String auctionId, String roundId);
  Future<dynamic> getPlayerPool(String auctionId, String roundId);
  Future<void> updateRoundPool(String auctionId, String roundId, List<String> playerIds);
  Future<List<CategoryIncrement>> getCategoryIncrements(String auctionId, String roundId);
  Future<CategoryIncrement> updateCategoryIncrements(String auctionId, String roundId, Map<String, dynamic> body);

  // ---- Player operations (facade names kept stable for call sites) ----
  Future<void> putRandomPlayer(String auctionId);
  Future<void> putSpecificPlayer(String auctionId, String playerId);
  Future<BidResponse> recordBid(String auctionId, String franchiseId, int amount);
  Future<void> markSold(String auctionId, {required String leaguePlayerId, required String franchiseId, required int finalPrice});
  Future<void> markUnsold(String auctionId, {required String leaguePlayerId});
  Future<void> undoBid(String auctionId, {String reason});
  Future<void> undoSold(String auctionId, String leaguePlayerId, String reason);
  Future<void> forceAssign(String auctionId, String playerId, String franchiseId, int price);
  Future<void> preAssign(String auctionId, String playerId, String franchiseId, String type, int price);
  Future<void> withdrawPlayer(String auctionId, String leaguePlayerId, String reason);

  // ---- Timer ----
  Future<void> startTimer(String auctionId, int seconds);
  Future<void> stopTimer(String auctionId);
  Future<void> pauseTimer(String auctionId, int seconds);
  Future<void> resetTimer(String auctionId, int seconds);
  Future<void> extendTimer(String auctionId, int additionalSeconds);
  Future<TimerState> getTimerState(String auctionId);

  // ---- Summaries / reads ----
  Future<AuctionSummary> getAuctionSummary(String auctionId);
  Future<FranchiseDetailedSummary> getFranchiseDetailedSummary(String auctionId, String franchiseId);
  Future<UnsoldPlayersResponse> getUnsoldPlayers(String auctionId, {int? page, int? size});
  Future<List<BidResponse>> getBidHistory(String auctionId, String leaguePlayerId);
  Future<List<AuditLogResponse>> getAuditLog(String auctionId, {int? fromSequence});

  // ---- Exports ----
  Future<List<int>> exportSummaryPdf(String auctionId);
  Future<List<int>> exportFranchisePdf(String auctionId, String franchiseId);
  Future<List<int>> exportFranchiseImage(String auctionId, String franchiseId);

  // ---- Admin ----
  Future<void> deleteAuction(String auctionId);
  Future<AuctionResponse> regenerateViewToken(String auctionId);
}
