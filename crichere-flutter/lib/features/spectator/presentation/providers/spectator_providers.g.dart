// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spectator_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// A Dio instance for the public spectator endpoints: NO auth interceptor and
/// NO 401-refresh, but it still unwraps the `ApiResponse` envelope so Retrofit
/// deserializes the inner payload.

@ProviderFor(publicDio)
final publicDioProvider = PublicDioProvider._();

/// A Dio instance for the public spectator endpoints: NO auth interceptor and
/// NO 401-refresh, but it still unwraps the `ApiResponse` envelope so Retrofit
/// deserializes the inner payload.

final class PublicDioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// A Dio instance for the public spectator endpoints: NO auth interceptor and
  /// NO 401-refresh, but it still unwraps the `ApiResponse` envelope so Retrofit
  /// deserializes the inner payload.
  PublicDioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'publicDioProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$publicDioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return publicDio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$publicDioHash() => r'a7cc322d5497cdb937fa5e3bcda9650a345a7dba';

@ProviderFor(publicAuctionApi)
final publicAuctionApiProvider = PublicAuctionApiProvider._();

final class PublicAuctionApiProvider
    extends
        $FunctionalProvider<
          PublicAuctionApi,
          PublicAuctionApi,
          PublicAuctionApi
        >
    with $Provider<PublicAuctionApi> {
  PublicAuctionApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'publicAuctionApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$publicAuctionApiHash();

  @$internal
  @override
  $ProviderElement<PublicAuctionApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PublicAuctionApi create(Ref ref) {
    return publicAuctionApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PublicAuctionApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PublicAuctionApi>(value),
    );
  }
}

String _$publicAuctionApiHash() => r'9652cf52ceecb258baf06cf4b3dd5bb149b7e522';

@ProviderFor(publicAuctionState)
final publicAuctionStateProvider = PublicAuctionStateFamily._();

