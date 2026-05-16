import '../domain/entities/auction_summary.dart';
import '../domain/repositories/auction_repository.dart';
import 'auction_api.dart';

class AuctionRepositoryImpl implements AuctionRepository {
  final AuctionApi _api;

  AuctionRepositoryImpl(this._api);

  @override
  Future<AuctionSummary> getAuctionSummary(String auctionId) async {
    return await _api.getAuctionSummary(auctionId);
  }

  // A1: no body = random player
  @override
  Future<void> putRandomPlayer(String auctionId) async {
    await _api.putRandomPlayer(auctionId);
  }

  // A2: specific player passed as leaguePlayerId in body
  @override
  Future<void> putSpecificPlayer(String auctionId, String playerId) async {
    await _api.putSpecificPlayer(auctionId, {'leaguePlayerId': playerId});
  }

  // A12: field name is bidAmount (not amount)
  @override
  Future<void> recordBid(String auctionId, String franchiseId, int amount) async {
    await _api.recordBid(auctionId, {
      'franchiseId': franchiseId,
      'bidAmount': amount,
    });
  }

  // A3: /player/sold requires leaguePlayerId, franchiseId, finalPrice
  @override
  Future<void> markSold(String auctionId, {required String leaguePlayerId, required String franchiseId, required int finalPrice}) async {
    await _api.markSold(auctionId, {
      'leaguePlayerId': leaguePlayerId,
      'franchiseId': franchiseId,
      'finalPrice': finalPrice,
    });
  }

  // A4: /player/unsold requires leaguePlayerId
  @override
  Future<void> markUnsold(String auctionId, {required String leaguePlayerId}) async {
    await _api.markUnsold(auctionId, {'leaguePlayerId': leaguePlayerId});
  }

  // A5: PATCH /bid/undo requires reason
  @override
  Future<void> undoBid(String auctionId, {String reason = ''}) async {
    await _api.undoBid(auctionId, {'reason': reason});
  }

  // A6: PATCH /player/undo-sold requires leaguePlayerId + reason
  @override
  Future<void> undoSold(String auctionId, String leaguePlayerId, String reason) async {
    await _api.undoSold(auctionId, {
      'leaguePlayerId': leaguePlayerId,
      'reason': reason,
    });
  }

  // A7: /player/force-assign, field leaguePlayerId (not playerId), add price
  @override
  Future<void> forceAssign(String auctionId, String playerId, String franchiseId) async {
    await _api.forceAssign(auctionId, {
      'leaguePlayerId': playerId,
      'franchiseId': franchiseId,
      'price': 0,
    });
  }

  // A8: /player/pre-assign, field assignmentType (not type), leaguePlayerId
  @override
  Future<void> preAssign(String auctionId, String playerId, String franchiseId, String type) async {
    await _api.preAssign(auctionId, {
      'leaguePlayerId': playerId,
      'franchiseId': franchiseId,
      'assignmentType': type,
      'price': 0,
    });
  }

  // A9: field durationSeconds (not remainingSeconds)
  @override
  Future<void> startTimer(String auctionId, int seconds) async {
    await _api.startTimer(auctionId, {'durationSeconds': seconds});
  }

  // A10: renamed pauseTimer → stopTimer, no body
  @override
  Future<void> pauseTimer(String auctionId, int seconds) async {
    await _api.stopTimer(auctionId);
  }

  // A11: resetTimer removed — no backend endpoint
  @override
  Future<void> resetTimer(String auctionId, int seconds) async {
    // No backend endpoint for reset; restart timer with new duration instead
    await _api.startTimer(auctionId, {'durationSeconds': seconds});
  }
}
