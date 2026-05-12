import '../../../core/database/app_database.dart' hide Franchise, LeaguePlayer, League;
import '../domain/entities/league.dart' as domain;
import '../domain/entities/league_player.dart';
import '../../franchise/domain/entities/franchise.dart';
import '../domain/repositories/league_repository.dart';
import 'league_api.dart';
import 'models/league_request.dart';
import 'package:drift/drift.dart';
import 'dart:io';

class LeagueRepositoryImpl implements LeagueRepository {
  final LeagueApi _api;
  final AppDatabase _db;

  LeagueRepositoryImpl(this._api, this._db);

  @override
  Future<List<domain.League>> getLeagues({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      final cached = await (_db.select(_db.leagues)).get();
      if (cached.isNotEmpty) {
        return cached.map((e) => domain.League(
          id: e.id,
          name: e.name,
          format: e.format,
          rulesUrl: e.rulesUrl,
          mustSellAll: e.mustSellAll,
          playerOrderMode: e.playerOrderMode,
          waitingListMode: e.waitingListMode,
          logoUrl: e.logoUrl,
          bannerUrl: e.bannerUrl,
          status: e.status,
          auctionDate: e.auctionDate,
          createdBy: e.createdBy,
        )).toList();
      }
    }

    final remote = await _api.getLeagues();
    
    await _db.batch((batch) {
      batch.deleteAll(_db.leagues);
      batch.insertAll(_db.leagues, remote.map((e) => LeaguesCompanion.insert(
        id: e.id,
        name: e.name,
        format: Value(e.format),
        rulesUrl: Value(e.rulesUrl),
        mustSellAll: Value(e.mustSellAll),
        playerOrderMode: Value(e.playerOrderMode),
        waitingListMode: Value(e.waitingListMode),
        logoUrl: Value(e.logoUrl),
        bannerUrl: Value(e.bannerUrl),
        status: e.status,
        auctionDate: Value(e.auctionDate),
        createdBy: e.createdBy,
      )).toList());
    });

    return remote;
  }

  @override
  Future<domain.League> getLeagueDetail(String id) async {
    return await _api.getLeagueDetail(id);
  }

  @override
  Future<domain.League> createLeague(LeagueCreateRequest request) async {
    return await _api.createLeague(request);
  }

  @override
  Future<void> importPlayers(String leagueId, File file) async {
    await _api.importPlayers(leagueId, file);
  }

  @override
  Future<List<Franchise>> getFranchises(String leagueId) async {
    return await _api.getLeagueFranchises(leagueId);
  }

  @override
  Future<List<LeaguePlayer>> getLeaguePlayers(String leagueId) async {
    return await _api.getLeaguePlayers(leagueId);
  }
}
