// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waitlist_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(waitlist)
const waitlistProvider = WaitlistFamily._();

final class WaitlistProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<WaitlistEntry>>,
          List<WaitlistEntry>,
          FutureOr<List<WaitlistEntry>>
        >
    with
        $FutureModifier<List<WaitlistEntry>>,
        $FutureProvider<List<WaitlistEntry>> {
  const WaitlistProvider._({
    required WaitlistFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'waitlistProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$waitlistHash();

  @override
  String toString() {
    return r'waitlistProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<WaitlistEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<WaitlistEntry>> create(Ref ref) {
    final argument = this.argument as String;
    return waitlist(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is WaitlistProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$waitlistHash() => r'8e91e54be54790a6c0160146168bdd0906952cd8';

final class WaitlistFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<WaitlistEntry>>, String> {
  const WaitlistFamily._()
    : super(
        retry: null,
        name: r'waitlistProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  WaitlistProvider call(String leagueId) =>
      WaitlistProvider._(argument: leagueId, from: this);

  @override
  String toString() => r'waitlistProvider';
}
