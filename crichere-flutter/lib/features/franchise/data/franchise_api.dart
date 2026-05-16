import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../domain/entities/franchise_invite.dart';
import '../domain/entities/franchise.dart';

part 'franchise_api.g.dart';

@RestApi()
abstract class FranchiseApi {
  factory FranchiseApi(Dio dio, {String baseUrl}) = _FranchiseApi;

  // E1: /franchises/{id}/squad does not exist in backend.
  // Squad data comes from GET /auctions/{id}/summary -> franchiseSummaries.
  // FranchiseSquadScreen is updated to use auction summary instead.

  @GET('/franchises/{id}')
  Future<Franchise> getFranchise(@Path('id') String franchiseId);

  @GET('/public/invites/validate')
  Future<InviteValidationResponse> validateInvite(@Query('token') String token);

  @POST('/franchises/accept')
  Future<Franchise> acceptInvite(@Body() InviteAcceptRequest request);
}
