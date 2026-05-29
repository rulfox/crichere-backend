// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(playerApi)
final playerApiProvider = PlayerApiProvider._();

final class PlayerApiProvider
    extends $FunctionalProvider<PlayerApi, PlayerApi, PlayerApi>
    with $Provider<PlayerApi> {
  PlayerApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playerApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playerApiHash();

  @$internal
  @override
  $ProviderElement<PlayerApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PlayerApi create(Ref ref) {
    return playerApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlayerApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlayerApi>(value),
    );
  }
}

String _$playerApiHash() => r'332416536356cc16df564a9afcd3ee3919e3ed2a';

@ProviderFor(storageApi)
final storageApiProvider = StorageApiProvider._();

final class StorageApiProvider
    extends $FunctionalProvider<StorageApi, StorageApi, StorageApi>
    with $Provider<StorageApi> {
  StorageApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'storageApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$storageApiHash();

  @$internal
  @override
  $ProviderElement<StorageApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StorageApi create(Ref ref) {
    return storageApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StorageApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StorageApi>(value),
    );
  }
}

String _$storageApiHash() => r'064650036011dd920024a47892ce6585450901af';

@ProviderFor(photoUploadService)
final photoUploadServiceProvider = PhotoUploadServiceProvider._();

final class PhotoUploadServiceProvider
    extends
        $FunctionalProvider<
          PhotoUploadService,
          PhotoUploadService,
          PhotoUploadService
        >
    with $Provider<PhotoUploadService> {
  PhotoUploadServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'photoUploadServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$photoUploadServiceHash();

  @$internal
  @override
  $ProviderElement<PhotoUploadService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PhotoUploadService create(Ref ref) {
    return photoUploadService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhotoUploadService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhotoUploadService>(value),
    );
  }
}

String _$photoUploadServiceHash() =>
    r'00acc57ce33003b717228893c41f5ab1c0db96a9';

/// Registers a user into a league as a player.

@ProviderFor(registerPlayer)
final registerPlayerProvider = RegisterPlayerFamily._();

/// Registers a user into a league as a player.

final class RegisterPlayerProvider
    extends
        $FunctionalProvider<
          AsyncValue<LeaguePlayer>,
          LeaguePlayer,
          FutureOr<LeaguePlayer>
        >
    with $FutureModifier<LeaguePlayer>, $FutureProvider<LeaguePlayer> {
  /// Registers a user into a league as a player.
  RegisterPlayerProvider._({
    required RegisterPlayerFamily super.from,
    required ({
      String leagueId,
      String userId,
      int? basePrice,
      String? category,
      String? tag,
    })
    super.argument,
  }) : super(
         retry: null,
         name: r'registerPlayerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$registerPlayerHash();

  @override
  String toString() {
    return r'registerPlayerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<LeaguePlayer> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LeaguePlayer> create(Ref ref) {
    final argument =
        this.argument
            as ({
              String leagueId,
              String userId,
              int? basePrice,
              String? category,
              String? tag,
            });
    return registerPlayer(
      ref,
      leagueId: argument.leagueId,
      userId: argument.userId,
      basePrice: argument.basePrice,
      category: argument.category,
      tag: argument.tag,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is RegisterPlayerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$registerPlayerHash() => r'67adeaf398ce8bc896fc7ef1be658a970c033776';

/// Registers a user into a league as a player.

final class RegisterPlayerFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<LeaguePlayer>,
          ({
            String leagueId,
            String userId,
            int? basePrice,
            String? category,
            String? tag,
          })
        > {
  RegisterPlayerFamily._()
    : super(
        retry: null,
        name: r'registerPlayerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Registers a user into a league as a player.

  RegisterPlayerProvider call({
    required String leagueId,
    required String userId,
    int? basePrice,
    String? category,
    String? tag,
  }) => RegisterPlayerProvider._(
    argument: (
      leagueId: leagueId,
      userId: userId,
      basePrice: basePrice,
      category: category,
      tag: tag,
    ),
    from: this,
  );

  @override
  String toString() => r'registerPlayerProvider';
}

@ProviderFor(playerById)
final playerByIdProvider = PlayerByIdFamily._();

final class PlayerByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<LeaguePlayer>,
          LeaguePlayer,
          FutureOr<LeaguePlayer>
        >
    with $FutureModifier<LeaguePlayer>, $FutureProvider<LeaguePlayer> {
  PlayerByIdProvider._({
    required PlayerByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'playerByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$playerByIdHash();

  @override
  String toString() {
    return r'playerByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<LeaguePlayer> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LeaguePlayer> create(Ref ref) {
    final argument = this.argument as String;
    return playerById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PlayerByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$playerByIdHash() => r'ce7210d158aec09629d9d6ce5fcda289cdafe26a';

final class PlayerByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<LeaguePlayer>, String> {
  PlayerByIdFamily._()
    : super(
        retry: null,
        name: r'playerByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PlayerByIdProvider call(String id) =>
      PlayerByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'playerByIdProvider';
}
