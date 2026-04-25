import '../../../core/database/app_database.dart';
import '../domain/entities/league.dart' as domain;
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
          logoUrl: e.logoUrl,
          status: e.status,
          auctionDate: e.auctionDate,
        )).toList();
      }
    }

    final remote = await _api.getLeagues();
    
    await _db.batch((batch) {
      batch.deleteAll(_db.leagues);
      batch.insertAll(_db.leagues, remote.map((e) => LeaguesCompanion.insert(
        id: e.id,
        name: e.name,
        logoUrl: Value(e.logoUrl),
        status: e.status,
        auctionDate: Value(e.auctionDate),
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
  Future<void> importPlayers(String leagueId, File csvFile) async {
    await _api.importPlayers(leagueId, csvFile);
  }
}
