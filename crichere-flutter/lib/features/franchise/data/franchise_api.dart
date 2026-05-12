import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../domain/entities/franchise_squad.dart';
import '../domain/entities/franchise_invite.dart';
import '../domain/entities/franchise.dart';

part 'franchise_api.g.dart';

@RestApi()
abstract class FranchiseApi {
  factory FranchiseApi(Dio dio, {String baseUrl}) = _FranchiseApi;

  @GET('/franchises/{id}/squad')
  Future<FranchiseSquad> getSquad(@Path('id') String franchiseId);

  @GET('/public/invites/validate')
  Future<InviteValidationResponse> validateInvite(@Query('token') String token);

  @POST('/franchises/accept')
  Future<Franchise> acceptInvite(@Body() InviteAcceptRequest request);
}
