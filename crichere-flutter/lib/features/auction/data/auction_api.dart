import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../domain/entities/auction_summary.dart';

part 'auction_api.g.dart';

@RestApi()
abstract class AuctionApi {
  factory AuctionApi(Dio dio, {String baseUrl}) = _AuctionApi;

  @GET("/auctions/{id}/state")
  Future<dynamic> getAuctionState(@Path("id") String auctionId);

  @GET("/auctions/{id}/summary")
  Future<AuctionSummary> getAuctionSummary(@Path("id") String auctionId);

  // A1: was /players/next → /player/put (no body = random player)
  @POST('/auctions/{id}/player/put')
  Future<void> putRandomPlayer(@Path('id') String auctionId);

  // A2: was /players/{playerId} path var → /player/put with body {leaguePlayerId}
  @POST('/auctions/{id}/player/put')
  Future<void> putSpecificPlayer(
    @Path('id') String auctionId,
    @Body() Map<String, dynamic> body,
  );

  // A12: field was 'amount' → 'bidAmount'
  @POST('/auctions/{id}/bid')
  Future<void> recordBid(@Path('id') String auctionId, @Body() Map<String, dynamic> body);

  // A3: was /sold → /player/sold, now requires body
  @POST('/auctions/{id}/player/sold')
  Future<void> markSold(@Path('id') String auctionId, @Body() Map<String, dynamic> body);

  // A4: was /unsold → /player/unsold, now requires body
  @POST('/auctions/{id}/player/unsold')
  Future<void> markUnsold(@Path('id') String auctionId, @Body() Map<String, dynamic> body);

  // A5: was POST /undo-bid → PATCH /bid/undo, requires body {reason}
  @PATCH('/auctions/{id}/bid/undo')
  Future<void> undoBid(@Path('id') String auctionId, @Body() Map<String, dynamic> body);

  // A6: was POST /undo-sold → PATCH /player/undo-sold, body needs leaguePlayerId
  @PATCH('/auctions/{id}/player/undo-sold')
  Future<void> undoSold(@Path('id') String auctionId, @Body() Map<String, dynamic> body);

  // A7: was /force-assign, field playerId → leaguePlayerId, add price
  @POST('/auctions/{id}/player/force-assign')
  Future<void> forceAssign(@Path('id') String auctionId, @Body() Map<String, dynamic> body);

  // A8: was /pre-assign, field playerId → leaguePlayerId, type → assignmentType
  @POST('/auctions/{id}/player/pre-assign')
  Future<void> preAssign(@Path('id') String auctionId, @Body() Map<String, dynamic> body);

  // A9: field was remainingSeconds → durationSeconds
  @POST('/auctions/{id}/timer/start')
  Future<void> startTimer(@Path('id') String auctionId, @Body() Map<String, dynamic> body);

  // A10: was /timer/pause → /timer/stop (no body)
  @POST('/auctions/{id}/timer/stop')
  Future<void> stopTimer(@Path('id') String auctionId);

  // A11: /timer/reset does not exist — removed

  // E1: Franchise squad via auction summary (replaces non-existent /franchises/{id}/squad)
  @GET('/auctions/{auctionId}/summary/franchises/{franchiseId}')
  Future<dynamic> getFranchiseDetailedSummary(
    @Path('auctionId') String auctionId,
    @Path('franchiseId') String franchiseId,
  );
}
