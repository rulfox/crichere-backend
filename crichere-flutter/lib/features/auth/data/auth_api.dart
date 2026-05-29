import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/network/page_response.dart';
import '../../league/domain/entities/league.dart';
import 'models/auth_request.dart';
import 'models/auth_response.dart';
import '../domain/entities/user_profile.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/auth/otp/send')
  Future<void> sendOtp(@Body() LoginRequest request);

  @POST('/auth/otp/verify')
  Future<AuthResponse> verifyOtp(@Body() VerifyRequest request);
  
  @POST('/auth/token/refresh')
  Future<AuthResponse> refreshToken(@Body() RefreshRequest request);

  @POST('/auth/claim-profile')
  Future<void> claimProfile(@Body() ClaimRequest request);

  @GET('/auth/me')
  Future<UserProfile> getCurrentUser();

  @POST('/auth/logout')
  Future<void> logout();

  // User Management
  @GET('/users/{id}')
  Future<UserProfile> getUser(@Path('id') String id);

  @GET('/users/{id}/leagues')
  Future<List<League>> getUserLeagues(@Path('id') String id);

  @PUT('/users/{id}/basic')
  Future<void> updateBasicInfo(@Path('id') String id, @Body() UserBasicInfoRequest request);

  @PUT('/users/{id}/cricket-profile')
  Future<void> updateCricketProfile(@Path('id') String id, @Body() CricketProfileRequest request);

  @PUT('/users/{id}/photo')
  Future<void> updatePhoto(@Path('id') String id, @Body() Map<String, String> request);

  @GET('/users/search')
  Future<PageResponse<AuthResponse>> searchUsers(
    @Query('query') String query, {
    @Query('page') int? page,
    @Query('size') int? size,
  });
}
