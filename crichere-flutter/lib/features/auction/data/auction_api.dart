import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../domain/entities/auction_summary.dart';
import '../domain/entities/auction_state_snapshot.dart';
import '../domain/entities/auction_models.dart';

part 'auction_api.g.dart';

/// Full client for the backend `AuctionController` surface.
///
/// Request bodies are sent as `Map<String, dynamic>` (Dio serializes them
/// directly); responses are typed. The shared Dio interceptor unwraps the
/// `ApiResponse` envelope, so each call deserializes the inner payload.
@RestApi()
abstract class AuctionApi {
  factory AuctionApi(Dio dio, {String baseUrl}) = _AuctionApi;

  // ---- Create / read ----

  @POST('/auctions/leagues/{leagueId}')
  Future<AuctionResponse> createAuction(
    @Path('leagueId') String leagueId,
    @Body() Map<String, dynamic> body,
  );

  @GET('/auctions/{id}')
  Future<AuctionResponse> getAuction(@Path('id') String auctionId);

  @GET('/auctions/{id}/state')
  Future<AuctionStateSnapshot> getAuctionState(@Path('id') String auctionId);

  // ---- Lifecycle ----

  @PATCH('/auctions/{id}/start')
  Future<AuctionResponse> startAuction(@Path('id') String auctionId);

  @PATCH('/auctions/{id}/pause')
  Future<AuctionResponse> pauseAuction(
    @Path('id') String auctionId,
    @Body() Map<String, dynamic> body,
  );

  @PATCH('/auctions/{id}/resume')
  Future<AuctionResponse> resumeAuction(@Path('id') String auctionId);

  @PATCH('/auctions/{id}/complete')
  Future<AuctionResponse> completeAuction(@Path('id') String auctionId);

  @PATCH('/auctions/{id}/cancel')
  Future<AuctionResponse> cancelAuction(
    @Path('id') String auctionId,
    @Body() Map<String, dynamic> body,
  );

  // ---- Timer ----

  @POST('/auctions/{id}/timer/start')
  Future<void> startTimer(
    @Path('id') String auctionId,
    @Body() Map<String, dynamic> body,
  );

  @POST('/auctions/{id}/timer/stop')
  Future<void> stopTimer(@Path('id') String auctionId);

  @GET('/auctions/{id}/timer/state')
  Future<TimerState> getTimerState(@Path('id') String auctionId);

  @PATCH('/auctions/{id}/timer/extend')
  Future<void> extendTimer(
    @Path('id') String auctionId,
    @Body() Map<String, dynamic> body,
  );

  // ---- Rounds ----

  @POST('/auctions/{id}/rounds')
  Future<RoundConfig> addRound(
    @Path('id') String auctionId,
    @Body() Map<String, dynamic> body,
  );

  @GET('/auctions/{id}/rounds')
  Future<List<RoundConfig>> getRounds(@Path('id') String auctionId);

  @GET('/auctions/{id}/rounds/{roundId}')
  Future<RoundConfig> getRound(
    @Path('id') String auctionId,
    @Path('roundId') String roundId,
  );

