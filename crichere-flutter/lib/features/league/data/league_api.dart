import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../domain/entities/league.dart';
import '../domain/entities/league_player.dart';
import '../../franchise/domain/entities/franchise.dart';
import 'models/league_request.dart';

part 'league_api.g.dart';

@RestApi()
abstract class LeagueApi {
  factory LeagueApi(Dio dio, {String baseUrl}) = _LeagueApi;

  @GET('/leagues')
  Future<List<League>> getLeagues();

  @GET('/leagues/{id}')
  Future<League> getLeagueDetail(@Path('id') String id);

  @POST('/leagues')
  Future<League> createLeague(@Body() LeagueCreateRequest request);

  @POST('/leagues/{id}/players/import')
  @MultiPart()
  Future<void> importPlayers(
    @Path('id') String leagueId,
    @Part() File file,
  );

  @GET('/leagues/{id}/franchises')
  Future<List<Franchise>> getLeagueFranchises(@Path('id') String leagueId);

  @GET('/leagues/{id}/players')
  Future<List<LeaguePlayer>> getLeaguePlayers(@Path('id') String leagueId);
}
