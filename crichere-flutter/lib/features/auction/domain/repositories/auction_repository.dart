import '../entities/auction_summary.dart';

abstract class AuctionRepository {
  Future<AuctionSummary> getAuctionSummary(String auctionId);
  Future<void> putRandomPlayer(String auctionId);
  Future<void> putSpecificPlayer(String auctionId, String playerId);
  Future<void> recordBid(String auctionId, String franchiseId, int amount);
  Future<void> markSold(String auctionId, {required String leaguePlayerId, required String franchiseId, required int finalPrice});
  Future<void> markUnsold(String auctionId, {required String leaguePlayerId});
  Future<void> undoBid(String auctionId, {String reason});
  Future<void> undoSold(String auctionId, String leaguePlayerId, String reason);
  Future<void> forceAssign(String auctionId, String playerId, String franchiseId);
  Future<void> preAssign(String auctionId, String playerId, String franchiseId, String type);
  Future<void> startTimer(String auctionId, int seconds);
  Future<void> pauseTimer(String auctionId, int seconds);
  Future<void> resetTimer(String auctionId, int seconds);
}
