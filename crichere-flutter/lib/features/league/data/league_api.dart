import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../domain/entities/league.dart';

part 'league_api.g.dart';

@RestApi()
abstract class LeagueApi {
  factory LeagueApi(Dio dio, {String baseUrl}) = _LeagueApi;

  @GET('/leagues')
  Future<List<League>> getLeagues();

  @GET('/leagues/{id}')
  Future<League> getLeagueDetail(@Path('id') String id);
}
