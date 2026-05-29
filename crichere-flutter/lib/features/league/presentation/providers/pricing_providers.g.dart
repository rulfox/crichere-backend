// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricing_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(categoryPrices)
final categoryPricesProvider = CategoryPricesFamily._();

final class CategoryPricesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CategoryPrice>>,
          List<CategoryPrice>,
          FutureOr<List<CategoryPrice>>
        >
    with
        $FutureModifier<List<CategoryPrice>>,
        $FutureProvider<List<CategoryPrice>> {
  CategoryPricesProvider._({
    required CategoryPricesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'categoryPricesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$categoryPricesHash();

  @override
  String toString() {
    return r'categoryPricesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<CategoryPrice>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CategoryPrice>> create(Ref ref) {
    final argument = this.argument as String;
    return categoryPrices(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CategoryPricesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$categoryPricesHash() => r'8dd9f0aba9b37c197ca4021b72c6dae5cb7a3643';

final class CategoryPricesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<CategoryPrice>>, String> {
  CategoryPricesFamily._()
    : super(
        retry: null,
        name: r'categoryPricesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CategoryPricesProvider call(String leagueId) =>
      CategoryPricesProvider._(argument: leagueId, from: this);

  @override
  String toString() => r'categoryPricesProvider';
}

@ProviderFor(tagPrices)
final tagPricesProvider = TagPricesFamily._();

final class TagPricesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TagPrice>>,
          List<TagPrice>,
          FutureOr<List<TagPrice>>
        >
    with $FutureModifier<List<TagPrice>>, $FutureProvider<List<TagPrice>> {
  TagPricesProvider._({
    required TagPricesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'tagPricesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tagPricesHash();

  @override
  String toString() {
    return r'tagPricesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<TagPrice>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TagPrice>> create(Ref ref) {
    final argument = this.argument as String;
    return tagPrices(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TagPricesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tagPricesHash() => r'2ac8bdaf08bc10c292cb11b9a6f295697435b9c7';

final class TagPricesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<TagPrice>>, String> {
  TagPricesFamily._()
    : super(
        retry: null,
        name: r'tagPricesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TagPricesProvider call(String leagueId) =>
      TagPricesProvider._(argument: leagueId, from: this);

  @override
  String toString() => r'tagPricesProvider';
}
