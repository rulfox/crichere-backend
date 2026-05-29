import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:crichere_flutter/core/enums/backend_enums.dart';

part 'notification_entities.freezed.dart';
part 'notification_entities.g.dart';

/// Mirrors backend `NotificationResponse`.
@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required String userId,
    @JsonKey(unknownEnumValue: NotificationType.unknown)
    required NotificationType type,
    required String title,
    required String body,
    Map<String, dynamic>? payload,
    DateTime? readAt,
    DateTime? createdAt,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);
}

/// Mirrors backend `NotificationListResponse`.
@freezed
abstract class NotificationListResponse with _$NotificationListResponse {
  const factory NotificationListResponse({
    @Default(<AppNotification>[]) List<AppNotification> notifications,
    @Default(0) int unreadCount,
    @Default(0) int totalElements,
    @Default(0) int totalPages,
    @Default(0) int pageNumber,
    @Default(0) int pageSize,
  }) = _NotificationListResponse;

  factory NotificationListResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationListResponseFromJson(json);
}
