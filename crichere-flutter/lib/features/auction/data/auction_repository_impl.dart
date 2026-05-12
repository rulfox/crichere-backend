import '../domain/repositories/auction_repository.dart';
import 'auction_api.dart';

class AuctionRepositoryImpl implements AuctionRepository {
  final AuctionApi _api;

  AuctionRepositoryImpl(this._api);

  @override
  Future<void> putRandomPlayer(String auctionId) async {
    await _api.putRandomPlayer(auctionId);
  }

  @override
  Future<void> putSpecificPlayer(String auctionId, String playerId) async {
    await _api.putSpecificPlayer(auctionId, playerId);
  }

  @override
  Future<void> recordBid(String auctionId, String franchiseId, int amount) async {
    await _api.recordBid(auctionId, {
      'franchiseId': franchiseId,
      'amount': amount,
    });
  }

  @override
  Future<void> markSold(String auctionId) async {
    await _api.markSold(auctionId);
  }

  @override
  Future<void> markUnsold(String auctionId) async {
    await _api.markUnsold(auctionId);
  }

  @override
  Future<void> undoBid(String auctionId) async {
    await _api.undoBid(auctionId);
  }

  @override
  Future<void> undoSold(String auctionId, String reason) async {
    await _api.undoSold(auctionId, {'reason': reason});
  }

  @override
  Future<void> forceAssign(String auctionId, String playerId, String franchiseId) async {
    await _api.forceAssign(auctionId, {
      'playerId': playerId,
      'franchiseId': franchiseId,
    });
  }

  @override
  Future<void> preAssign(String auctionId, String playerId, String franchiseId, String type) async {
    await _api.preAssign(auctionId, {
      'playerId': playerId,
      'franchiseId': franchiseId,
      'type': type,
    });
  }
}
