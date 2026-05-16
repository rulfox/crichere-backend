import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../domain/entities/league.dart';
import '../domain/entities/league_player.dart';
import '../../franchise/domain/entities/franchise.dart';
import '../../financials/domain/entities/fee_entities.dart';
import '../../financials/domain/entities/forfeit_entities.dart';
import '../domain/entities/waitlist_entities.dart';
import 'models/league_request.dart';

part 'league_api.g.dart';

@RestApi()
abstract class LeagueApi {
  factory LeagueApi(Dio dio, {String baseUrl}) = _LeagueApi;

  @GET('/leagues')
  Future<List<League>> getLeagues();

  @GET('/leagues/{id}')
  Future<League> getLeagueDetail(@Path('id') String id);

  @POST('/leagues')
  Future<League> createLeague(@Body() LeagueCreateRequest request);

  @PATCH('/leagues/{id}/status')
  Future<League> updateLeagueStatus(
    @Path('id') String leagueId,
    @Body() Map<String, dynamic> body,
  );

  // B3: was /import (MultiPart) → /bulk-import (JSON list of PlayerImportRequest)
  @POST('/leagues/{id}/players/bulk-import')
  Future<void> importPlayers(
    @Path('id') String leagueId,
    @Body() dynamic players,
  );

  // B2: No /leagues/{id}/franchises endpoint in backend.
  // Franchises are fetched individually via /franchises/{id}.
  // This endpoint is intentionally removed — callers should use auction state.
  // Kept as placeholder returning empty list via repository override.

  // B1: was /leagues/{id}/players → /players/league/{leagueId}
  @GET('/players/league/{leagueId}')
  Future<List<LeaguePlayer>> getLeaguePlayers(@Path('leagueId') String leagueId);

  // Fees — B5: returns paginated FeeObligationListResponse, not flat list
  @GET('/leagues/{id}/fee-obligations')
  Future<FeeObligationListResponse> getFeeObligations(@Path('id') String leagueId);

  @POST('/leagues/{id}/fee-obligations/{obligationId}/payments')
  Future<FeePayment> recordPayment(
    @Path('id') String leagueId,
    @Path('obligationId') String obligationId,
    @Body() Map<String, dynamic> body,
  );

  @PATCH('/leagues/{id}/fee-obligations/{obligationId}/waive')
  Future<void> waiveFee(
    @Path('id') String leagueId,
    @Path('obligationId') String obligationId,
    @Body() Map<String, dynamic> body,
  );

  // Forfeits — B7: returns paginated ForfeitRequestListResponse
  @GET('/leagues/{id}/forfeit-requests')
  Future<ForfeitRequestListResponse> getForfeitRequests(@Path('id') String leagueId);

  @POST('/leagues/{id}/forfeit')
  Future<ForfeitRequest> submitForfeit(
    @Path('id') String leagueId,
    @Body() Map<String, dynamic> body,
  );

  @PATCH('/leagues/{id}/forfeit-requests/{requestId}/approve')
  Future<void> approveForfeit(
    @Path('id') String leagueId,
    @Path('requestId') String requestId,
    @Body() Map<String, dynamic> body,
  );

  // Waitlist — GET returns paginated wrapper, POST requires type body
  @GET('/leagues/{id}/waiting-list')
  Future<WaitlistPagedResponse> getWaitlist(@Path('id') String leagueId);

  @POST('/leagues/{id}/waiting-list')
  Future<WaitlistEntry> joinWaitlist(
    @Path('id') String leagueId,
    @Body() Map<String, dynamic> body,
  );

  @PATCH('/leagues/{id}/waiting-list/{entryId}/promote')
  Future<void> promoteFromWaitlist(
    @Path('id') String leagueId,
    @Path('entryId') String entryId,
  );

  @DELETE('/leagues/{id}/waiting-list/{entryId}')
  Future<void> withdrawFromWaitlist(
    @Path('id') String leagueId,
    @Path('entryId') String entryId,
  );
}

