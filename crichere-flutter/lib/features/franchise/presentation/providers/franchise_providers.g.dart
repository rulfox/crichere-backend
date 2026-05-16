// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'franchise_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(franchiseApi)
const franchiseApiProvider = FranchiseApiProvider._();

final class FranchiseApiProvider
    extends $FunctionalProvider<FranchiseApi, FranchiseApi, FranchiseApi>
    with $Provider<FranchiseApi> {
  const FranchiseApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'franchiseApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$franchiseApiHash();

  @$internal
  @override
  $ProviderElement<FranchiseApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FranchiseApi create(Ref ref) {
    return franchiseApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FranchiseApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FranchiseApi>(value),
    );
  }
}

String _$franchiseApiHash() => r'b58267e47c932d0723bbf8eec9366b9fae9684d9';

@ProviderFor(franchiseRepository)
const franchiseRepositoryProvider = FranchiseRepositoryProvider._();

final class FranchiseRepositoryProvider
    extends
        $FunctionalProvider<
          FranchiseRepository,
          FranchiseRepository,
          FranchiseRepository
        >
    with $Provider<FranchiseRepository> {
  const FranchiseRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'franchiseRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$franchiseRepositoryHash();

  @$internal
  @override
  $ProviderElement<FranchiseRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FranchiseRepository create(Ref ref) {
    return franchiseRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FranchiseRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FranchiseRepository>(value),
    );
  }
}

String _$franchiseRepositoryHash() =>
    r'b02d29f3e2d0f4012c94196b57dfa61ef030a8ff';

@ProviderFor(squad)
const squadProvider = SquadFamily._();

final class SquadProvider
    extends
        $FunctionalProvider<
          AsyncValue<FranchiseSquad>,
          FranchiseSquad,
          FutureOr<FranchiseSquad>
        >
    with $FutureModifier<FranchiseSquad>, $FutureProvider<FranchiseSquad> {
  const SquadProvider._({
    required SquadFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'squadProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$squadHash();

  @override
  String toString() {
    return r'squadProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<FranchiseSquad> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<FranchiseSquad> create(Ref ref) {
    final argument = this.argument as String;
    return squad(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SquadProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$squadHash() => r'0195654ff99023c1e83db9d3cc14490a5ece7fe2';

final class SquadFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<FranchiseSquad>, String> {
  const SquadFamily._()
    : super(
        retry: null,
        name: r'squadProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SquadProvider call(String franchiseId) =>
      SquadProvider._(argument: franchiseId, from: this);

  @override
  String toString() => r'squadProvider';
}
