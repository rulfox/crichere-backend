import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

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
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
