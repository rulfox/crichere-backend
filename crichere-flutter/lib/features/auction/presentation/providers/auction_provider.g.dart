// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auction_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Tracks the SSE connection lifecycle for an auction so the UI can show
/// connecting / live / reconnecting states. Updated by [auctionEvents].

@ProviderFor(AuctionConnection)
final auctionConnectionProvider = AuctionConnectionFamily._();

/// Tracks the SSE connection lifecycle for an auction so the UI can show
/// connecting / live / reconnecting states. Updated by [auctionEvents].
final class AuctionConnectionProvider
    extends $NotifierProvider<AuctionConnection, SseConnectionStatus> {
  /// Tracks the SSE connection lifecycle for an auction so the UI can show
  /// connecting / live / reconnecting states. Updated by [auctionEvents].
  AuctionConnectionProvider._({
    required AuctionConnectionFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'auctionConnectionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$auctionConnectionHash();

  @override
  String toString() {
    return r'auctionConnectionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AuctionConnection create() => AuctionConnection();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SseConnectionStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SseConnectionStatus>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AuctionConnectionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$auctionConnectionHash() => r'fdc26483c28cd6afe53707cbb89f961be1352f75';

/// Tracks the SSE connection lifecycle for an auction so the UI can show
/// connecting / live / reconnecting states. Updated by [auctionEvents].

final class AuctionConnectionFamily extends $Family
    with
        $ClassFamilyOverride<
          AuctionConnection,
          SseConnectionStatus,
          SseConnectionStatus,
          SseConnectionStatus,
          String
        > {
  AuctionConnectionFamily._()
    : super(
        retry: null,
        name: r'auctionConnectionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Tracks the SSE connection lifecycle for an auction so the UI can show
  /// connecting / live / reconnecting states. Updated by [auctionEvents].

  AuctionConnectionProvider call(String auctionId) =>
      AuctionConnectionProvider._(argument: auctionId, from: this);

  @override
  String toString() => r'auctionConnectionProvider';
}

/// Tracks the SSE connection lifecycle for an auction so the UI can show
/// connecting / live / reconnecting states. Updated by [auctionEvents].

abstract class _$AuctionConnection extends $Notifier<SseConnectionStatus> {
  late final _$args = ref.$arg as String;
  String get auctionId => _$args;

  SseConnectionStatus build(String auctionId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SseConnectionStatus, SseConnectionStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SseConnectionStatus, SseConnectionStatus>,
              SseConnectionStatus,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

/// Live auction event stream. Auto-reconnects with `Last-Event-ID` replay; the
/// first event is always a [AuctionEvent.snapshot]. The bearer token is attached
/// by the shared Dio interceptor.

@ProviderFor(auctionEvents)
final auctionEventsProvider = AuctionEventsFamily._();

/// Live auction event stream. Auto-reconnects with `Last-Event-ID` replay; the
/// first event is always a [AuctionEvent.snapshot]. The bearer token is attached
/// by the shared Dio interceptor.

final class AuctionEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<AuctionEvent>,
          AuctionEvent,
          Stream<AuctionEvent>
        >
    with $FutureModifier<AuctionEvent>, $StreamProvider<AuctionEvent> {
  /// Live auction event stream. Auto-reconnects with `Last-Event-ID` replay; the
  /// first event is always a [AuctionEvent.snapshot]. The bearer token is attached
  /// by the shared Dio interceptor.
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

String _$auctionEventsHash() => r'b702abac256dfec88e0b142c4eba1f17814f6707';

/// Live auction event stream. Auto-reconnects with `Last-Event-ID` replay; the
/// first event is always a [AuctionEvent.snapshot]. The bearer token is attached
/// by the shared Dio interceptor.

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

  /// Live auction event stream. Auto-reconnects with `Last-Event-ID` replay; the
  /// first event is always a [AuctionEvent.snapshot]. The bearer token is attached
  /// by the shared Dio interceptor.

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

@ProviderFor(getAuctionSummary)
final getAuctionSummaryProvider = GetAuctionSummaryFamily._();

final class GetAuctionSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<AuctionSummary>,
          AuctionSummary,
          FutureOr<AuctionSummary>
        >
    with $FutureModifier<AuctionSummary>, $FutureProvider<AuctionSummary> {
  GetAuctionSummaryProvider._({
    required GetAuctionSummaryFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'getAuctionSummaryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getAuctionSummaryHash();

  @override
  String toString() {
    return r'getAuctionSummaryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<AuctionSummary> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AuctionSummary> create(Ref ref) {
    final argument = this.argument as String;
    return getAuctionSummary(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetAuctionSummaryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getAuctionSummaryHash() => r'088c3132af1766938e0215c7bd99567581cb4b42';

final class GetAuctionSummaryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<AuctionSummary>, String> {
  GetAuctionSummaryFamily._()
    : super(
        retry: null,
        name: r'getAuctionSummaryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetAuctionSummaryProvider call(String auctionId) =>
      GetAuctionSummaryProvider._(argument: auctionId, from: this);

  @override
  String toString() => r'getAuctionSummaryProvider';
}

/// Rounds configured for an auction (League Detail → Rounds tab).

@ProviderFor(auctionRounds)
final auctionRoundsProvider = AuctionRoundsFamily._();

/// Rounds configured for an auction (League Detail → Rounds tab).

final class AuctionRoundsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<RoundConfig>>,
          List<RoundConfig>,
          FutureOr<List<RoundConfig>>
        >
    with
        $FutureModifier<List<RoundConfig>>,
        $FutureProvider<List<RoundConfig>> {
  /// Rounds configured for an auction (League Detail → Rounds tab).
  AuctionRoundsProvider._({
    required AuctionRoundsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'auctionRoundsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$auctionRoundsHash();

  @override
  String toString() {
    return r'auctionRoundsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<RoundConfig>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<RoundConfig>> create(Ref ref) {
    final argument = this.argument as String;
    return auctionRounds(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AuctionRoundsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$auctionRoundsHash() => r'5b730ad67cc4eb7f77da12680da0c05affb52b13';

/// Rounds configured for an auction (League Detail → Rounds tab).

final class AuctionRoundsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<RoundConfig>>, String> {
  AuctionRoundsFamily._()
    : super(
        retry: null,
        name: r'auctionRoundsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Rounds configured for an auction (League Detail → Rounds tab).

  AuctionRoundsProvider call(String auctionId) =>
      AuctionRoundsProvider._(argument: auctionId, from: this);

  @override
  String toString() => r'auctionRoundsProvider';
}

/// Audit log for an auction, newest first (League Detail → Audit tab).

@ProviderFor(auctionAuditLog)
final auctionAuditLogProvider = AuctionAuditLogFamily._();

/// Audit log for an auction, newest first (League Detail → Audit tab).

final class AuctionAuditLogProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AuditLogResponse>>,
          List<AuditLogResponse>,
          FutureOr<List<AuditLogResponse>>
        >
    with
        $FutureModifier<List<AuditLogResponse>>,
        $FutureProvider<List<AuditLogResponse>> {
  /// Audit log for an auction, newest first (League Detail → Audit tab).
  AuctionAuditLogProvider._({
    required AuctionAuditLogFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'auctionAuditLogProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$auctionAuditLogHash();

  @override
  String toString() {
    return r'auctionAuditLogProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<AuditLogResponse>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AuditLogResponse>> create(Ref ref) {
    final argument = this.argument as String;
    return auctionAuditLog(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AuctionAuditLogProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$auctionAuditLogHash() => r'90aae6eacd9c245fcf7c235b28fbfd21617ac80a';

/// Audit log for an auction, newest first (League Detail → Audit tab).

final class AuctionAuditLogFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<AuditLogResponse>>, String> {
  AuctionAuditLogFamily._()
    : super(
        retry: null,
        name: r'auctionAuditLogProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Audit log for an auction, newest first (League Detail → Audit tab).

  AuctionAuditLogProvider call(String auctionId) =>
      AuctionAuditLogProvider._(argument: auctionId, from: this);

  @override
  String toString() => r'auctionAuditLogProvider';
}