  @PUT('/auctions/{id}/rounds/{roundId}')
  Future<RoundConfig> updateRound(
    @Path('id') String auctionId,
    @Path('roundId') String roundId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/auctions/{id}/rounds/{roundId}')
  Future<void> deleteRound(
    @Path('id') String auctionId,
    @Path('roundId') String roundId,
  );

  @PATCH('/auctions/{id}/rounds/{roundId}/start')
  Future<void> startRound(
    @Path('id') String auctionId,
    @Path('roundId') String roundId,
  );

  @PATCH('/auctions/{id}/rounds/{roundId}/complete')
  Future<void> completeRound(
    @Path('id') String auctionId,
    @Path('roundId') String roundId,
  );

  @GET('/auctions/{id}/rounds/{roundId}/player-pool')
  Future<dynamic> getPlayerPool(
    @Path('id') String auctionId,
    @Path('roundId') String roundId,
  );

  /// FIX: backend path is `/player-pool` (was `/pool`).
  @PATCH('/auctions/{id}/rounds/{roundId}/player-pool')
  Future<void> updatePlayerPool(
    @Path('id') String auctionId,
    @Path('roundId') String roundId,
    @Body() Map<String, dynamic> body,
  );

  @GET('/auctions/{id}/rounds/{roundId}/category-increments')
  Future<List<CategoryIncrement>> getCategoryIncrements(
    @Path('id') String auctionId,
    @Path('roundId') String roundId,
  );

  @POST('/auctions/{id}/rounds/{roundId}/category-increments')
  Future<CategoryIncrement> updateCategoryIncrements(
    @Path('id') String auctionId,
    @Path('roundId') String roundId,
    @Body() Map<String, dynamic> body,
  );

  // ---- Player operations ----

  @POST('/auctions/{id}/player/put')
  Future<void> putPlayer(
    @Path('id') String auctionId,
    @Body() Map<String, dynamic> body,
  );

  @POST('/auctions/{id}/bid')
  Future<BidResponse> placeBid(
    @Path('id') String auctionId,
    @Body() Map<String, dynamic> body,
  );

  @PATCH('/auctions/{id}/bid/undo')
  Future<void> undoBid(
    @Path('id') String auctionId,
    @Body() Map<String, dynamic> body,
  );

  @POST('/auctions/{id}/player/sold')
  Future<void> sellPlayer(
    @Path('id') String auctionId,
    @Body() Map<String, dynamic> body,
  );

  @PATCH('/auctions/{id}/player/undo-sold')
  Future<void> undoSold(
    @Path('id') String auctionId,
    @Body() Map<String, dynamic> body,
  );

  @POST('/auctions/{id}/player/unsold')
  Future<void> unsoldPlayer(
    @Path('id') String auctionId,
    @Body() Map<String, dynamic> body,
  );

  @POST('/auctions/{id}/player/pre-assign')
  Future<void> preAssign(
    @Path('id') String auctionId,
    @Body() Map<String, dynamic> body,
  );

  @POST('/auctions/{id}/player/force-assign')
  Future<void> forceAssign(
    @Path('id') String auctionId,
    @Body() Map<String, dynamic> body,
  );

  @POST('/auctions/{id}/player/withdraw')
  Future<void> withdrawPlayer(
    @Path('id') String auctionId,
    @Body() Map<String, dynamic> body,
  );

  // ---- Reads ----

  @GET('/auctions/{id}/bids/{leaguePlayerId}')
  Future<List<BidResponse>> getBidHistory(
    @Path('id') String auctionId,
    @Path('leaguePlayerId') String leaguePlayerId,
  );

  @GET('/auctions/{id}/audit-log')
  Future<List<AuditLogResponse>> getAuditLog(
    @Path('id') String auctionId, {
    @Query('fromSequence') int? fromSequence,
  });

  @GET('/auctions/{id}/summary')
  Future<AuctionSummary> getAuctionSummary(@Path('id') String auctionId);

  @GET('/auctions/{id}/summary/franchises/{franchiseId}')
  Future<FranchiseDetailedSummary> getFranchiseDetailedSummary(
    @Path('id') String auctionId,
    @Path('franchiseId') String franchiseId,
  );

  @GET('/auctions/{id}/summary/unsold')
  Future<UnsoldPlayersResponse> getUnsoldPlayers(
    @Path('id') String auctionId, {
    @Query('page') int? page,
    @Query('size') int? size,
  });

  // ---- Exports (raw bytes) ----

  @GET('/auctions/{id}/summary/export/pdf')
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> exportSummaryPdf(@Path('id') String auctionId);

  @GET('/auctions/{id}/summary/franchises/{franchiseId}/export/pdf')
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> exportFranchisePdf(
    @Path('id') String auctionId,
    @Path('franchiseId') String franchiseId,
  );

  @GET('/auctions/{id}/summary/franchises/{franchiseId}/export/image')
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> exportFranchiseImage(
    @Path('id') String auctionId,
    @Path('franchiseId') String franchiseId,
  );

  // ---- Admin ----

  @DELETE('/auctions/{id}')
  Future<void> deleteAuction(@Path('id') String auctionId);

  @POST('/auctions/{id}/regenerate-view-token')
  Future<AuctionResponse> regenerateViewToken(@Path('id') String auctionId);
}
