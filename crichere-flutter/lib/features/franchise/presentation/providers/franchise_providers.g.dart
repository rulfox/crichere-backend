// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'franchise_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(franchiseApi)
final franchiseApiProvider = FranchiseApiProvider._();

final class FranchiseApiProvider
    extends $FunctionalProvider<FranchiseApi, FranchiseApi, FranchiseApi>
    with $Provider<FranchiseApi> {
  FranchiseApiProvider._()
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
final franchiseRepositoryProvider = FranchiseRepositoryProvider._();

final class FranchiseRepositoryProvider
    extends
        $FunctionalProvider<
          FranchiseRepository,
          FranchiseRepository,
          FranchiseRepository
        >
    with $Provider<FranchiseRepository> {
  FranchiseRepositoryProvider._()
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

@ProviderFor(franchise)
final franchiseProvider = FranchiseFamily._();

final class FranchiseProvider
    extends
        $FunctionalProvider<
          AsyncValue<Franchise>,
          Franchise,
          FutureOr<Franchise>
        >
    with $FutureModifier<Franchise>, $FutureProvider<Franchise> {
  FranchiseProvider._({
    required FranchiseFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'franchiseProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$franchiseHash();

  @override
  String toString() {
    return r'franchiseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Franchise> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Franchise> create(Ref ref) {
    final argument = this.argument as String;
    return franchise(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FranchiseProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$franchiseHash() => r'7ad3caffb8ab365ed849b1e8cc9c2bfbc92dc0d3';

final class FranchiseFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Franchise>, String> {
  FranchiseFamily._()
    : super(
        retry: null,
        name: r'franchiseProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FranchiseProvider call(String id) =>
      FranchiseProvider._(argument: id, from: this);

  @override
  String toString() => r'franchiseProvider';
}

@ProviderFor(squad)
final squadProvider = SquadFamily._();

final class SquadProvider
    extends
        $FunctionalProvider<
          AsyncValue<FranchiseSquadResponse>,
          FranchiseSquadResponse,
          FutureOr<FranchiseSquadResponse>
        >
    with
        $FutureModifier<FranchiseSquadResponse>,
        $FutureProvider<FranchiseSquadResponse> {
  SquadProvider._({
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
  $FutureProviderElement<FranchiseSquadResponse> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<FranchiseSquadResponse> create(Ref ref) {
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

String _$squadHash() => r'1218d89fea8ffb8aa6775c1499b396191c5c3c51';

final class SquadFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<FranchiseSquadResponse>, String> {
  SquadFamily._()
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
