import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'admin_api.g.dart';

@RestApi()
abstract class AdminApi {
  factory AdminApi(Dio dio, {String baseUrl}) = _AdminApi;

  // F1: /admin/metrics does not exist in backend — removed

  // F2: backend returns paginated ApiResponse<Any> (Page<LeagueResponse>)
  // Using dynamic to manually extract the content list
  @GET('/admin/leagues')
  Future<dynamic> getLeagues({
    @Query('status') String? status,
    @Query('search') String? search,
    @Query('page') int page = 0,
    @Query('size') int size = 50,
  });

  @PATCH('/admin/leagues/{id}/suspend')
  Future<void> suspendLeague(
    @Path('id') String leagueId,
    @Body() Map<String, dynamic> body,
  );

  // ---- User management ----

  @GET('/admin/users')
  Future<dynamic> getUsers({
    @Query('profileStatus') String? profileStatus,
    @Query('search') String? search,
    @Query('page') int page = 0,
    @Query('size') int size = 50,
  });

  /// Body: `{action}` (e.g. add/remove a platform role).
  @PATCH('/admin/users/{id}/roles')
  Future<dynamic> updateUserRole(
    @Path('id') String userId,
    @Body() Map<String, dynamic> body,
  );

  /// Body: `{action, role}` (LeagueRole).
  @PATCH('/admin/leagues/{leagueId}/users/{userId}/roles')
  Future<void> updateLeagueRole(
    @Path('leagueId') String leagueId,
    @Path('userId') String userId,
    @Body() Map<String, dynamic> body,
  );

  /// Body: `{suspended, reason?}`.
  @PATCH('/admin/users/{id}/suspend')
  Future<dynamic> suspendUser(
    @Path('id') String userId,
    @Body() Map<String, dynamic> body,
  );

  @GET('/admin/subscriptions')
  Future<dynamic> getSubscriptions({
    @Query('page') int page = 0,
    @Query('size') int size = 50,
  });
}
