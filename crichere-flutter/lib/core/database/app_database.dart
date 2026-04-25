import 'package:drift/drift.dart';

import 'connection/native.dart'
    if (dart.library.html) 'connection/web.dart';

part 'app_database.g.dart';

class Leagues extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get logoUrl => text().nullable()();
  TextColumn get status => text()();
  DateTimeColumn get auctionDate => dateTime().nullable()();
  
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

class Notifications extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get message => text()();
  DateTimeColumn get receivedAt => dateTime()();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [Leagues, Players, Notifications])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 1;
}
