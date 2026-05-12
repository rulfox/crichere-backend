// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auction_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuctionStateNotifier)
final auctionStateProvider = AuctionStateNotifierProvider._();

final class AuctionStateNotifierProvider
    extends $NotifierProvider<AuctionStateNotifier, AuctionState> {
  AuctionStateNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'auctionStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$auctionStateNotifierHash();

  @$internal
  @override
  AuctionStateNotifier create() => AuctionStateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuctionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuctionState>(value),
    );
  }
}

String _$auctionStateNotifierHash() =>
    r'fe76d58c1b3c02c4a45233edde305c69b53f9e72';

abstract class _$AuctionStateNotifier extends $Notifier<AuctionState> {
  AuctionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AuctionState, AuctionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuctionState, AuctionState>,
              AuctionState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
