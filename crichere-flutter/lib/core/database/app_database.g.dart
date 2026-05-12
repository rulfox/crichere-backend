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
  static const VerificationMeta _formatMeta = const VerificationMeta('format');
  @override
  late final GeneratedColumn<String> format = GeneratedColumn<String>(
    'format',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rulesUrlMeta = const VerificationMeta(
    'rulesUrl',
  );
  @override
  late final GeneratedColumn<String> rulesUrl = GeneratedColumn<String>(
    'rules_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mustSellAllMeta = const VerificationMeta(
    'mustSellAll',
  );
  @override
  late final GeneratedColumn<bool> mustSellAll = GeneratedColumn<bool>(
    'must_sell_all',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("must_sell_all" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _playerOrderModeMeta = const VerificationMeta(
    'playerOrderMode',
  );
  @override
  late final GeneratedColumn<String> playerOrderMode = GeneratedColumn<String>(
    'player_order_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('RANDOM'),
  );
  static const VerificationMeta _waitingListModeMeta = const VerificationMeta(
    'waitingListMode',
  );
  @override
  late final GeneratedColumn<String> waitingListMode = GeneratedColumn<String>(
    'waiting_list_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('ADMIN_PICKS'),
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
  static const VerificationMeta _bannerUrlMeta = const VerificationMeta(
    'bannerUrl',
  );
  @override
  late final GeneratedColumn<String> bannerUrl = GeneratedColumn<String>(
    'banner_url',
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
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    format,
    rulesUrl,
    mustSellAll,
    playerOrderMode,
    waitingListMode,
    logoUrl,
    bannerUrl,
    status,
    auctionDate,
    createdBy,
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
    if (data.containsKey('format')) {
      context.handle(
        _formatMeta,
        format.isAcceptableOrUnknown(data['format']!, _formatMeta),
      );
    }
    if (data.containsKey('rules_url')) {
      context.handle(
        _rulesUrlMeta,
        rulesUrl.isAcceptableOrUnknown(data['rules_url']!, _rulesUrlMeta),
      );
    }
    if (data.containsKey('must_sell_all')) {
      context.handle(
        _mustSellAllMeta,
        mustSellAll.isAcceptableOrUnknown(
          data['must_sell_all']!,
          _mustSellAllMeta,
        ),
      );
    }
    if (data.containsKey('player_order_mode')) {
      context.handle(
        _playerOrderModeMeta,
        playerOrderMode.isAcceptableOrUnknown(
          data['player_order_mode']!,
          _playerOrderModeMeta,
        ),
      );
    }
    if (data.containsKey('waiting_list_mode')) {
      context.handle(
        _waitingListModeMeta,
        waitingListMode.isAcceptableOrUnknown(
          data['waiting_list_mode']!,
          _waitingListModeMeta,
        ),
      );
    }
    if (data.containsKey('logo_url')) {
      context.handle(
        _logoUrlMeta,
        logoUrl.isAcceptableOrUnknown(data['logo_url']!, _logoUrlMeta),
      );
    }
    if (data.containsKey('banner_url')) {
      context.handle(
        _bannerUrlMeta,
        bannerUrl.isAcceptableOrUnknown(data['banner_url']!, _bannerUrlMeta),
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
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    } else if (isInserting) {
      context.missing(_createdByMeta);
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
      format: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}format'],
      ),
      rulesUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rules_url'],
      ),
      mustSellAll: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}must_sell_all'],
      )!,
      playerOrderMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}player_order_mode'],
      )!,
      waitingListMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}waiting_list_mode'],
      )!,
      logoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_url'],
      ),
      bannerUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}banner_url'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      auctionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}auction_date'],
      ),
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      )!,
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
  final String? format;
  final String? rulesUrl;
  final bool mustSellAll;
  final String playerOrderMode;
  final String waitingListMode;
  final String? logoUrl;
  final String? bannerUrl;
  final String status;
  final DateTime? auctionDate;
  final String createdBy;
  const League({
    required this.id,
    required this.name,
    this.format,
    this.rulesUrl,
    required this.mustSellAll,
    required this.playerOrderMode,
    required this.waitingListMode,
    this.logoUrl,
    this.bannerUrl,
    required this.status,
    this.auctionDate,
    required this.createdBy,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || format != null) {
      map['format'] = Variable<String>(format);
    }
    if (!nullToAbsent || rulesUrl != null) {
      map['rules_url'] = Variable<String>(rulesUrl);
    }
    map['must_sell_all'] = Variable<bool>(mustSellAll);
    map['player_order_mode'] = Variable<String>(playerOrderMode);
    map['waiting_list_mode'] = Variable<String>(waitingListMode);
    if (!nullToAbsent || logoUrl != null) {
      map['logo_url'] = Variable<String>(logoUrl);
    }
    if (!nullToAbsent || bannerUrl != null) {
      map['banner_url'] = Variable<String>(bannerUrl);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || auctionDate != null) {
      map['auction_date'] = Variable<DateTime>(auctionDate);
    }
    map['created_by'] = Variable<String>(createdBy);
    return map;
  }

  LeaguesCompanion toCompanion(bool nullToAbsent) {
    return LeaguesCompanion(
      id: Value(id),
      name: Value(name),
      format: format == null && nullToAbsent
          ? const Value.absent()
          : Value(format),
      rulesUrl: rulesUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(rulesUrl),
      mustSellAll: Value(mustSellAll),
      playerOrderMode: Value(playerOrderMode),
      waitingListMode: Value(waitingListMode),
      logoUrl: logoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(logoUrl),
      bannerUrl: bannerUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(bannerUrl),
      status: Value(status),
      auctionDate: auctionDate == null && nullToAbsent
          ? const Value.absent()
          : Value(auctionDate),
      createdBy: Value(createdBy),
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
      format: serializer.fromJson<String?>(json['format']),
      rulesUrl: serializer.fromJson<String?>(json['rulesUrl']),
      mustSellAll: serializer.fromJson<bool>(json['mustSellAll']),
      playerOrderMode: serializer.fromJson<String>(json['playerOrderMode']),
      waitingListMode: serializer.fromJson<String>(json['waitingListMode']),
      logoUrl: serializer.fromJson<String?>(json['logoUrl']),
      bannerUrl: serializer.fromJson<String?>(json['bannerUrl']),
      status: serializer.fromJson<String>(json['status']),
      auctionDate: serializer.fromJson<DateTime?>(json['auctionDate']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'format': serializer.toJson<String?>(format),
      'rulesUrl': serializer.toJson<String?>(rulesUrl),
      'mustSellAll': serializer.toJson<bool>(mustSellAll),
      'playerOrderMode': serializer.toJson<String>(playerOrderMode),
      'waitingListMode': serializer.toJson<String>(waitingListMode),
      'logoUrl': serializer.toJson<String?>(logoUrl),
      'bannerUrl': serializer.toJson<String?>(bannerUrl),
      'status': serializer.toJson<String>(status),
      'auctionDate': serializer.toJson<DateTime?>(auctionDate),
      'createdBy': serializer.toJson<String>(createdBy),
    };
  }

  League copyWith({
    String? id,
    String? name,
    Value<String?> format = const Value.absent(),
    Value<String?> rulesUrl = const Value.absent(),
    bool? mustSellAll,
    String? playerOrderMode,
    String? waitingListMode,
    Value<String?> logoUrl = const Value.absent(),
    Value<String?> bannerUrl = const Value.absent(),
    String? status,
    Value<DateTime?> auctionDate = const Value.absent(),
    String? createdBy,
  }) => League(
    id: id ?? this.id,
    name: name ?? this.name,
    format: format.present ? format.value : this.format,
    rulesUrl: rulesUrl.present ? rulesUrl.value : this.rulesUrl,
    mustSellAll: mustSellAll ?? this.mustSellAll,
    playerOrderMode: playerOrderMode ?? this.playerOrderMode,
    waitingListMode: waitingListMode ?? this.waitingListMode,
    logoUrl: logoUrl.present ? logoUrl.value : this.logoUrl,
    bannerUrl: bannerUrl.present ? bannerUrl.value : this.bannerUrl,
    status: status ?? this.status,
    auctionDate: auctionDate.present ? auctionDate.value : this.auctionDate,
    createdBy: createdBy ?? this.createdBy,
  );
  League copyWithCompanion(LeaguesCompanion data) {
    return League(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      format: data.format.present ? data.format.value : this.format,
      rulesUrl: data.rulesUrl.present ? data.rulesUrl.value : this.rulesUrl,
      mustSellAll: data.mustSellAll.present
          ? data.mustSellAll.value
          : this.mustSellAll,
      playerOrderMode: data.playerOrderMode.present
          ? data.playerOrderMode.value
          : this.playerOrderMode,
      waitingListMode: data.waitingListMode.present
          ? data.waitingListMode.value
          : this.waitingListMode,
      logoUrl: data.logoUrl.present ? data.logoUrl.value : this.logoUrl,
      bannerUrl: data.bannerUrl.present ? data.bannerUrl.value : this.bannerUrl,
      status: data.status.present ? data.status.value : this.status,
      auctionDate: data.auctionDate.present
          ? data.auctionDate.value
          : this.auctionDate,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('League(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('format: $format, ')
          ..write('rulesUrl: $rulesUrl, ')
          ..write('mustSellAll: $mustSellAll, ')
          ..write('playerOrderMode: $playerOrderMode, ')
          ..write('waitingListMode: $waitingListMode, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('bannerUrl: $bannerUrl, ')
          ..write('status: $status, ')
          ..write('auctionDate: $auctionDate, ')
          ..write('createdBy: $createdBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    format,
    rulesUrl,
    mustSellAll,
    playerOrderMode,
    waitingListMode,
    logoUrl,
    bannerUrl,
    status,
    auctionDate,
    createdBy,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is League &&
          other.id == this.id &&
          other.name == this.name &&
          other.format == this.format &&
          other.rulesUrl == this.rulesUrl &&
          other.mustSellAll == this.mustSellAll &&
          other.playerOrderMode == this.playerOrderMode &&
          other.waitingListMode == this.waitingListMode &&
          other.logoUrl == this.logoUrl &&
          other.bannerUrl == this.bannerUrl &&
          other.status == this.status &&
          other.auctionDate == this.auctionDate &&
          other.createdBy == this.createdBy);
}

class LeaguesCompanion extends UpdateCompanion<League> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> format;
  final Value<String?> rulesUrl;
  final Value<bool> mustSellAll;
  final Value<String> playerOrderMode;
  final Value<String> waitingListMode;
  final Value<String?> logoUrl;
  final Value<String?> bannerUrl;
  final Value<String> status;
  final Value<DateTime?> auctionDate;
  final Value<String> createdBy;
  final Value<int> rowid;
  const LeaguesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.format = const Value.absent(),
    this.rulesUrl = const Value.absent(),
    this.mustSellAll = const Value.absent(),
    this.playerOrderMode = const Value.absent(),
    this.waitingListMode = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.bannerUrl = const Value.absent(),
    this.status = const Value.absent(),
    this.auctionDate = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LeaguesCompanion.insert({
    required String id,
    required String name,
    this.format = const Value.absent(),
    this.rulesUrl = const Value.absent(),
    this.mustSellAll = const Value.absent(),
    this.playerOrderMode = const Value.absent(),
    this.waitingListMode = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.bannerUrl = const Value.absent(),
    required String status,
    this.auctionDate = const Value.absent(),
    required String createdBy,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       status = Value(status),
       createdBy = Value(createdBy);
  static Insertable<League> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? format,
    Expression<String>? rulesUrl,
    Expression<bool>? mustSellAll,
    Expression<String>? playerOrderMode,
    Expression<String>? waitingListMode,
    Expression<String>? logoUrl,
    Expression<String>? bannerUrl,
    Expression<String>? status,
    Expression<DateTime>? auctionDate,
    Expression<String>? createdBy,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (format != null) 'format': format,
      if (rulesUrl != null) 'rules_url': rulesUrl,
      if (mustSellAll != null) 'must_sell_all': mustSellAll,
      if (playerOrderMode != null) 'player_order_mode': playerOrderMode,
      if (waitingListMode != null) 'waiting_list_mode': waitingListMode,
      if (logoUrl != null) 'logo_url': logoUrl,
      if (bannerUrl != null) 'banner_url': bannerUrl,
      if (status != null) 'status': status,
      if (auctionDate != null) 'auction_date': auctionDate,
      if (createdBy != null) 'created_by': createdBy,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LeaguesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? format,
    Value<String?>? rulesUrl,
    Value<bool>? mustSellAll,
    Value<String>? playerOrderMode,
    Value<String>? waitingListMode,
    Value<String?>? logoUrl,
    Value<String?>? bannerUrl,
    Value<String>? status,
    Value<DateTime?>? auctionDate,
    Value<String>? createdBy,
    Value<int>? rowid,
  }) {
    return LeaguesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      format: format ?? this.format,
      rulesUrl: rulesUrl ?? this.rulesUrl,
      mustSellAll: mustSellAll ?? this.mustSellAll,
      playerOrderMode: playerOrderMode ?? this.playerOrderMode,
      waitingListMode: waitingListMode ?? this.waitingListMode,
      logoUrl: logoUrl ?? this.logoUrl,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      status: status ?? this.status,
      auctionDate: auctionDate ?? this.auctionDate,
      createdBy: createdBy ?? this.createdBy,
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
    if (format.present) {
      map['format'] = Variable<String>(format.value);
    }
    if (rulesUrl.present) {
      map['rules_url'] = Variable<String>(rulesUrl.value);
    }
    if (mustSellAll.present) {
      map['must_sell_all'] = Variable<bool>(mustSellAll.value);
    }
    if (playerOrderMode.present) {
      map['player_order_mode'] = Variable<String>(playerOrderMode.value);
    }
    if (waitingListMode.present) {
      map['waiting_list_mode'] = Variable<String>(waitingListMode.value);
    }
    if (logoUrl.present) {
      map['logo_url'] = Variable<String>(logoUrl.value);
    }
    if (bannerUrl.present) {
      map['banner_url'] = Variable<String>(bannerUrl.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (auctionDate.present) {
      map['auction_date'] = Variable<DateTime>(auctionDate.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
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
          ..write('format: $format, ')
          ..write('rulesUrl: $rulesUrl, ')
          ..write('mustSellAll: $mustSellAll, ')
          ..write('playerOrderMode: $playerOrderMode, ')
          ..write('waitingListMode: $waitingListMode, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('bannerUrl: $bannerUrl, ')
          ..write('status: $status, ')
          ..write('auctionDate: $auctionDate, ')
          ..write('createdBy: $createdBy, ')
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

class $FranchisesTable extends Franchises
    with TableInfo<$FranchisesTable, Franchise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FranchisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _leagueIdMeta = const VerificationMeta(
    'leagueId',
  );
  @override
  late final GeneratedColumn<String> leagueId = GeneratedColumn<String>(
    'league_id',
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
  static const VerificationMeta _startingPurseMeta = const VerificationMeta(
    'startingPurse',
  );
  @override
  late final GeneratedColumn<int> startingPurse = GeneratedColumn<int>(
    'starting_purse',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentPurseMeta = const VerificationMeta(
    'currentPurse',
  );
  @override
  late final GeneratedColumn<int> currentPurse = GeneratedColumn<int>(
    'current_purse',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    leagueId,
    name,
    logoUrl,
    startingPurse,
    currentPurse,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'franchises';
  @override
  VerificationContext validateIntegrity(
    Insertable<Franchise> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('league_id')) {
      context.handle(
        _leagueIdMeta,
        leagueId.isAcceptableOrUnknown(data['league_id']!, _leagueIdMeta),
      );
    } else if (isInserting) {
      context.missing(_leagueIdMeta);
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
    if (data.containsKey('starting_purse')) {
      context.handle(
        _startingPurseMeta,
        startingPurse.isAcceptableOrUnknown(
          data['starting_purse']!,
          _startingPurseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startingPurseMeta);
    }
    if (data.containsKey('current_purse')) {
      context.handle(
        _currentPurseMeta,
        currentPurse.isAcceptableOrUnknown(
          data['current_purse']!,
          _currentPurseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentPurseMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Franchise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Franchise(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      leagueId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}league_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      logoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_url'],
      ),
      startingPurse: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}starting_purse'],
      )!,
      currentPurse: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_purse'],
      )!,
    );
  }

  @override
  $FranchisesTable createAlias(String alias) {
    return $FranchisesTable(attachedDatabase, alias);
  }
}

class Franchise extends DataClass implements Insertable<Franchise> {
  final String id;
  final String leagueId;
  final String name;
  final String? logoUrl;
  final int startingPurse;
  final int currentPurse;
  const Franchise({
    required this.id,
    required this.leagueId,
    required this.name,
    this.logoUrl,
    required this.startingPurse,
    required this.currentPurse,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['league_id'] = Variable<String>(leagueId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || logoUrl != null) {
      map['logo_url'] = Variable<String>(logoUrl);
    }
    map['starting_purse'] = Variable<int>(startingPurse);
    map['current_purse'] = Variable<int>(currentPurse);
    return map;
  }

  FranchisesCompanion toCompanion(bool nullToAbsent) {
    return FranchisesCompanion(
      id: Value(id),
      leagueId: Value(leagueId),
      name: Value(name),
      logoUrl: logoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(logoUrl),
      startingPurse: Value(startingPurse),
      currentPurse: Value(currentPurse),
    );
  }

  factory Franchise.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Franchise(
      id: serializer.fromJson<String>(json['id']),
      leagueId: serializer.fromJson<String>(json['leagueId']),
      name: serializer.fromJson<String>(json['name']),
      logoUrl: serializer.fromJson<String?>(json['logoUrl']),
      startingPurse: serializer.fromJson<int>(json['startingPurse']),
      currentPurse: serializer.fromJson<int>(json['currentPurse']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'leagueId': serializer.toJson<String>(leagueId),
      'name': serializer.toJson<String>(name),
      'logoUrl': serializer.toJson<String?>(logoUrl),
      'startingPurse': serializer.toJson<int>(startingPurse),
      'currentPurse': serializer.toJson<int>(currentPurse),
    };
  }

  Franchise copyWith({
    String? id,
    String? leagueId,
    String? name,
    Value<String?> logoUrl = const Value.absent(),
    int? startingPurse,
    int? currentPurse,
  }) => Franchise(
    id: id ?? this.id,
    leagueId: leagueId ?? this.leagueId,
    name: name ?? this.name,
    logoUrl: logoUrl.present ? logoUrl.value : this.logoUrl,
    startingPurse: startingPurse ?? this.startingPurse,
    currentPurse: currentPurse ?? this.currentPurse,
  );
  Franchise copyWithCompanion(FranchisesCompanion data) {
    return Franchise(
      id: data.id.present ? data.id.value : this.id,
      leagueId: data.leagueId.present ? data.leagueId.value : this.leagueId,
      name: data.name.present ? data.name.value : this.name,
      logoUrl: data.logoUrl.present ? data.logoUrl.value : this.logoUrl,
      startingPurse: data.startingPurse.present
          ? data.startingPurse.value
          : this.startingPurse,
      currentPurse: data.currentPurse.present
          ? data.currentPurse.value
          : this.currentPurse,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Franchise(')
          ..write('id: $id, ')
          ..write('leagueId: $leagueId, ')
          ..write('name: $name, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('startingPurse: $startingPurse, ')
          ..write('currentPurse: $currentPurse')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, leagueId, name, logoUrl, startingPurse, currentPurse);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Franchise &&
          other.id == this.id &&
          other.leagueId == this.leagueId &&
          other.name == this.name &&
          other.logoUrl == this.logoUrl &&
          other.startingPurse == this.startingPurse &&
          other.currentPurse == this.currentPurse);
}

class FranchisesCompanion extends UpdateCompanion<Franchise> {
  final Value<String> id;
  final Value<String> leagueId;
  final Value<String> name;
  final Value<String?> logoUrl;
  final Value<int> startingPurse;
  final Value<int> currentPurse;
  final Value<int> rowid;
  const FranchisesCompanion({
    this.id = const Value.absent(),
    this.leagueId = const Value.absent(),
    this.name = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.startingPurse = const Value.absent(),
    this.currentPurse = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FranchisesCompanion.insert({
    required String id,
    required String leagueId,
    required String name,
    this.logoUrl = const Value.absent(),
    required int startingPurse,
    required int currentPurse,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       leagueId = Value(leagueId),
       name = Value(name),
       startingPurse = Value(startingPurse),
       currentPurse = Value(currentPurse);
  static Insertable<Franchise> custom({
    Expression<String>? id,
    Expression<String>? leagueId,
    Expression<String>? name,
    Expression<String>? logoUrl,
    Expression<int>? startingPurse,
    Expression<int>? currentPurse,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (leagueId != null) 'league_id': leagueId,
      if (name != null) 'name': name,
      if (logoUrl != null) 'logo_url': logoUrl,
      if (startingPurse != null) 'starting_purse': startingPurse,
      if (currentPurse != null) 'current_purse': currentPurse,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FranchisesCompanion copyWith({
    Value<String>? id,
    Value<String>? leagueId,
    Value<String>? name,
    Value<String?>? logoUrl,
    Value<int>? startingPurse,
    Value<int>? currentPurse,
    Value<int>? rowid,
  }) {
    return FranchisesCompanion(
      id: id ?? this.id,
      leagueId: leagueId ?? this.leagueId,
      name: name ?? this.name,
      logoUrl: logoUrl ?? this.logoUrl,
      startingPurse: startingPurse ?? this.startingPurse,
      currentPurse: currentPurse ?? this.currentPurse,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (leagueId.present) {
      map['league_id'] = Variable<String>(leagueId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (logoUrl.present) {
      map['logo_url'] = Variable<String>(logoUrl.value);
    }
    if (startingPurse.present) {
      map['starting_purse'] = Variable<int>(startingPurse.value);
    }
    if (currentPurse.present) {
      map['current_purse'] = Variable<int>(currentPurse.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FranchisesCompanion(')
          ..write('id: $id, ')
          ..write('leagueId: $leagueId, ')
          ..write('name: $name, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('startingPurse: $startingPurse, ')
          ..write('currentPurse: $currentPurse, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LeaguePlayersTable extends LeaguePlayers
    with TableInfo<$LeaguePlayersTable, LeaguePlayer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LeaguePlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _leagueIdMeta = const VerificationMeta(
    'leagueId',
  );
  @override
  late final GeneratedColumn<String> leagueId = GeneratedColumn<String>(
    'league_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<String> playerId = GeneratedColumn<String>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _basePriceOverrideMeta = const VerificationMeta(
    'basePriceOverride',
  );
  @override
  late final GeneratedColumn<int> basePriceOverride = GeneratedColumn<int>(
    'base_price_override',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _finalPriceMeta = const VerificationMeta(
    'finalPrice',
  );
  @override
  late final GeneratedColumn<int> finalPrice = GeneratedColumn<int>(
    'final_price',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _franchiseIdMeta = const VerificationMeta(
    'franchiseId',
  );
  @override
  late final GeneratedColumn<String> franchiseId = GeneratedColumn<String>(
    'franchise_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    leagueId,
    playerId,
    status,
    basePriceOverride,
    finalPrice,
    franchiseId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'league_players';
  @override
  VerificationContext validateIntegrity(
    Insertable<LeaguePlayer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('league_id')) {
      context.handle(
        _leagueIdMeta,
        leagueId.isAcceptableOrUnknown(data['league_id']!, _leagueIdMeta),
      );
    } else if (isInserting) {
      context.missing(_leagueIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('base_price_override')) {
      context.handle(
        _basePriceOverrideMeta,
        basePriceOverride.isAcceptableOrUnknown(
          data['base_price_override']!,
          _basePriceOverrideMeta,
        ),
      );
    }
    if (data.containsKey('final_price')) {
      context.handle(
        _finalPriceMeta,
        finalPrice.isAcceptableOrUnknown(data['final_price']!, _finalPriceMeta),
      );
    }
    if (data.containsKey('franchise_id')) {
      context.handle(
        _franchiseIdMeta,
        franchiseId.isAcceptableOrUnknown(
          data['franchise_id']!,
          _franchiseIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LeaguePlayer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LeaguePlayer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      leagueId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}league_id'],
      )!,
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}player_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      basePriceOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_price_override'],
      ),
      finalPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}final_price'],
      ),
      franchiseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}franchise_id'],
      ),
    );
  }

  @override
  $LeaguePlayersTable createAlias(String alias) {
    return $LeaguePlayersTable(attachedDatabase, alias);
  }
}

class LeaguePlayer extends DataClass implements Insertable<LeaguePlayer> {
  final String id;
  final String leagueId;
  final String playerId;
  final String status;
  final int? basePriceOverride;
  final int? finalPrice;
  final String? franchiseId;
  const LeaguePlayer({
    required this.id,
    required this.leagueId,
    required this.playerId,
    required this.status,
    this.basePriceOverride,
    this.finalPrice,
    this.franchiseId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['league_id'] = Variable<String>(leagueId);
    map['player_id'] = Variable<String>(playerId);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || basePriceOverride != null) {
      map['base_price_override'] = Variable<int>(basePriceOverride);
    }
    if (!nullToAbsent || finalPrice != null) {
      map['final_price'] = Variable<int>(finalPrice);
    }
    if (!nullToAbsent || franchiseId != null) {
      map['franchise_id'] = Variable<String>(franchiseId);
    }
    return map;
  }

  LeaguePlayersCompanion toCompanion(bool nullToAbsent) {
    return LeaguePlayersCompanion(
      id: Value(id),
      leagueId: Value(leagueId),
      playerId: Value(playerId),
      status: Value(status),
      basePriceOverride: basePriceOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(basePriceOverride),
      finalPrice: finalPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(finalPrice),
      franchiseId: franchiseId == null && nullToAbsent
          ? const Value.absent()
          : Value(franchiseId),
    );
  }

  factory LeaguePlayer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LeaguePlayer(
      id: serializer.fromJson<String>(json['id']),
      leagueId: serializer.fromJson<String>(json['leagueId']),
      playerId: serializer.fromJson<String>(json['playerId']),
      status: serializer.fromJson<String>(json['status']),
      basePriceOverride: serializer.fromJson<int?>(json['basePriceOverride']),
      finalPrice: serializer.fromJson<int?>(json['finalPrice']),
      franchiseId: serializer.fromJson<String?>(json['franchiseId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'leagueId': serializer.toJson<String>(leagueId),
      'playerId': serializer.toJson<String>(playerId),
      'status': serializer.toJson<String>(status),
      'basePriceOverride': serializer.toJson<int?>(basePriceOverride),
      'finalPrice': serializer.toJson<int?>(finalPrice),
      'franchiseId': serializer.toJson<String?>(franchiseId),
    };
  }

  LeaguePlayer copyWith({
    String? id,
    String? leagueId,
    String? playerId,
    String? status,
    Value<int?> basePriceOverride = const Value.absent(),
    Value<int?> finalPrice = const Value.absent(),
    Value<String?> franchiseId = const Value.absent(),
  }) => LeaguePlayer(
    id: id ?? this.id,
    leagueId: leagueId ?? this.leagueId,
    playerId: playerId ?? this.playerId,
    status: status ?? this.status,
    basePriceOverride: basePriceOverride.present
        ? basePriceOverride.value
        : this.basePriceOverride,
    finalPrice: finalPrice.present ? finalPrice.value : this.finalPrice,
    franchiseId: franchiseId.present ? franchiseId.value : this.franchiseId,
  );
  LeaguePlayer copyWithCompanion(LeaguePlayersCompanion data) {
    return LeaguePlayer(
      id: data.id.present ? data.id.value : this.id,
      leagueId: data.leagueId.present ? data.leagueId.value : this.leagueId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      status: data.status.present ? data.status.value : this.status,
      basePriceOverride: data.basePriceOverride.present
          ? data.basePriceOverride.value
          : this.basePriceOverride,
      finalPrice: data.finalPrice.present
          ? data.finalPrice.value
          : this.finalPrice,
      franchiseId: data.franchiseId.present
          ? data.franchiseId.value
          : this.franchiseId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LeaguePlayer(')
          ..write('id: $id, ')
          ..write('leagueId: $leagueId, ')
          ..write('playerId: $playerId, ')
          ..write('status: $status, ')
          ..write('basePriceOverride: $basePriceOverride, ')
          ..write('finalPrice: $finalPrice, ')
          ..write('franchiseId: $franchiseId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    leagueId,
    playerId,
    status,
    basePriceOverride,
    finalPrice,
    franchiseId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LeaguePlayer &&
          other.id == this.id &&
          other.leagueId == this.leagueId &&
          other.playerId == this.playerId &&
          other.status == this.status &&
          other.basePriceOverride == this.basePriceOverride &&
          other.finalPrice == this.finalPrice &&
          other.franchiseId == this.franchiseId);
}

class LeaguePlayersCompanion extends UpdateCompanion<LeaguePlayer> {
  final Value<String> id;
  final Value<String> leagueId;
  final Value<String> playerId;
  final Value<String> status;
  final Value<int?> basePriceOverride;
  final Value<int?> finalPrice;
  final Value<String?> franchiseId;
  final Value<int> rowid;
  const LeaguePlayersCompanion({
    this.id = const Value.absent(),
    this.leagueId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.status = const Value.absent(),
    this.basePriceOverride = const Value.absent(),
    this.finalPrice = const Value.absent(),
    this.franchiseId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LeaguePlayersCompanion.insert({
    required String id,
    required String leagueId,
    required String playerId,
    required String status,
    this.basePriceOverride = const Value.absent(),
    this.finalPrice = const Value.absent(),
    this.franchiseId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       leagueId = Value(leagueId),
       playerId = Value(playerId),
       status = Value(status);
  static Insertable<LeaguePlayer> custom({
    Expression<String>? id,
    Expression<String>? leagueId,
    Expression<String>? playerId,
    Expression<String>? status,
    Expression<int>? basePriceOverride,
    Expression<int>? finalPrice,
    Expression<String>? franchiseId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (leagueId != null) 'league_id': leagueId,
      if (playerId != null) 'player_id': playerId,
      if (status != null) 'status': status,
      if (basePriceOverride != null) 'base_price_override': basePriceOverride,
      if (finalPrice != null) 'final_price': finalPrice,
      if (franchiseId != null) 'franchise_id': franchiseId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LeaguePlayersCompanion copyWith({
    Value<String>? id,
    Value<String>? leagueId,
    Value<String>? playerId,
    Value<String>? status,
    Value<int?>? basePriceOverride,
    Value<int?>? finalPrice,
    Value<String?>? franchiseId,
    Value<int>? rowid,
  }) {
    return LeaguePlayersCompanion(
      id: id ?? this.id,
      leagueId: leagueId ?? this.leagueId,
      playerId: playerId ?? this.playerId,
      status: status ?? this.status,
      basePriceOverride: basePriceOverride ?? this.basePriceOverride,
      finalPrice: finalPrice ?? this.finalPrice,
      franchiseId: franchiseId ?? this.franchiseId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (leagueId.present) {
      map['league_id'] = Variable<String>(leagueId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<String>(playerId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (basePriceOverride.present) {
      map['base_price_override'] = Variable<int>(basePriceOverride.value);
    }
    if (finalPrice.present) {
      map['final_price'] = Variable<int>(finalPrice.value);
    }
    if (franchiseId.present) {
      map['franchise_id'] = Variable<String>(franchiseId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LeaguePlayersCompanion(')
          ..write('id: $id, ')
          ..write('leagueId: $leagueId, ')
          ..write('playerId: $playerId, ')
          ..write('status: $status, ')
          ..write('basePriceOverride: $basePriceOverride, ')
          ..write('finalPrice: $finalPrice, ')
          ..write('franchiseId: $franchiseId, ')
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
  late final $FranchisesTable franchises = $FranchisesTable(this);
  late final $LeaguePlayersTable leaguePlayers = $LeaguePlayersTable(this);
  late final $NotificationsTable notifications = $NotificationsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    leagues,
    players,
    franchises,
    leaguePlayers,
    notifications,
  ];
}

typedef $$LeaguesTableCreateCompanionBuilder =
    LeaguesCompanion Function({
      required String id,
      required String name,
      Value<String?> format,
      Value<String?> rulesUrl,
      Value<bool> mustSellAll,
      Value<String> playerOrderMode,
      Value<String> waitingListMode,
      Value<String?> logoUrl,
      Value<String?> bannerUrl,
      required String status,
      Value<DateTime?> auctionDate,
      required String createdBy,
      Value<int> rowid,
    });
typedef $$LeaguesTableUpdateCompanionBuilder =
    LeaguesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> format,
      Value<String?> rulesUrl,
      Value<bool> mustSellAll,
      Value<String> playerOrderMode,
      Value<String> waitingListMode,
      Value<String?> logoUrl,
      Value<String?> bannerUrl,
      Value<String> status,
      Value<DateTime?> auctionDate,
      Value<String> createdBy,
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

  ColumnFilters<String> get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rulesUrl => $composableBuilder(
    column: $table.rulesUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get mustSellAll => $composableBuilder(
    column: $table.mustSellAll,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get playerOrderMode => $composableBuilder(
    column: $table.playerOrderMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get waitingListMode => $composableBuilder(
    column: $table.waitingListMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logoUrl => $composableBuilder(
    column: $table.logoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bannerUrl => $composableBuilder(
    column: $table.bannerUrl,
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

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
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

  ColumnOrderings<String> get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rulesUrl => $composableBuilder(
    column: $table.rulesUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get mustSellAll => $composableBuilder(
    column: $table.mustSellAll,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get playerOrderMode => $composableBuilder(
    column: $table.playerOrderMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get waitingListMode => $composableBuilder(
    column: $table.waitingListMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoUrl => $composableBuilder(
    column: $table.logoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bannerUrl => $composableBuilder(
    column: $table.bannerUrl,
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

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
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

  GeneratedColumn<String> get format =>
      $composableBuilder(column: $table.format, builder: (column) => column);

  GeneratedColumn<String> get rulesUrl =>
      $composableBuilder(column: $table.rulesUrl, builder: (column) => column);

  GeneratedColumn<bool> get mustSellAll => $composableBuilder(
    column: $table.mustSellAll,
    builder: (column) => column,
  );

  GeneratedColumn<String> get playerOrderMode => $composableBuilder(
    column: $table.playerOrderMode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get waitingListMode => $composableBuilder(
    column: $table.waitingListMode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get logoUrl =>
      $composableBuilder(column: $table.logoUrl, builder: (column) => column);

  GeneratedColumn<String> get bannerUrl =>
      $composableBuilder(column: $table.bannerUrl, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get auctionDate => $composableBuilder(
    column: $table.auctionDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);
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
                Value<String?> format = const Value.absent(),
                Value<String?> rulesUrl = const Value.absent(),
                Value<bool> mustSellAll = const Value.absent(),
                Value<String> playerOrderMode = const Value.absent(),
                Value<String> waitingListMode = const Value.absent(),
                Value<String?> logoUrl = const Value.absent(),
                Value<String?> bannerUrl = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> auctionDate = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LeaguesCompanion(
                id: id,
                name: name,
                format: format,
                rulesUrl: rulesUrl,
                mustSellAll: mustSellAll,
                playerOrderMode: playerOrderMode,
                waitingListMode: waitingListMode,
                logoUrl: logoUrl,
                bannerUrl: bannerUrl,
                status: status,
                auctionDate: auctionDate,
                createdBy: createdBy,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> format = const Value.absent(),
                Value<String?> rulesUrl = const Value.absent(),
                Value<bool> mustSellAll = const Value.absent(),
                Value<String> playerOrderMode = const Value.absent(),
                Value<String> waitingListMode = const Value.absent(),
                Value<String?> logoUrl = const Value.absent(),
                Value<String?> bannerUrl = const Value.absent(),
                required String status,
                Value<DateTime?> auctionDate = const Value.absent(),
                required String createdBy,
                Value<int> rowid = const Value.absent(),
              }) => LeaguesCompanion.insert(
                id: id,
                name: name,
                format: format,
                rulesUrl: rulesUrl,
                mustSellAll: mustSellAll,
                playerOrderMode: playerOrderMode,
                waitingListMode: waitingListMode,
                logoUrl: logoUrl,
                bannerUrl: bannerUrl,
                status: status,
                auctionDate: auctionDate,
                createdBy: createdBy,
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
typedef $$FranchisesTableCreateCompanionBuilder =
    FranchisesCompanion Function({
      required String id,
      required String leagueId,
      required String name,
      Value<String?> logoUrl,
      required int startingPurse,
      required int currentPurse,
      Value<int> rowid,
    });
typedef $$FranchisesTableUpdateCompanionBuilder =
    FranchisesCompanion Function({
      Value<String> id,
      Value<String> leagueId,
      Value<String> name,
      Value<String?> logoUrl,
      Value<int> startingPurse,
      Value<int> currentPurse,
      Value<int> rowid,
    });

class $$FranchisesTableFilterComposer
    extends Composer<_$AppDatabase, $FranchisesTable> {
  $$FranchisesTableFilterComposer({
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

  ColumnFilters<String> get leagueId => $composableBuilder(
    column: $table.leagueId,
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

  ColumnFilters<int> get startingPurse => $composableBuilder(
    column: $table.startingPurse,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentPurse => $composableBuilder(
    column: $table.currentPurse,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FranchisesTableOrderingComposer
    extends Composer<_$AppDatabase, $FranchisesTable> {
  $$FranchisesTableOrderingComposer({
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

  ColumnOrderings<String> get leagueId => $composableBuilder(
    column: $table.leagueId,
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

  ColumnOrderings<int> get startingPurse => $composableBuilder(
    column: $table.startingPurse,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentPurse => $composableBuilder(
    column: $table.currentPurse,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FranchisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FranchisesTable> {
  $$FranchisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get leagueId =>
      $composableBuilder(column: $table.leagueId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get logoUrl =>
      $composableBuilder(column: $table.logoUrl, builder: (column) => column);

  GeneratedColumn<int> get startingPurse => $composableBuilder(
    column: $table.startingPurse,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentPurse => $composableBuilder(
    column: $table.currentPurse,
    builder: (column) => column,
  );
}

class $$FranchisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FranchisesTable,
          Franchise,
          $$FranchisesTableFilterComposer,
          $$FranchisesTableOrderingComposer,
          $$FranchisesTableAnnotationComposer,
          $$FranchisesTableCreateCompanionBuilder,
          $$FranchisesTableUpdateCompanionBuilder,
          (
            Franchise,
            BaseReferences<_$AppDatabase, $FranchisesTable, Franchise>,
          ),
          Franchise,
          PrefetchHooks Function()
        > {
  $$FranchisesTableTableManager(_$AppDatabase db, $FranchisesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FranchisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FranchisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FranchisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> leagueId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> logoUrl = const Value.absent(),
                Value<int> startingPurse = const Value.absent(),
                Value<int> currentPurse = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FranchisesCompanion(
                id: id,
                leagueId: leagueId,
                name: name,
                logoUrl: logoUrl,
                startingPurse: startingPurse,
                currentPurse: currentPurse,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String leagueId,
                required String name,
                Value<String?> logoUrl = const Value.absent(),
                required int startingPurse,
                required int currentPurse,
                Value<int> rowid = const Value.absent(),
              }) => FranchisesCompanion.insert(
                id: id,
                leagueId: leagueId,
                name: name,
                logoUrl: logoUrl,
                startingPurse: startingPurse,
                currentPurse: currentPurse,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FranchisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FranchisesTable,
      Franchise,
      $$FranchisesTableFilterComposer,
      $$FranchisesTableOrderingComposer,
      $$FranchisesTableAnnotationComposer,
      $$FranchisesTableCreateCompanionBuilder,
      $$FranchisesTableUpdateCompanionBuilder,
      (Franchise, BaseReferences<_$AppDatabase, $FranchisesTable, Franchise>),
      Franchise,
      PrefetchHooks Function()
    >;
typedef $$LeaguePlayersTableCreateCompanionBuilder =
    LeaguePlayersCompanion Function({
      required String id,
      required String leagueId,
      required String playerId,
      required String status,
      Value<int?> basePriceOverride,
      Value<int?> finalPrice,
      Value<String?> franchiseId,
      Value<int> rowid,
    });
typedef $$LeaguePlayersTableUpdateCompanionBuilder =
    LeaguePlayersCompanion Function({
      Value<String> id,
      Value<String> leagueId,
      Value<String> playerId,
      Value<String> status,
      Value<int?> basePriceOverride,
      Value<int?> finalPrice,
      Value<String?> franchiseId,
      Value<int> rowid,
    });

class $$LeaguePlayersTableFilterComposer
    extends Composer<_$AppDatabase, $LeaguePlayersTable> {
  $$LeaguePlayersTableFilterComposer({
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

  ColumnFilters<String> get leagueId => $composableBuilder(
    column: $table.leagueId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get playerId => $composableBuilder(
    column: $table.playerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get basePriceOverride => $composableBuilder(
    column: $table.basePriceOverride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get finalPrice => $composableBuilder(
    column: $table.finalPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get franchiseId => $composableBuilder(
    column: $table.franchiseId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LeaguePlayersTableOrderingComposer
    extends Composer<_$AppDatabase, $LeaguePlayersTable> {
  $$LeaguePlayersTableOrderingComposer({
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

  ColumnOrderings<String> get leagueId => $composableBuilder(
    column: $table.leagueId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get playerId => $composableBuilder(
    column: $table.playerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get basePriceOverride => $composableBuilder(
    column: $table.basePriceOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get finalPrice => $composableBuilder(
    column: $table.finalPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get franchiseId => $composableBuilder(
    column: $table.franchiseId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LeaguePlayersTableAnnotationComposer
    extends Composer<_$AppDatabase, $LeaguePlayersTable> {
  $$LeaguePlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get leagueId =>
      $composableBuilder(column: $table.leagueId, builder: (column) => column);

  GeneratedColumn<String> get playerId =>
      $composableBuilder(column: $table.playerId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get basePriceOverride => $composableBuilder(
    column: $table.basePriceOverride,
    builder: (column) => column,
  );

  GeneratedColumn<int> get finalPrice => $composableBuilder(
    column: $table.finalPrice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get franchiseId => $composableBuilder(
    column: $table.franchiseId,
    builder: (column) => column,
  );
}

class $$LeaguePlayersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LeaguePlayersTable,
          LeaguePlayer,
          $$LeaguePlayersTableFilterComposer,
          $$LeaguePlayersTableOrderingComposer,
          $$LeaguePlayersTableAnnotationComposer,
          $$LeaguePlayersTableCreateCompanionBuilder,
          $$LeaguePlayersTableUpdateCompanionBuilder,
          (
            LeaguePlayer,
            BaseReferences<_$AppDatabase, $LeaguePlayersTable, LeaguePlayer>,
          ),
          LeaguePlayer,
          PrefetchHooks Function()
        > {
  $$LeaguePlayersTableTableManager(_$AppDatabase db, $LeaguePlayersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LeaguePlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LeaguePlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LeaguePlayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> leagueId = const Value.absent(),
                Value<String> playerId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int?> basePriceOverride = const Value.absent(),
                Value<int?> finalPrice = const Value.absent(),
                Value<String?> franchiseId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LeaguePlayersCompanion(
                id: id,
                leagueId: leagueId,
                playerId: playerId,
                status: status,
                basePriceOverride: basePriceOverride,
                finalPrice: finalPrice,
                franchiseId: franchiseId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String leagueId,
                required String playerId,
                required String status,
                Value<int?> basePriceOverride = const Value.absent(),
                Value<int?> finalPrice = const Value.absent(),
                Value<String?> franchiseId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LeaguePlayersCompanion.insert(
                id: id,
                leagueId: leagueId,
                playerId: playerId,
                status: status,
                basePriceOverride: basePriceOverride,
                finalPrice: finalPrice,
                franchiseId: franchiseId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LeaguePlayersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LeaguePlayersTable,
      LeaguePlayer,
      $$LeaguePlayersTableFilterComposer,
      $$LeaguePlayersTableOrderingComposer,
      $$LeaguePlayersTableAnnotationComposer,
      $$LeaguePlayersTableCreateCompanionBuilder,
      $$LeaguePlayersTableUpdateCompanionBuilder,
      (
        LeaguePlayer,
        BaseReferences<_$AppDatabase, $LeaguePlayersTable, LeaguePlayer>,
      ),
      LeaguePlayer,
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
  $$FranchisesTableTableManager get franchises =>
      $$FranchisesTableTableManager(_db, _db.franchises);
  $$LeaguePlayersTableTableManager get leaguePlayers =>
      $$LeaguePlayersTableTableManager(_db, _db.leaguePlayers);
  $$NotificationsTableTableManager get notifications =>
      $$NotificationsTableTableManager(_db, _db.notifications);
}
