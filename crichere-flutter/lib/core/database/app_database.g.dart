// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LeaguesTable extends Leagues with TableInfo<$LeaguesTable, League> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LeaguesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _logoUrlMeta = const VerificationMeta(
    'logoUrl',
  );
  @override
  late final GeneratedColumn<String> logoUrl = GeneratedColumn<String>(
    'logo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _auctionDateMeta = const VerificationMeta(
    'auctionDate',
  );
  @override
  late final GeneratedColumn<DateTime> auctionDate = GeneratedColumn<DateTime>(
    'auction_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    logoUrl,
    status,
    auctionDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'leagues';
  @override
  VerificationContext validateIntegrity(
    Insertable<League> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('logo_url')) {
      context.handle(
        _logoUrlMeta,
        logoUrl.isAcceptableOrUnknown(data['logo_url']!, _logoUrlMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('auction_date')) {
      context.handle(
        _auctionDateMeta,
        auctionDate.isAcceptableOrUnknown(
          data['auction_date']!,
          _auctionDateMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  League map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return League(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      logoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_url'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      auctionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}auction_date'],
      ),
    );
  }

  @override
  $LeaguesTable createAlias(String alias) {
    return $LeaguesTable(attachedDatabase, alias);
  }
}

class League extends DataClass implements Insertable<League> {
  final String id;
  final String name;
  final String? logoUrl;
  final String status;
  final DateTime? auctionDate;
  const League({
    required this.id,
    required this.name,
    this.logoUrl,
    required this.status,
    this.auctionDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || logoUrl != null) {
      map['logo_url'] = Variable<String>(logoUrl);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || auctionDate != null) {
      map['auction_date'] = Variable<DateTime>(auctionDate);
    }
    return map;
  }

  LeaguesCompanion toCompanion(bool nullToAbsent) {
    return LeaguesCompanion(
      id: Value(id),
      name: Value(name),
      logoUrl: logoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(logoUrl),
      status: Value(status),
      auctionDate: auctionDate == null && nullToAbsent
          ? const Value.absent()
          : Value(auctionDate),
    );
  }

  factory League.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return League(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      logoUrl: serializer.fromJson<String?>(json['logoUrl']),
      status: serializer.fromJson<String>(json['status']),
      auctionDate: serializer.fromJson<DateTime?>(json['auctionDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'logoUrl': serializer.toJson<String?>(logoUrl),
      'status': serializer.toJson<String>(status),
      'auctionDate': serializer.toJson<DateTime?>(auctionDate),
    };
  }

  League copyWith({
    String? id,
    String? name,
    Value<String?> logoUrl = const Value.absent(),
    String? status,
    Value<DateTime?> auctionDate = const Value.absent(),
  }) => League(
    id: id ?? this.id,
    name: name ?? this.name,
    logoUrl: logoUrl.present ? logoUrl.value : this.logoUrl,
    status: status ?? this.status,
    auctionDate: auctionDate.present ? auctionDate.value : this.auctionDate,
  );
  League copyWithCompanion(LeaguesCompanion data) {
    return League(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      logoUrl: data.logoUrl.present ? data.logoUrl.value : this.logoUrl,
      status: data.status.present ? data.status.value : this.status,
      auctionDate: data.auctionDate.present
          ? data.auctionDate.value
          : this.auctionDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('League(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('status: $status, ')
          ..write('auctionDate: $auctionDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, logoUrl, status, auctionDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is League &&
          other.id == this.id &&
          other.name == this.name &&
          other.logoUrl == this.logoUrl &&
          other.status == this.status &&
          other.auctionDate == this.auctionDate);
}

class LeaguesCompanion extends UpdateCompanion<League> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> logoUrl;
  final Value<String> status;
  final Value<DateTime?> auctionDate;
  final Value<int> rowid;
  const LeaguesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.status = const Value.absent(),
    this.auctionDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LeaguesCompanion.insert({
    required String id,
    required String name,
    this.logoUrl = const Value.absent(),
    required String status,
    this.auctionDate = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       status = Value(status);
  static Insertable<League> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? logoUrl,
    Expression<String>? status,
    Expression<DateTime>? auctionDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (logoUrl != null) 'logo_url': logoUrl,
      if (status != null) 'status': status,
      if (auctionDate != null) 'auction_date': auctionDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LeaguesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? logoUrl,
    Value<String>? status,
    Value<DateTime?>? auctionDate,
    Value<int>? rowid,
  }) {
    return LeaguesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      logoUrl: logoUrl ?? this.logoUrl,
      status: status ?? this.status,
      auctionDate: auctionDate ?? this.auctionDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (logoUrl.present) {
      map['logo_url'] = Variable<String>(logoUrl.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (auctionDate.present) {
      map['auction_date'] = Variable<DateTime>(auctionDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LeaguesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('status: $status, ')
          ..write('auctionDate: $auctionDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlayersTable extends Players with TableInfo<$PlayersTable, Player> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _battingStyleMeta = const VerificationMeta(
    'battingStyle',
  );
  @override
  late final GeneratedColumn<String> battingStyle = GeneratedColumn<String>(
    'batting_style',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bowlingStyleMeta = const VerificationMeta(
    'bowlingStyle',
  );
  @override
  late final GeneratedColumn<String> bowlingStyle = GeneratedColumn<String>(
    'bowling_style',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _basePriceMeta = const VerificationMeta(
    'basePrice',
  );
  @override
  late final GeneratedColumn<int> basePrice = GeneratedColumn<int>(
    'base_price',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    photoUrl,
    role,
    battingStyle,
    bowlingStyle,
    basePrice,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'players';
  @override
  VerificationContext validateIntegrity(
    Insertable<Player> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('batting_style')) {
      context.handle(
        _battingStyleMeta,
        battingStyle.isAcceptableOrUnknown(
          data['batting_style']!,
          _battingStyleMeta,
        ),
      );
    }
    if (data.containsKey('bowling_style')) {
      context.handle(
        _bowlingStyleMeta,
        bowlingStyle.isAcceptableOrUnknown(
          data['bowling_style']!,
          _bowlingStyleMeta,
        ),
      );
    }
    if (data.containsKey('base_price')) {
      context.handle(
        _basePriceMeta,
        basePrice.isAcceptableOrUnknown(data['base_price']!, _basePriceMeta),
      );
    } else if (isInserting) {
      context.missing(_basePriceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Player map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Player(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      ),
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      battingStyle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}batting_style'],
      ),
      bowlingStyle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bowling_style'],
      ),
      basePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_price'],
      )!,
    );
  }

  @override
  $PlayersTable createAlias(String alias) {
    return $PlayersTable(attachedDatabase, alias);
  }
}

class Player extends DataClass implements Insertable<Player> {
  final String id;
  final String name;
  final String? photoUrl;
  final String role;
  final String? battingStyle;
  final String? bowlingStyle;
  final int basePrice;
  const Player({
    required this.id,
    required this.name,
    this.photoUrl,
    required this.role,
    this.battingStyle,
    this.bowlingStyle,
    required this.basePrice,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    map['role'] = Variable<String>(role);
    if (!nullToAbsent || battingStyle != null) {
      map['batting_style'] = Variable<String>(battingStyle);
    }
    if (!nullToAbsent || bowlingStyle != null) {
      map['bowling_style'] = Variable<String>(bowlingStyle);
    }
    map['base_price'] = Variable<int>(basePrice);
    return map;
  }

  PlayersCompanion toCompanion(bool nullToAbsent) {
    return PlayersCompanion(
      id: Value(id),
      name: Value(name),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      role: Value(role),
      battingStyle: battingStyle == null && nullToAbsent
          ? const Value.absent()
          : Value(battingStyle),
      bowlingStyle: bowlingStyle == null && nullToAbsent
          ? const Value.absent()
          : Value(bowlingStyle),
      basePrice: Value(basePrice),
    );
  }

  factory Player.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Player(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
      role: serializer.fromJson<String>(json['role']),
      battingStyle: serializer.fromJson<String?>(json['battingStyle']),
      bowlingStyle: serializer.fromJson<String?>(json['bowlingStyle']),
      basePrice: serializer.fromJson<int>(json['basePrice']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'photoUrl': serializer.toJson<String?>(photoUrl),
      'role': serializer.toJson<String>(role),
      'battingStyle': serializer.toJson<String?>(battingStyle),
      'bowlingStyle': serializer.toJson<String?>(bowlingStyle),
      'basePrice': serializer.toJson<int>(basePrice),
    };
  }

  Player copyWith({
    String? id,
    String? name,
    Value<String?> photoUrl = const Value.absent(),
    String? role,
    Value<String?> battingStyle = const Value.absent(),
    Value<String?> bowlingStyle = const Value.absent(),
    int? basePrice,
  }) => Player(
    id: id ?? this.id,
    name: name ?? this.name,
    photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
    role: role ?? this.role,
    battingStyle: battingStyle.present ? battingStyle.value : this.battingStyle,
    bowlingStyle: bowlingStyle.present ? bowlingStyle.value : this.bowlingStyle,
    basePrice: basePrice ?? this.basePrice,
  );
  Player copyWithCompanion(PlayersCompanion data) {
    return Player(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      role: data.role.present ? data.role.value : this.role,
      battingStyle: data.battingStyle.present
          ? data.battingStyle.value
          : this.battingStyle,
      bowlingStyle: data.bowlingStyle.present
          ? data.bowlingStyle.value
          : this.bowlingStyle,
      basePrice: data.basePrice.present ? data.basePrice.value : this.basePrice,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Player(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('role: $role, ')
          ..write('battingStyle: $battingStyle, ')
          ..write('bowlingStyle: $bowlingStyle, ')
          ..write('basePrice: $basePrice')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    photoUrl,
    role,
    battingStyle,
    bowlingStyle,
    basePrice,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Player &&
          other.id == this.id &&
          other.name == this.name &&
          other.photoUrl == this.photoUrl &&
          other.role == this.role &&
          other.battingStyle == this.battingStyle &&
          other.bowlingStyle == this.bowlingStyle &&
          other.basePrice == this.basePrice);
}

class PlayersCompanion extends UpdateCompanion<Player> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> photoUrl;
  final Value<String> role;
  final Value<String?> battingStyle;
  final Value<String?> bowlingStyle;
  final Value<int> basePrice;
  final Value<int> rowid;
  const PlayersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.role = const Value.absent(),
    this.battingStyle = const Value.absent(),
    this.bowlingStyle = const Value.absent(),
    this.basePrice = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlayersCompanion.insert({
    required String id,
    required String name,
    this.photoUrl = const Value.absent(),
    required String role,
    this.battingStyle = const Value.absent(),
    this.bowlingStyle = const Value.absent(),
    required int basePrice,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       role = Value(role),
       basePrice = Value(basePrice);
  static Insertable<Player> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? photoUrl,
    Expression<String>? role,
    Expression<String>? battingStyle,
    Expression<String>? bowlingStyle,
    Expression<int>? basePrice,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (role != null) 'role': role,
      if (battingStyle != null) 'batting_style': battingStyle,
      if (bowlingStyle != null) 'bowling_style': bowlingStyle,
      if (basePrice != null) 'base_price': basePrice,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlayersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? photoUrl,
    Value<String>? role,
    Value<String?>? battingStyle,
    Value<String?>? bowlingStyle,
    Value<int>? basePrice,
    Value<int>? rowid,
  }) {
    return PlayersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      role: role ?? this.role,
      battingStyle: battingStyle ?? this.battingStyle,
      bowlingStyle: bowlingStyle ?? this.bowlingStyle,
      basePrice: basePrice ?? this.basePrice,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (battingStyle.present) {
      map['batting_style'] = Variable<String>(battingStyle.value);
    }
    if (bowlingStyle.present) {
      map['bowling_style'] = Variable<String>(bowlingStyle.value);
    }
    if (basePrice.present) {
      map['base_price'] = Variable<int>(basePrice.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('role: $role, ')
          ..write('battingStyle: $battingStyle, ')
          ..write('bowlingStyle: $bowlingStyle, ')
          ..write('basePrice: $basePrice, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationsTable extends Notifications
    with TableInfo<$NotificationsTable, Notification> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receivedAtMeta = const VerificationMeta(
    'receivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> receivedAt = GeneratedColumn<DateTime>(
    'received_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
    'is_read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_read" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    message,
    receivedAt,
    isRead,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notifications';
  @override
  VerificationContext validateIntegrity(
    Insertable<Notification> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('received_at')) {
      context.handle(
        _receivedAtMeta,
        receivedAt.isAcceptableOrUnknown(data['received_at']!, _receivedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_receivedAtMeta);
    }
    if (data.containsKey('is_read')) {
      context.handle(
        _isReadMeta,
        isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Notification map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Notification(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      receivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}received_at'],
      )!,
      isRead: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_read'],
      )!,
    );
  }

  @override
  $NotificationsTable createAlias(String alias) {
    return $NotificationsTable(attachedDatabase, alias);
  }
}

class Notification extends DataClass implements Insertable<Notification> {
  final int id;
  final String title;
  final String message;
  final DateTime receivedAt;
  final bool isRead;
  const Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.receivedAt,
    required this.isRead,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['message'] = Variable<String>(message);
    map['received_at'] = Variable<DateTime>(receivedAt);
    map['is_read'] = Variable<bool>(isRead);
    return map;
  }

  NotificationsCompanion toCompanion(bool nullToAbsent) {
    return NotificationsCompanion(
      id: Value(id),
      title: Value(title),
      message: Value(message),
      receivedAt: Value(receivedAt),
      isRead: Value(isRead),
    );
  }

  factory Notification.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Notification(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      message: serializer.fromJson<String>(json['message']),
      receivedAt: serializer.fromJson<DateTime>(json['receivedAt']),
      isRead: serializer.fromJson<bool>(json['isRead']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'message': serializer.toJson<String>(message),
      'receivedAt': serializer.toJson<DateTime>(receivedAt),
      'isRead': serializer.toJson<bool>(isRead),
    };
  }

  Notification copyWith({
    int? id,
    String? title,
    String? message,
    DateTime? receivedAt,
    bool? isRead,
  }) => Notification(
    id: id ?? this.id,
    title: title ?? this.title,
    message: message ?? this.message,
    receivedAt: receivedAt ?? this.receivedAt,
    isRead: isRead ?? this.isRead,
  );
  Notification copyWithCompanion(NotificationsCompanion data) {
    return Notification(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      message: data.message.present ? data.message.value : this.message,
      receivedAt: data.receivedAt.present
          ? data.receivedAt.value
          : this.receivedAt,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Notification(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('message: $message, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('isRead: $isRead')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, message, receivedAt, isRead);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Notification &&
          other.id == this.id &&
          other.title == this.title &&
          other.message == this.message &&
          other.receivedAt == this.receivedAt &&
          other.isRead == this.isRead);
}

class NotificationsCompanion extends UpdateCompanion<Notification> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> message;
  final Value<DateTime> receivedAt;
  final Value<bool> isRead;
  const NotificationsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.message = const Value.absent(),
    this.receivedAt = const Value.absent(),
    this.isRead = const Value.absent(),
  });
  NotificationsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String message,
    required DateTime receivedAt,
    this.isRead = const Value.absent(),
  }) : title = Value(title),
       message = Value(message),
       receivedAt = Value(receivedAt);
  static Insertable<Notification> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? message,
    Expression<DateTime>? receivedAt,
    Expression<bool>? isRead,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (message != null) 'message': message,
      if (receivedAt != null) 'received_at': receivedAt,
      if (isRead != null) 'is_read': isRead,
    });
  }

  NotificationsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? message,
    Value<DateTime>? receivedAt,
    Value<bool>? isRead,
  }) {
    return NotificationsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      receivedAt: receivedAt ?? this.receivedAt,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (receivedAt.present) {
      map['received_at'] = Variable<DateTime>(receivedAt.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('message: $message, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('isRead: $isRead')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LeaguesTable leagues = $LeaguesTable(this);
  late final $PlayersTable players = $PlayersTable(this);
  late final $NotificationsTable notifications = $NotificationsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    leagues,
    players,
    notifications,
  ];
}

typedef $$LeaguesTableCreateCompanionBuilder =
    LeaguesCompanion Function({
      required String id,
      required String name,
      Value<String?> logoUrl,
      required String status,
      Value<DateTime?> auctionDate,
      Value<int> rowid,
    });
typedef $$LeaguesTableUpdateCompanionBuilder =
    LeaguesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> logoUrl,
      Value<String> status,
      Value<DateTime?> auctionDate,
      Value<int> rowid,
    });

class $$LeaguesTableFilterComposer
    extends Composer<_$AppDatabase, $LeaguesTable> {
  $$LeaguesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logoUrl => $composableBuilder(
    column: $table.logoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get auctionDate => $composableBuilder(
    column: $table.auctionDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LeaguesTableOrderingComposer
    extends Composer<_$AppDatabase, $LeaguesTable> {
  $$LeaguesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoUrl => $composableBuilder(
    column: $table.logoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get auctionDate => $composableBuilder(
    column: $table.auctionDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LeaguesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LeaguesTable> {
  $$LeaguesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get logoUrl =>
      $composableBuilder(column: $table.logoUrl, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get auctionDate => $composableBuilder(
    column: $table.auctionDate,
    builder: (column) => column,
  );
}

class $$LeaguesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LeaguesTable,
          League,
          $$LeaguesTableFilterComposer,
          $$LeaguesTableOrderingComposer,
          $$LeaguesTableAnnotationComposer,
          $$LeaguesTableCreateCompanionBuilder,
          $$LeaguesTableUpdateCompanionBuilder,
          (League, BaseReferences<_$AppDatabase, $LeaguesTable, League>),
          League,
          PrefetchHooks Function()
        > {
  $$LeaguesTableTableManager(_$AppDatabase db, $LeaguesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LeaguesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LeaguesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LeaguesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> logoUrl = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> auctionDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LeaguesCompanion(
                id: id,
                name: name,
                logoUrl: logoUrl,
                status: status,
                auctionDate: auctionDate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> logoUrl = const Value.absent(),
                required String status,
                Value<DateTime?> auctionDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LeaguesCompanion.insert(
                id: id,
                name: name,
                logoUrl: logoUrl,
                status: status,
                auctionDate: auctionDate,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LeaguesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LeaguesTable,
      League,
      $$LeaguesTableFilterComposer,
      $$LeaguesTableOrderingComposer,
      $$LeaguesTableAnnotationComposer,
      $$LeaguesTableCreateCompanionBuilder,
      $$LeaguesTableUpdateCompanionBuilder,
      (League, BaseReferences<_$AppDatabase, $LeaguesTable, League>),
      League,
      PrefetchHooks Function()
    >;
typedef $$PlayersTableCreateCompanionBuilder =
    PlayersCompanion Function({
      required String id,
      required String name,
      Value<String?> photoUrl,
      required String role,
      Value<String?> battingStyle,
      Value<String?> bowlingStyle,
      required int basePrice,
      Value<int> rowid,
    });
typedef $$PlayersTableUpdateCompanionBuilder =
    PlayersCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> photoUrl,
      Value<String> role,
      Value<String?> battingStyle,
      Value<String?> bowlingStyle,
      Value<int> basePrice,
      Value<int> rowid,
    });

class $$PlayersTableFilterComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get battingStyle => $composableBuilder(
    column: $table.battingStyle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bowlingStyle => $composableBuilder(
    column: $table.bowlingStyle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get basePrice => $composableBuilder(
    column: $table.basePrice,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlayersTableOrderingComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get battingStyle => $composableBuilder(
    column: $table.battingStyle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bowlingStyle => $composableBuilder(
    column: $table.bowlingStyle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get basePrice => $composableBuilder(
    column: $table.basePrice,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlayersTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get battingStyle => $composableBuilder(
    column: $table.battingStyle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bowlingStyle => $composableBuilder(
    column: $table.bowlingStyle,
    builder: (column) => column,
  );

  GeneratedColumn<int> get basePrice =>
      $composableBuilder(column: $table.basePrice, builder: (column) => column);
}

class $$PlayersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlayersTable,
          Player,
          $$PlayersTableFilterComposer,
          $$PlayersTableOrderingComposer,
          $$PlayersTableAnnotationComposer,
          $$PlayersTableCreateCompanionBuilder,
          $$PlayersTableUpdateCompanionBuilder,
          (Player, BaseReferences<_$AppDatabase, $PlayersTable, Player>),
          Player,
          PrefetchHooks Function()
        > {
  $$PlayersTableTableManager(_$AppDatabase db, $PlayersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String?> battingStyle = const Value.absent(),
                Value<String?> bowlingStyle = const Value.absent(),
                Value<int> basePrice = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlayersCompanion(
                id: id,
                name: name,
                photoUrl: photoUrl,
                role: role,
                battingStyle: battingStyle,
                bowlingStyle: bowlingStyle,
                basePrice: basePrice,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> photoUrl = const Value.absent(),
                required String role,
                Value<String?> battingStyle = const Value.absent(),
                Value<String?> bowlingStyle = const Value.absent(),
                required int basePrice,
                Value<int> rowid = const Value.absent(),
              }) => PlayersCompanion.insert(
                id: id,
                name: name,
                photoUrl: photoUrl,
                role: role,
                battingStyle: battingStyle,
                bowlingStyle: bowlingStyle,
                basePrice: basePrice,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlayersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlayersTable,
      Player,
      $$PlayersTableFilterComposer,
      $$PlayersTableOrderingComposer,
      $$PlayersTableAnnotationComposer,
      $$PlayersTableCreateCompanionBuilder,
      $$PlayersTableUpdateCompanionBuilder,
      (Player, BaseReferences<_$AppDatabase, $PlayersTable, Player>),
      Player,
      PrefetchHooks Function()
    >;
typedef $$NotificationsTableCreateCompanionBuilder =
    NotificationsCompanion Function({
      Value<int> id,
      required String title,
      required String message,
      required DateTime receivedAt,
      Value<bool> isRead,
    });
typedef $$NotificationsTableUpdateCompanionBuilder =
    NotificationsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> message,
      Value<DateTime> receivedAt,
      Value<bool> isRead,
    });

class $$NotificationsTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationsTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);
}

class $$NotificationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationsTable,
          Notification,
          $$NotificationsTableFilterComposer,
          $$NotificationsTableOrderingComposer,
          $$NotificationsTableAnnotationComposer,
          $$NotificationsTableCreateCompanionBuilder,
          $$NotificationsTableUpdateCompanionBuilder,
          (
            Notification,
            BaseReferences<_$AppDatabase, $NotificationsTable, Notification>,
          ),
          Notification,
          PrefetchHooks Function()
        > {
  $$NotificationsTableTableManager(_$AppDatabase db, $NotificationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<DateTime> receivedAt = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
              }) => NotificationsCompanion(
                id: id,
                title: title,
                message: message,
                receivedAt: receivedAt,
                isRead: isRead,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String message,
                required DateTime receivedAt,
                Value<bool> isRead = const Value.absent(),
              }) => NotificationsCompanion.insert(
                id: id,
                title: title,
                message: message,
                receivedAt: receivedAt,
                isRead: isRead,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationsTable,
      Notification,
      $$NotificationsTableFilterComposer,
      $$NotificationsTableOrderingComposer,
      $$NotificationsTableAnnotationComposer,
      $$NotificationsTableCreateCompanionBuilder,
      $$NotificationsTableUpdateCompanionBuilder,
      (
        Notification,
        BaseReferences<_$AppDatabase, $NotificationsTable, Notification>,
      ),
      Notification,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LeaguesTableTableManager get leagues =>
      $$LeaguesTableTableManager(_db, _db.leagues);
  $$PlayersTableTableManager get players =>
      $$PlayersTableTableManager(_db, _db.players);
  $$NotificationsTableTableManager get notifications =>
      $$NotificationsTableTableManager(_db, _db.notifications);
}
