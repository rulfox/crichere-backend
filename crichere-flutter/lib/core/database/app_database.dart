import 'package:drift/drift.dart';

import 'connection/native.dart'
    if (dart.library.html) 'connection/web.dart';

part 'app_database.g.dart';

class Leagues extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get format => text().nullable()();
  TextColumn get rulesUrl => text().nullable()();
  BoolColumn get mustSellAll => boolean().withDefault(const Constant(false))();
  TextColumn get playerOrderMode => text().withDefault(const Constant('RANDOM'))();
  TextColumn get waitingListMode => text().withDefault(const Constant('ADMIN_PICKS'))();
  TextColumn get logoUrl => text().nullable()();
  TextColumn get bannerUrl => text().nullable()();
  TextColumn get status => text()();
  DateTimeColumn get auctionDate => dateTime().nullable()();
  TextColumn get createdBy => text()();
  
  @override
  Set<Column> get primaryKey => {id};
}

class Players extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get photoUrl => text().nullable()();
  TextColumn get role => text()();
  TextColumn get battingStyle => text().nullable()();
  TextColumn get bowlingStyle => text().nullable()();
  IntColumn get basePrice => integer()();
  
  @override
  Set<Column> get primaryKey => {id};
}

class Franchises extends Table {
  TextColumn get id => text()();
  TextColumn get leagueId => text()();
  TextColumn get name => text()();
  TextColumn get logoUrl => text().nullable()();
  IntColumn get startingPurse => integer()();
  IntColumn get currentPurse => integer()();
  
  @override
  Set<Column> get primaryKey => {id};
}

class LeaguePlayers extends Table {
  TextColumn get id => text()();
  TextColumn get leagueId => text()();
  TextColumn get playerId => text()();
  TextColumn get status => text()();
  IntColumn get basePriceOverride => integer().nullable()();
  IntColumn get finalPrice => integer().nullable()();
  TextColumn get franchiseId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Notifications extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get message => text()();
  DateTimeColumn get receivedAt => dateTime()();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [Leagues, Players, Franchises, LeaguePlayers, Notifications])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 1;
}
