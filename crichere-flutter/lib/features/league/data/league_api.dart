import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/network/page_response.dart';
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
  Future<PageResponse<League>> getLeagues({
    @Query('page') int? page,
    @Query('size') int? size,
  });

  @GET('/leagues/{id}')
  Future<League> getLeagueDetail(@Path('id') String id);

  @POST('/leagues')
  Future<League> createLeague(@Body() LeagueCreateRequest request);

  @PATCH('/leagues/{id}/status')
  Future<League> updateLeagueStatus(
    @Path('id') String leagueId,
    @Body() Map<String, dynamic> body,
  );

  @POST('/leagues/{id}/players/bulk-import')
  Future<void> importPlayers(
    @Path('id') String leagueId,
    @Body() dynamic players,
  );

  @GET('/leagues/{id}/franchises')
  Future<List<Franchise>> getFranchises(@Path('id') String leagueId);

  @GET('/leagues/{id}/players')
  Future<PageResponse<LeaguePlayer>> getLeaguePlayers(
    @Path('id') String leagueId, {
    @Query('page') int? page,
    @Query('size') int? size,
  });

  @PATCH('/leagues/{id}/players/{playerId}/eligible')
  Future<LeaguePlayer> updatePlayerEligibility(
    @Path('id') String leagueId,
    @Path('playerId') String playerId,
    @Body() Map<String, bool> body,
  );

  @DELETE('/leagues/{id}/players/{playerId}')
  Future<void> removePlayer(
    @Path('id') String leagueId,
    @Path('playerId') String playerId,
  );

  // Fees
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

  // Forfeits
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

  // Waitlist
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
