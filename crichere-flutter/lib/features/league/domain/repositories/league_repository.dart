import '../entities/league.dart';
import '../entities/league_player.dart';
import '../../../franchise/domain/entities/franchise.dart';
import '../../data/models/league_request.dart';
import '../../../financials/domain/entities/fee_entities.dart';
import '../../../financials/domain/entities/forfeit_entities.dart';
import '../entities/waitlist_entities.dart';

abstract class LeagueRepository {
  Future<List<League>> getLeagues({bool forceRefresh = false});
  Future<League> getLeagueDetail(String id);
  Future<League> createLeague(LeagueCreateRequest request);
  // B3: Changed from File to list of player maps
  Future<void> importPlayers(String leagueId, List<Map<String, dynamic>> players);
  Future<List<Franchise>> getFranchises(String leagueId);
  Future<List<LeaguePlayer>> getLeaguePlayers(String leagueId);

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
