abstract class AuctionRepository {
  Future<void> putRandomPlayer(String auctionId);
  Future<void> putSpecificPlayer(String auctionId, String playerId);
  Future<void> recordBid(String auctionId, String franchiseId, int amount);
  Future<void> markSold(String auctionId);
  Future<void> markUnsold(String auctionId);
  Future<void> undoBid(String auctionId);
  Future<void> undoSold(String auctionId, String reason);
}
