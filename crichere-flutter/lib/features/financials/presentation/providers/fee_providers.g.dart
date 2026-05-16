// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(feeObligations)
const feeObligationsProvider = FeeObligationsFamily._();

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
  const FeeObligationsProvider._({
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
  const FeeObligationsFamily._()
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