final class PublicAuctionStateProvider
    extends
        $FunctionalProvider<
          AsyncValue<AuctionStateSnapshot>,
          AuctionStateSnapshot,
          FutureOr<AuctionStateSnapshot>
        >
    with
        $FutureModifier<AuctionStateSnapshot>,
        $FutureProvider<AuctionStateSnapshot> {
  PublicAuctionStateProvider._({
    required PublicAuctionStateFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'publicAuctionStateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$publicAuctionStateHash();

  @override
  String toString() {
    return r'publicAuctionStateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<AuctionStateSnapshot> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AuctionStateSnapshot> create(Ref ref) {
    final argument = this.argument as String;
    return publicAuctionState(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PublicAuctionStateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$publicAuctionStateHash() =>
    r'52878bd1bb65e203eb456e8528ebce688df3559a';

final class PublicAuctionStateFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<AuctionStateSnapshot>, String> {
  PublicAuctionStateFamily._()
    : super(
        retry: null,
        name: r'publicAuctionStateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PublicAuctionStateProvider call(String auctionId) =>
      PublicAuctionStateProvider._(argument: auctionId, from: this);

  @override
  String toString() => r'publicAuctionStateProvider';
}

@ProviderFor(publicAuctionView)
final publicAuctionViewProvider = PublicAuctionViewFamily._();

final class PublicAuctionViewProvider
    extends
        $FunctionalProvider<
          AsyncValue<AuctionStateSnapshot>,
          AuctionStateSnapshot,
          FutureOr<AuctionStateSnapshot>
        >
    with
        $FutureModifier<AuctionStateSnapshot>,
        $FutureProvider<AuctionStateSnapshot> {
  PublicAuctionViewProvider._({
    required PublicAuctionViewFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'publicAuctionViewProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$publicAuctionViewHash();

  @override
  String toString() {
    return r'publicAuctionViewProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<AuctionStateSnapshot> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AuctionStateSnapshot> create(Ref ref) {
    final argument = this.argument as String;
    return publicAuctionView(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PublicAuctionViewProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$publicAuctionViewHash() => r'd67817c562f821ec6eeddd9e15641d00fe1191a2';

final class PublicAuctionViewFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<AuctionStateSnapshot>, String> {
  PublicAuctionViewFamily._()
    : super(
        retry: null,
        name: r'publicAuctionViewProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PublicAuctionViewProvider call(String token) =>
      PublicAuctionViewProvider._(argument: token, from: this);

  @override
  String toString() => r'publicAuctionViewProvider';
}

@ProviderFor(publicViewStatus)
final publicViewStatusProvider = PublicViewStatusFamily._();

final class PublicViewStatusProvider
    extends $FunctionalProvider<AsyncValue<dynamic>, dynamic, FutureOr<dynamic>>
    with $FutureModifier<dynamic>, $FutureProvider<dynamic> {
  PublicViewStatusProvider._({
    required PublicViewStatusFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'publicViewStatusProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$publicViewStatusHash();

  @override
  String toString() {
    return r'publicViewStatusProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<dynamic> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<dynamic> create(Ref ref) {
    final argument = this.argument as String;
    return publicViewStatus(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PublicViewStatusProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$publicViewStatusHash() => r'a7607079a3a1ed7c8a3cec4cb20e5502a8e6e4af';

final class PublicViewStatusFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<dynamic>, String> {
  PublicViewStatusFamily._()
    : super(
        retry: null,
        name: r'publicViewStatusProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PublicViewStatusProvider call(String token) =>
      PublicViewStatusProvider._(argument: token, from: this);

  @override
  String toString() => r'publicViewStatusProvider';
}

/// Public live event stream by auction id (no auth). Auto-reconnects with
/// `Last-Event-ID` replay; first event is the [AuctionEvent.snapshot].

@ProviderFor(publicAuctionEvents)
final publicAuctionEventsProvider = PublicAuctionEventsFamily._();

/// Public live event stream by auction id (no auth). Auto-reconnects with
/// `Last-Event-ID` replay; first event is the [AuctionEvent.snapshot].

final class PublicAuctionEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<AuctionEvent>,
          AuctionEvent,
          Stream<AuctionEvent>
        >
    with $FutureModifier<AuctionEvent>, $StreamProvider<AuctionEvent> {
  /// Public live event stream by auction id (no auth). Auto-reconnects with
  /// `Last-Event-ID` replay; first event is the [AuctionEvent.snapshot].
  PublicAuctionEventsProvider._({
    required PublicAuctionEventsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'publicAuctionEventsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$publicAuctionEventsHash();

  @override
  String toString() {
    return r'publicAuctionEventsProvider'
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
    return publicAuctionEvents(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PublicAuctionEventsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$publicAuctionEventsHash() =>
    r'26c6318ffec074e4d202eb658087d91616a389ed';

/// Public live event stream by auction id (no auth). Auto-reconnects with
/// `Last-Event-ID` replay; first event is the [AuctionEvent.snapshot].

final class PublicAuctionEventsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<AuctionEvent>, String> {
  PublicAuctionEventsFamily._()
    : super(
        retry: null,
        name: r'publicAuctionEventsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Public live event stream by auction id (no auth). Auto-reconnects with
  /// `Last-Event-ID` replay; first event is the [AuctionEvent.snapshot].

  PublicAuctionEventsProvider call(String auctionId) =>
      PublicAuctionEventsProvider._(argument: auctionId, from: this);

  @override
  String toString() => r'publicAuctionEventsProvider';
}

/// Public live event stream by share token (no auth).

@ProviderFor(publicViewEvents)
final publicViewEventsProvider = PublicViewEventsFamily._();

/// Public live event stream by share token (no auth).

final class PublicViewEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<AuctionEvent>,
          AuctionEvent,
          Stream<AuctionEvent>
        >
    with $FutureModifier<AuctionEvent>, $StreamProvider<AuctionEvent> {
  /// Public live event stream by share token (no auth).
  PublicViewEventsProvider._({
    required PublicViewEventsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'publicViewEventsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$publicViewEventsHash();

  @override
  String toString() {
    return r'publicViewEventsProvider'
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
    return publicViewEvents(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PublicViewEventsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$publicViewEventsHash() => r'71a9431232c2130df2b100155c08cc3e159ae6a3';

/// Public live event stream by share token (no auth).

final class PublicViewEventsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<AuctionEvent>, String> {
  PublicViewEventsFamily._()
    : super(
        retry: null,
        name: r'publicViewEventsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Public live event stream by share token (no auth).

  PublicViewEventsProvider call(String token) =>
      PublicViewEventsProvider._(argument: token, from: this);

  @override
  String toString() => r'publicViewEventsProvider';
}
