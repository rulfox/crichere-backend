// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'18ce5c8c4d8ddbfe5a7d819d8fb7d5aca76bf416';

@ProviderFor(leagueApi)
final leagueApiProvider = LeagueApiProvider._();

final class LeagueApiProvider
    extends $FunctionalProvider<LeagueApi, LeagueApi, LeagueApi>
    with $Provider<LeagueApi> {
  LeagueApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'leagueApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$leagueApiHash();

  @$internal
  @override
  $ProviderElement<LeagueApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LeagueApi create(Ref ref) {
    return leagueApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LeagueApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LeagueApi>(value),
    );
  }
}

String _$leagueApiHash() => r'a32233e5bf7943bbb5a2ba502d9f59bda2191d00';

@ProviderFor(leagueRepository)
final leagueRepositoryProvider = LeagueRepositoryProvider._();

final class LeagueRepositoryProvider
    extends
        $FunctionalProvider<
          LeagueRepository,
          LeagueRepository,
          LeagueRepository
        >
    with $Provider<LeagueRepository> {
  LeagueRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'leagueRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$leagueRepositoryHash();

  @$internal
  @override
  $ProviderElement<LeagueRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LeagueRepository create(Ref ref) {
    return leagueRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LeagueRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LeagueRepository>(value),
    );
  }
}

String _$leagueRepositoryHash() => r'5a2e0034dff60d85433062f65fba2b3604849139';

@ProviderFor(getLeaguesUseCase)
final getLeaguesUseCaseProvider = GetLeaguesUseCaseProvider._();

final class GetLeaguesUseCaseProvider
    extends
        $FunctionalProvider<
          GetLeaguesUseCase,
          GetLeaguesUseCase,
          GetLeaguesUseCase
        >
    with $Provider<GetLeaguesUseCase> {
  GetLeaguesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getLeaguesUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getLeaguesUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetLeaguesUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetLeaguesUseCase create(Ref ref) {
    return getLeaguesUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetLeaguesUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetLeaguesUseCase>(value),
    );
  }
}

String _$getLeaguesUseCaseHash() => r'ee39bd051b37e5c38782da033b1ec751dc587986';

@ProviderFor(getLeagueDetailUseCase)
final getLeagueDetailUseCaseProvider = GetLeagueDetailUseCaseProvider._();

final class GetLeagueDetailUseCaseProvider
    extends
        $FunctionalProvider<
          GetLeagueDetailUseCase,
          GetLeagueDetailUseCase,
          GetLeagueDetailUseCase
        >
    with $Provider<GetLeagueDetailUseCase> {
  GetLeagueDetailUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getLeagueDetailUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getLeagueDetailUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetLeagueDetailUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetLeagueDetailUseCase create(Ref ref) {
    return getLeagueDetailUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetLeagueDetailUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetLeagueDetailUseCase>(value),
    );
  }
}

String _$getLeagueDetailUseCaseHash() =>
    r'e0baa4b9706baa143abd729ed2cd16446dede65a';

@ProviderFor(createLeagueUseCase)
final createLeagueUseCaseProvider = CreateLeagueUseCaseProvider._();

final class CreateLeagueUseCaseProvider
    extends
        $FunctionalProvider<
          CreateLeagueUseCase,
          CreateLeagueUseCase,
          CreateLeagueUseCase
        >
    with $Provider<CreateLeagueUseCase> {
  CreateLeagueUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createLeagueUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createLeagueUseCaseHash();

  @$internal
  @override
  $ProviderElement<CreateLeagueUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CreateLeagueUseCase create(Ref ref) {
    return createLeagueUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateLeagueUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateLeagueUseCase>(value),
    );
  }
}

String _$createLeagueUseCaseHash() =>
    r'd86449311722e651c52c3aae14221f9c8902a2b5';

@ProviderFor(importPlayersUseCase)
final importPlayersUseCaseProvider = ImportPlayersUseCaseProvider._();

final class ImportPlayersUseCaseProvider
    extends
        $FunctionalProvider<
          ImportPlayersUseCase,
          ImportPlayersUseCase,
          ImportPlayersUseCase
        >
    with $Provider<ImportPlayersUseCase> {
  ImportPlayersUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'importPlayersUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$importPlayersUseCaseHash();

  @$internal
  @override
  $ProviderElement<ImportPlayersUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ImportPlayersUseCase create(Ref ref) {
    return importPlayersUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ImportPlayersUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ImportPlayersUseCase>(value),
    );
  }
}

String _$importPlayersUseCaseHash() =>
    r'9ec7be43c713bcc41a10ee6b03e5da5dfdc53d65';

@ProviderFor(leagues)
final leaguesProvider = LeaguesProvider._();

final class LeaguesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<domain.League>>,
          List<domain.League>,
          FutureOr<List<domain.League>>
        >
    with
        $FutureModifier<List<domain.League>>,
        $FutureProvider<List<domain.League>> {
  LeaguesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'leaguesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$leaguesHash();

  @$internal
  @override
  $FutureProviderElement<List<domain.League>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<domain.League>> create(Ref ref) {
    return leagues(ref);
  }
}

String _$leaguesHash() => r'9f30bdbde32f4b4f2ee13527cdb32d3966f137b3';

@ProviderFor(leagueFranchises)
final leagueFranchisesProvider = LeagueFranchisesFamily._();

final class LeagueFranchisesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Franchise>>,
          List<Franchise>,
          FutureOr<List<Franchise>>
        >
    with $FutureModifier<List<Franchise>>, $FutureProvider<List<Franchise>> {
  LeagueFranchisesProvider._({
    required LeagueFranchisesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'leagueFranchisesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$leagueFranchisesHash();

  @override
  String toString() {
    return r'leagueFranchisesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Franchise>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Franchise>> create(Ref ref) {
    final argument = this.argument as String;
    return leagueFranchises(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LeagueFranchisesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$leagueFranchisesHash() => r'8c8adb5d495015ac929ad01e8b858cbd0bc1caba';

final class LeagueFranchisesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Franchise>>, String> {
  LeagueFranchisesFamily._()
    : super(
        retry: null,
        name: r'leagueFranchisesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LeagueFranchisesProvider call(String leagueId) =>
      LeagueFranchisesProvider._(argument: leagueId, from: this);

  @override
  String toString() => r'leagueFranchisesProvider';
}

@ProviderFor(leaguePlayers)
final leaguePlayersProvider = LeaguePlayersFamily._();

final class LeaguePlayersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LeaguePlayer>>,
          List<LeaguePlayer>,
          FutureOr<List<LeaguePlayer>>
        >
    with
        $FutureModifier<List<LeaguePlayer>>,
        $FutureProvider<List<LeaguePlayer>> {
  LeaguePlayersProvider._({
    required LeaguePlayersFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'leaguePlayersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$leaguePlayersHash();

  @override
  String toString() {
    return r'leaguePlayersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<LeaguePlayer>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<LeaguePlayer>> create(Ref ref) {
    final argument = this.argument as String;
    return leaguePlayers(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LeaguePlayersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$leaguePlayersHash() => r'16f4f316a2afc0d9341a9579d84a70d156f98552';

final class LeaguePlayersFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<LeaguePlayer>>, String> {
  LeaguePlayersFamily._()
    : super(
        retry: null,
        name: r'leaguePlayersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LeaguePlayersProvider call(String leagueId) =>
      LeaguePlayersProvider._(argument: leagueId, from: this);

  @override
  String toString() => r'leaguePlayersProvider';
}
