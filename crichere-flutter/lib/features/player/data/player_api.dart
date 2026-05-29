import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../league/domain/entities/league_player.dart';

part 'player_api.g.dart';

/// Client for the backend `PlayerController` (`/players`).
@RestApi()
abstract class PlayerApi {
  factory PlayerApi(Dio dio, {String baseUrl}) = _PlayerApi;

  /// Registers a user into a league as a player.
  /// Body: `{leagueId, userId, basePrice?, category?, tag?}`.
  @POST('/players/register')
  Future<LeaguePlayer> registerPlayer(@Body() Map<String, dynamic> body);

  @GET('/players/{id}')
  Future<LeaguePlayer> getPlayer(@Path('id') String id);
}
