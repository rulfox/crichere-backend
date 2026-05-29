import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../auction/domain/entities/auction_state_snapshot.dart';

part 'public_auction_api.g.dart';

/// Client for the backend public spectator endpoints (`/public/auctions`).
/// Uses a Dio instance WITHOUT the auth interceptor (these are unauthenticated).
@RestApi()
abstract class PublicAuctionApi {
  factory PublicAuctionApi(Dio dio, {String baseUrl}) = _PublicAuctionApi;

  @GET('/public/auctions/{id}/state')
  Future<AuctionStateSnapshot> getPublicState(@Path('id') String auctionId);

  @GET('/public/auctions/view/{token}')
  Future<AuctionStateSnapshot> getPublicView(@Path('token') String token);

  /// Returns a status map (e.g. `{status, isLive, ...}`).
  @GET('/public/auctions/view/{token}/status')
  Future<dynamic> getViewStatus(@Path('token') String token);
}
