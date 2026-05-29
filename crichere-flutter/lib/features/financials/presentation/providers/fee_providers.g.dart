// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(feeObligations)
final feeObligationsProvider = FeeObligationsFamily._();

final class FeeObligationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FeeObligation>>,
          List<FeeObligation>,
          FutureOr<List<FeeObligation>>
        >
    with
        $FutureModifier<List<FeeObligation>>,
        $FutureProvider<List<FeeObligation>> {
  FeeObligationsProvider._({
    required FeeObligationsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'feeObligationsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$feeObligationsHash();

  @override
  String toString() {
    return r'feeObligationsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<FeeObligation>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<FeeObligation>> create(Ref ref) {
    final argument = this.argument as String;
    return feeObligations(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FeeObligationsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$feeObligationsHash() => r'1293509da9775f704d168e2c4aa90cd7b392618a';

final class FeeObligationsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<FeeObligation>>, String> {
  FeeObligationsFamily._()
    : super(
        retry: null,
        name: r'feeObligationsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FeeObligationsProvider call(String leagueId) =>
      FeeObligationsProvider._(argument: leagueId, from: this);

  @override
  String toString() => r'feeObligationsProvider';
}

/// Authoritative fee totals from the backend (`GET /leagues/{id}/fees/summary`).

@ProviderFor(feeSummary)
final feeSummaryProvider = FeeSummaryFamily._();

/// Authoritative fee totals from the backend (`GET /leagues/{id}/fees/summary`).

final class FeeSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<FeeSummary>,
          FeeSummary,
          FutureOr<FeeSummary>
        >
    with $FutureModifier<FeeSummary>, $FutureProvider<FeeSummary> {
  /// Authoritative fee totals from the backend (`GET /leagues/{id}/fees/summary`).
  FeeSummaryProvider._({
    required FeeSummaryFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'feeSummaryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$feeSummaryHash();

  @override
  String toString() {
    return r'feeSummaryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<FeeSummary> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<FeeSummary> create(Ref ref) {
    final argument = this.argument as String;
    return feeSummary(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FeeSummaryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$feeSummaryHash() => r'd552fb9f709302ecf32f408aeaa2870299d29973';

/// Authoritative fee totals from the backend (`GET /leagues/{id}/fees/summary`).

final class FeeSummaryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<FeeSummary>, String> {
  FeeSummaryFamily._()
    : super(
        retry: null,
        name: r'feeSummaryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Authoritative fee totals from the backend (`GET /leagues/{id}/fees/summary`).

  FeeSummaryProvider call(String leagueId) =>
      FeeSummaryProvider._(argument: leagueId, from: this);

  @override
  String toString() => r'feeSummaryProvider';
}
