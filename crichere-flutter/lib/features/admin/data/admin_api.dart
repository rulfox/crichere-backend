import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../features/league/domain/entities/league.dart';

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
}
