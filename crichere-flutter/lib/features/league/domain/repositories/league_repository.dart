import '../entities/league.dart';
import '../entities/league_player.dart';
import '../../../franchise/domain/entities/franchise.dart';
import '../../data/models/league_request.dart';
import '../../../financials/domain/entities/fee_entities.dart';
import '../../../financials/domain/entities/forfeit_entities.dart';
import '../entities/waitlist_entities.dart';
import '../entities/league_prices.dart';

abstract class LeagueRepository {
  Future<List<League>> getLeagues({bool forceRefresh = false, int? page, int? size});
  Future<League> getLeagueDetail(String id);
  Future<League> createLeague(LeagueCreateRequest request);
  Future<League> updateLeagueStatus(String leagueId, String status);
  Future<void> importPlayers(String leagueId, List<Map<String, dynamic>> players);
  Future<List<Franchise>> getFranchises(String leagueId);
  Future<List<LeaguePlayer>> getLeaguePlayers(String leagueId, {int? page, int? size});
  Future<LeaguePlayer> updatePlayerEligibility(String leagueId, String playerId, bool eligible);
  Future<void> removePlayer(String leagueId, String playerId);

  // Category / tag prices
  Future<List<CategoryPrice>> getCategoryPrices(String leagueId);
  Future<CategoryPrice> updateCategoryPrice(String leagueId, String category, int price);
  Future<List<TagPrice>> getTagPrices(String leagueId);
  Future<TagPrice> updateTagPrice(String leagueId, String tag, int price);
  Future<dynamic> getLeagueAuctions(String leagueId);

  // Fees
  Future<List<FeeObligation>> getFeeObligations(String leagueId);
  Future<FeeObligation> createFeeObligation(String leagueId, Map<String, dynamic> body);
  Future<FeeObligationDetail> getFeeObligationForUser(String leagueId, String userId);
  Future<FeeSummary> getFeeSummary(String leagueId);
  Future<FeeObligation> recordPayment(String leagueId, String obligationId, int amount, String paymentMode, String? notes);
  Future<FeeObligation> waiveFee(String leagueId, String obligationId, String reason);

  // Forfeits
  Future<List<ForfeitRequest>> getForfeitRequests(String leagueId);
  Future<ForfeitRequest> submitForfeit(String leagueId, String type, String reason, {String? franchiseId});
  Future<ForfeitRequest> approveForfeit(String leagueId, String requestId, String feeRefundDecision, {int? feeRefundAmount, String? adminNotes});
  Future<ForfeitRequest> rejectForfeit(String leagueId, String requestId, String adminNotes);
  Future<ForfeitRequest> cancelForfeit(String leagueId, String requestId);

  // Waitlist
  Future<List<WaitlistEntry>> getWaitlist(String leagueId);
  Future<WaitlistEntry> getMyWaitlistPosition(String leagueId);
  Future<WaitlistEntry> joinWaitlist(String leagueId, {String type, String? franchiseId});
  Future<void> promoteFromWaitlist(String leagueId, String entryId);
  Future<void> withdrawFromWaitlist(String leagueId, String entryId);
}
