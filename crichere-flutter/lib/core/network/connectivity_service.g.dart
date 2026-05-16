// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(connectivity)
const connectivityProvider = ConnectivityProvider._();

final class ConnectivityProvider
    extends
        $FunctionalProvider<
          AsyncValue<ConnectivityResult>,
          ConnectivityResult,
          Stream<ConnectivityResult>
        >
    with
        $FutureModifier<ConnectivityResult>,
        $StreamProvider<ConnectivityResult> {
  const ConnectivityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'connectivityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$connectivityHash();

  @$internal
  @override
  $StreamProviderElement<ConnectivityResult> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<ConnectivityResult> create(Ref ref) {
    return connectivity(ref);
  }
}

String _$connectivityHash() => r'7dc37f6e649ce5a9a12d5e59caa41356bc533a5e';
