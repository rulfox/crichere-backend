import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../domain/entities/notification_entities.dart';

part 'notification_api.g.dart';

/// Client for the backend `NotificationController` (`/notifications`).
@RestApi()
abstract class NotificationApi {
  factory NotificationApi(Dio dio, {String baseUrl}) = _NotificationApi;

  /// Body: `{token, platform(ANDROID|IOS|WEB)}`.
  @POST('/notifications/device-token')
  Future<void> registerDeviceToken(@Body() Map<String, dynamic> body);

  /// Body: `{token}`.
  @DELETE('/notifications/device-token')
  Future<void> removeDeviceToken(@Body() Map<String, dynamic> body);

  /// Returns `{unreadCount}` (after the Dio envelope is unwrapped).
  @GET('/notifications/unread-count')
  Future<dynamic> getUnreadCount();

  @GET('/notifications')
  Future<NotificationListResponse> getNotifications({
    @Query('unreadOnly') bool? unreadOnly,
    @Query('page') int? page,
    @Query('size') int? size,
  });

  @PATCH('/notifications/{id}/read')
  Future<AppNotification> markAsRead(@Path('id') String id);

  @PATCH('/notifications/read-all')
  Future<void> markAllAsRead();

  @DELETE('/notifications/{id}')
  Future<void> deleteNotification(@Path('id') String id);
}
