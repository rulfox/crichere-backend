import '../entities/league.dart';
import '../entities/league_player.dart';
import '../../../franchise/domain/entities/franchise.dart';
import '../../data/models/league_request.dart';
import '../../../financials/domain/entities/fee_entities.dart';
import '../../../financials/domain/entities/forfeit_entities.dart';
import '../entities/waitlist_entities.dart';

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

  // Fees
  Future<List<FeeObligation>> getFeeObligations(String leagueId);
  Future<FeePayment> recordPayment(String leagueId, String obligationId, int amount, String paymentMode, String? notes);
  Future<void> waiveFee(String leagueId, String obligationId, int refundAmount, String? notes);

  // Forfeits
  Future<List<ForfeitRequest>> getForfeitRequests(String leagueId);
  Future<ForfeitRequest> submitForfeit(String leagueId, String entityId, String type, String reason);
  Future<void> approveForfeit(String leagueId, String requestId, int refundAmount, bool promoteNext);

  // Waitlist
  Future<List<WaitlistEntry>> getWaitlist(String leagueId);
  Future<WaitlistEntry> joinWaitlist(String leagueId);
  Future<void> promoteFromWaitlist(String leagueId, String entryId);
  Future<void> withdrawFromWaitlist(String leagueId, String entryId);
}
