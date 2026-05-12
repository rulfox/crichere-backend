import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../domain/entities/admin_entities.dart';
import '../../../features/league/domain/entities/league.dart';

part 'admin_api.g.dart';

@RestApi()
abstract class AdminApi {
  factory AdminApi(Dio dio, {String baseUrl}) = _AdminApi;

  @GET('/admin/metrics')
  Future<PlatformMetrics> getMetrics();

  @GET('/admin/leagues')
  Future<List<League>> getLeagues({
    @Query('status') String? status,
    @Query('search') String? search,
    @Query('page') int page = 0,
    @Query('size') int size = 20,
  });

  @PATCH('/admin/leagues/{id}/suspend')
  Future<void> suspendLeague(
    @Path('id') String leagueId,
    @Body() Map<String, dynamic> body,
  );
}
