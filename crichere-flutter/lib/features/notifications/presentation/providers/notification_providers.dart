import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:crichere_flutter/core/providers/auth_provider.dart';
import '../../data/notification_api.dart';
import '../../domain/entities/notification_entities.dart';

part 'notification_providers.g.dart';

@riverpod
NotificationApi notificationApi(Ref ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return NotificationApi(dio);
}

@riverpod
Future<NotificationListResponse> notifications(
  Ref ref, {
  bool unreadOnly = false,
  int page = 0,
  int size = 20,
}) {
  return ref
      .watch(notificationApiProvider)
      .getNotifications(unreadOnly: unreadOnly, page: page, size: size);
}

@riverpod
Future<int> unreadNotificationCount(Ref ref) async {
  final result = await ref.watch(notificationApiProvider).getUnreadCount();
  if (result is Map && result['unreadCount'] != null) {
    return (result['unreadCount'] as num).toInt();
  }
  return 0;
}
