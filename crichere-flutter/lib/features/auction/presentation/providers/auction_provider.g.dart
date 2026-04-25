// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auction_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(auctionEvents)
final auctionEventsProvider = AuctionEventsFamily._();

final class AuctionEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<AuctionEvent>,
          AuctionEvent,
          Stream<AuctionEvent>
        >
    with $FutureModifier<AuctionEvent>, $StreamProvider<AuctionEvent> {
  AuctionEventsProvider._({
    required AuctionEventsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'auctionEventsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$auctionEventsHash();

  @override
  String toString() {
    return r'auctionEventsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<AuctionEvent> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<AuctionEvent> create(Ref ref) {
    final argument = this.argument as String;
    return auctionEvents(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AuctionEventsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$auctionEventsHash() => r'aebebb693f2c9f2f6beebb2c31f7d0ebef9d76ff';

final class AuctionEventsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<AuctionEvent>, String> {
  AuctionEventsFamily._()
    : super(
        retry: null,
        name: r'auctionEventsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AuctionEventsProvider call(String auctionId) =>
      AuctionEventsProvider._(argument: auctionId, from: this);

  @override
  String toString() => r'auctionEventsProvider';
}

@ProviderFor(auctionApi)
final auctionApiProvider = AuctionApiProvider._();

final class AuctionApiProvider
    extends $FunctionalProvider<AuctionApi, AuctionApi, AuctionApi>
    with $Provider<AuctionApi> {
  AuctionApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'auctionApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$auctionApiHash();

  @$internal
  @override
  $ProviderElement<AuctionApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuctionApi create(Ref ref) {
    return auctionApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuctionApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuctionApi>(value),
    );
  }
}

String _$auctionApiHash() => r'80d6f6eafabc8c1e9bd67bb70ec97ed38bbed621';

@ProviderFor(auctionRepository)
final auctionRepositoryProvider = AuctionRepositoryProvider._();

final class AuctionRepositoryProvider
    extends
        $FunctionalProvider<
          AuctionRepository,
          AuctionRepository,
          AuctionRepository
        >
    with $Provider<AuctionRepository> {
  AuctionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'auctionRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$auctionRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuctionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuctionRepository create(Ref ref) {
    return auctionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuctionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuctionRepository>(value),
    );
  }
}

String _$auctionRepositoryHash() => r'63ac664b433292612efb48a5417270c7a734d57a';
