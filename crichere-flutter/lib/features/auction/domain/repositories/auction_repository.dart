import '../entities/auction_summary.dart';

abstract class AuctionRepository {
  Future<dynamic> getAuctionState(String auctionId);
  Future<AuctionSummary> getAuctionSummary(String auctionId);
  Future<List<dynamic>> getRounds(String auctionId);
  Future<void> addRound(String auctionId, Map<String, dynamic> config);
  Future<void> deleteRound(String auctionId, String roundId);
  Future<void> updateRoundPool(String auctionId, String roundId, List<String> playerIds);
  
  Future<void> putRandomPlayer(String auctionId);
  Future<void> putSpecificPlayer(String auctionId, String playerId);
  Future<void> recordBid(String auctionId, String franchiseId, int amount);
  Future<void> markSold(String auctionId, {required String leaguePlayerId, required String franchiseId, required int finalPrice});
  Future<void> markUnsold(String auctionId, {required String leaguePlayerId});
  Future<void> undoBid(String auctionId, {String reason});
  Future<void> undoSold(String auctionId, String leaguePlayerId, String reason);
  Future<void> forceAssign(String auctionId, String playerId, String franchiseId, int price);
  Future<void> preAssign(String auctionId, String playerId, String franchiseId, String type, int price);
  Future<void> startTimer(String auctionId, int seconds);
  Future<void> pauseTimer(String auctionId, int seconds);
  Future<void> resetTimer(String auctionId, int seconds);
}
