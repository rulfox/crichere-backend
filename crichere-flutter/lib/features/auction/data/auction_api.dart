import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../domain/entities/auction_summary.dart';
import '../domain/entities/auction_event.dart';

part 'auction_api.g.dart';

@RestApi()
abstract class AuctionApi {
  factory AuctionApi(Dio dio, {String baseUrl}) = _AuctionApi;

  @GET("/auctions/{id}/state")
  Future<dynamic> getAuctionState(@Path("id") String auctionId);

  @GET("/auctions/{id}/summary")
  Future<AuctionSummary> getAuctionSummary(@Path("id") String auctionId);

  @GET('/auctions/{id}/rounds')
  Future<dynamic> getRounds(@Path('id') String auctionId);

  @POST('/auctions/{id}/rounds')
  Future<void> addRound(@Path('id') String auctionId, @Body() Map<String, dynamic> body);

  @DELETE('/auctions/{id}/rounds/{roundId}')
  Future<void> deleteRound(@Path('id') String auctionId, @Path('roundId') String roundId);

  @PATCH('/auctions/{id}/rounds/{roundId}/pool')
  Future<void> updateRoundPool(
    @Path('id') String auctionId,
    @Path('roundId') String roundId,
    @Body() Map<String, dynamic> body,
  );

  @POST('/auctions/{id}/player/put')
  Future<void> putRandomPlayer(@Path('id') String auctionId);

  @POST('/auctions/{id}/player/put')
  Future<void> putSpecificPlayer(
    @Path('id') String auctionId,
    @Body() Map<String, dynamic> body,
  );

  @POST('/auctions/{id}/bid')
  Future<void> recordBid(@Path('id') String auctionId, @Body() Map<String, dynamic> body);

  @POST('/auctions/{id}/player/sold')
  Future<void> markSold(@Path('id') String auctionId, @Body() Map<String, dynamic> body);

  @POST('/auctions/{id}/player/unsold')
  Future<void> markUnsold(@Path('id') String auctionId, @Body() Map<String, dynamic> body);

  @PATCH('/auctions/{id}/bid/undo')
  Future<void> undoBid(@Path('id') String auctionId, @Body() Map<String, dynamic> body);

  @PATCH('/auctions/{id}/player/undo-sold')
  Future<void> undoSold(@Path('id') String auctionId, @Body() Map<String, dynamic> body);

  @POST('/auctions/{id}/player/force-assign')
  Future<void> forceAssign(@Path('id') String auctionId, @Body() Map<String, dynamic> body);

  @POST('/auctions/{id}/player/pre-assign')
  Future<void> preAssign(@Path('id') String auctionId, @Body() Map<String, dynamic> body);

  @POST('/auctions/{id}/timer/start')
  Future<void> startTimer(@Path('id') String auctionId, @Body() Map<String, dynamic> body);

  @POST('/auctions/{id}/timer/stop')
  Future<void> stopTimer(@Path('id') String auctionId);

  @GET('/auctions/{auctionId}/summary/franchises/{franchiseId}')
  Future<dynamic> getFranchiseDetailedSummary(
    @Path('auctionId') String auctionId,
    @Path('franchiseId') String franchiseId,
  );
}
