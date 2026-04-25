import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'models/auth_request.dart';
import 'models/auth_response.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/auth/login')
  Future<AuthResponse> login(@Body() LoginRequest request);

  @POST('/auth/verify')
  Future<AuthResponse> verify(@Body() VerifyRequest request);
  
  @POST('/auth/refresh')
  Future<AuthResponse> refresh(@Body() RefreshRequest request);

  @POST('/auth/claim')
  Future<void> claim(@Body() ClaimRequest request);
}
