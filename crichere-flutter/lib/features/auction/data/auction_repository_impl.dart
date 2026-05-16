import '../domain/entities/auction_summary.dart';
import '../domain/repositories/auction_repository.dart';
import 'auction_api.dart';

class AuctionRepositoryImpl implements AuctionRepository {
  final AuctionApi _api;

  AuctionRepositoryImpl(this._api);

  @override
  Future<dynamic> getAuctionState(String auctionId) async {
    return await _api.getAuctionState(auctionId);
  }

  @override
  Future<AuctionSummary> getAuctionSummary(String auctionId) async {
    return await _api.getAuctionSummary(auctionId);
  }

  @override
  Future<List<dynamic>> getRounds(String auctionId) async {
    return await _api.getRounds(auctionId);
  }

  @override
  Future<void> addRound(String auctionId, Map<String, dynamic> config) async {
    await _api.addRound(auctionId, config);
  }

  @override
  Future<void> deleteRound(String auctionId, String roundId) async {
    await _api.deleteRound(auctionId, roundId);
  }

  @override
  Future<void> updateRoundPool(String auctionId, String roundId, List<String> playerIds) async {
    await _api.updateRoundPool(auctionId, roundId, {'playerIds': playerIds});
  }

  @override
  Future<void> putRandomPlayer(String auctionId) async {
    await _api.putRandomPlayer(auctionId);
  }

  @override
  Future<void> putSpecificPlayer(String auctionId, String playerId) async {
    await _api.putSpecificPlayer(auctionId, {'leaguePlayerId': playerId});
  }

  @override
  Future<void> recordBid(String auctionId, String franchiseId, int amount) async {
    await _api.recordBid(auctionId, {
      'franchiseId': franchiseId,
      'bidAmount': amount,
    });
  }

  @override
  Future<void> markSold(String auctionId, {required String leaguePlayerId, required String franchiseId, required int finalPrice}) async {
    await _api.markSold(auctionId, {
      'leaguePlayerId': leaguePlayerId,
      'franchiseId': franchiseId,
      'finalPrice': finalPrice,
    });
  }

  @override
  Future<void> markUnsold(String auctionId, {required String leaguePlayerId}) async {
    await _api.markUnsold(auctionId, {'leaguePlayerId': leaguePlayerId});
  }

  @override
  Future<void> undoBid(String auctionId, {String reason = ''}) async {
    await _api.undoBid(auctionId, {'reason': reason});
  }

  @override
  Future<void> undoSold(String auctionId, String leaguePlayerId, String reason) async {
    await _api.undoSold(auctionId, {
      'leaguePlayerId': leaguePlayerId,
      'reason': reason,
    });
  }

  @override
  Future<void> forceAssign(String auctionId, String playerId, String franchiseId, int price) async {
    await _api.forceAssign(auctionId, {
      'leaguePlayerId': playerId,
      'franchiseId': franchiseId,
      'price': price,
    });
  }

  @override
  Future<void> preAssign(String auctionId, String playerId, String franchiseId, String type, int price) async {
    await _api.preAssign(auctionId, {
      'leaguePlayerId': playerId,
      'franchiseId': franchiseId,
      'assignmentType': type,
      'price': price,
    });
  }

  @override
  Future<void> startTimer(String auctionId, int seconds) async {
    await _api.startTimer(auctionId, {'durationSeconds': seconds});
  }

  @override
  Future<void> pauseTimer(String auctionId, int seconds) async {
    await _api.stopTimer(auctionId);
  }

  @override
  Future<void> resetTimer(String auctionId, int seconds) async {
    await _api.startTimer(auctionId, {'durationSeconds': seconds});
  }
}
