// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forfeit_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(forfeitRequests)
const forfeitRequestsProvider = ForfeitRequestsFamily._();

final class ForfeitRequestsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ForfeitRequest>>,
          List<ForfeitRequest>,
          FutureOr<List<ForfeitRequest>>
        >
    with
        $FutureModifier<List<ForfeitRequest>>,
        $FutureProvider<List<ForfeitRequest>> {
  const ForfeitRequestsProvider._({
    required ForfeitRequestsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'forfeitRequestsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$forfeitRequestsHash();

  @override
  String toString() {
    return r'forfeitRequestsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ForfeitRequest>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ForfeitRequest>> create(Ref ref) {
    final argument = this.argument as String;
    return forfeitRequests(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ForfeitRequestsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$forfeitRequestsHash() => r'520d6894494b02e911bad5b591fd53588789e8db';

final class ForfeitRequestsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ForfeitRequest>>, String> {
  const ForfeitRequestsFamily._()
    : super(
        retry: null,
        name: r'forfeitRequestsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ForfeitRequestsProvider call(String leagueId) =>
      ForfeitRequestsProvider._(argument: leagueId, from: this);

  @override
  String toString() => r'forfeitRequestsProvider';
}
