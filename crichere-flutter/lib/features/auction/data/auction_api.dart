import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auction_api.g.dart';

@RestApi()
abstract class AuctionApi {
  factory AuctionApi(Dio dio, {String baseUrl}) = _AuctionApi;

  @GET("/auctions/{id}/state")
  Future<Map<String, dynamic>> getAuctionState(@Path("id") String auctionId);

  @POST('/auctions/{id}/players/next')
  Future<void> putRandomPlayer(@Path('id') String auctionId);

  @POST('/auctions/{id}/players/{playerId}')
  Future<void> putSpecificPlayer(@Path('id') String auctionId, @Path('playerId') String playerId);

  @POST('/auctions/{id}/bid')
  Future<void> recordBid(@Path('id') String auctionId, @Body() Map<String, dynamic> body);

  @POST('/auctions/{id}/sold')
  Future<void> markSold(@Path('id') String auctionId);

  @POST('/auctions/{id}/unsold')
  Future<void> markUnsold(@Path('id') String auctionId);

  @POST('/auctions/{id}/undo-bid')
  Future<void> undoBid(@Path('id') String auctionId);

  @POST('/auctions/{id}/undo-sold')
  Future<void> undoSold(@Path('id') String auctionId, @Body() Map<String, dynamic> body);
}
