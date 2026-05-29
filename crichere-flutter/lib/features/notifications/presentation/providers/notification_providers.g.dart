// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationApi)
final notificationApiProvider = NotificationApiProvider._();

final class NotificationApiProvider
    extends
        $FunctionalProvider<NotificationApi, NotificationApi, NotificationApi>
    with $Provider<NotificationApi> {
  NotificationApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationApiHash();

  @$internal
  @override
  $ProviderElement<NotificationApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NotificationApi create(Ref ref) {
    return notificationApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationApi>(value),
    );
  }
}

String _$notificationApiHash() => r'f6ecb618bef9ec680d0cc0ff5ddea9d735a8718b';

@ProviderFor(notifications)
final notificationsProvider = NotificationsFamily._();

final class NotificationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<NotificationListResponse>,
          NotificationListResponse,
          FutureOr<NotificationListResponse>
        >
    with
        $FutureModifier<NotificationListResponse>,
        $FutureProvider<NotificationListResponse> {
  NotificationsProvider._({
    required NotificationsFamily super.from,
    required ({bool unreadOnly, int page, int size}) super.argument,
  }) : super(
         retry: null,
         name: r'notificationsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$notificationsHash();

  @override
  String toString() {
    return r'notificationsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<NotificationListResponse> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<NotificationListResponse> create(Ref ref) {
    final argument = this.argument as ({bool unreadOnly, int page, int size});
    return notifications(
      ref,
      unreadOnly: argument.unreadOnly,
      page: argument.page,
      size: argument.size,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is NotificationsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$notificationsHash() => r'4f5a1f1597fd75862ed6233122405ce34a28aed5';

final class NotificationsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<NotificationListResponse>,
          ({bool unreadOnly, int page, int size})
        > {
  NotificationsFamily._()
    : super(
        retry: null,
        name: r'notificationsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  NotificationsProvider call({
    bool unreadOnly = false,
    int page = 0,
    int size = 20,
  }) => NotificationsProvider._(
    argument: (unreadOnly: unreadOnly, page: page, size: size),
    from: this,
  );

  @override
  String toString() => r'notificationsProvider';
}

@ProviderFor(unreadNotificationCount)
final unreadNotificationCountProvider = UnreadNotificationCountProvider._();

final class UnreadNotificationCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  UnreadNotificationCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unreadNotificationCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unreadNotificationCountHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return unreadNotificationCount(ref);
  }
}

String _$unreadNotificationCountHash() =>
    r'ff340086740e32d1ca6dabe9309fa3ecbfe8f54a';
