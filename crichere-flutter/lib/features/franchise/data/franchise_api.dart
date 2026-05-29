import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../domain/entities/franchise_invite.dart';
import '../domain/entities/franchise.dart';
import '../domain/entities/franchise_squad.dart';

part 'franchise_api.g.dart';

@RestApi()
abstract class FranchiseApi {
  factory FranchiseApi(Dio dio, {String baseUrl}) = _FranchiseApi;

  /// Body: `{leagueId, name, logoUrl?, ownerId, totalPurse}`.
  @POST('/franchises')
  Future<Franchise> createFranchise(@Body() Map<String, dynamic> body);

  /// Body: `{email}`.
  @POST('/franchises/{id}/invites')
  Future<FranchiseInvite> createInvite(
    @Path('id') String franchiseId,
    @Body() Map<String, dynamic> body,
  );

  @GET('/franchises/{id}')
  Future<Franchise> getFranchise(@Path('id') String franchiseId);

  @PATCH('/franchises/{id}')
  Future<Franchise> updateFranchise(@Path('id') String franchiseId, @Body() Map<String, dynamic> body);

  @GET('/franchises/{id}/invites')
  Future<List<FranchiseInvite>> getInvites(@Path('id') String franchiseId);

  @GET('/franchises/{id}/squad')
  Future<FranchiseSquadResponse> getSquad(@Path('id') String franchiseId);

  @GET('/public/invites/validate')
  Future<InviteValidationResponse> validateInvite(@Query('token') String token);

  @POST('/franchises/accept')
  Future<Franchise> acceptInvite(@Body() InviteAcceptRequest request);
}
