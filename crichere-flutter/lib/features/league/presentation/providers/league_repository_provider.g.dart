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

String _$leaguesHash() => r'417322b34d2b047e84f3c78653f2f84ee322ca26';
