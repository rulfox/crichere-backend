import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:crichere_flutter/core/database/app_database.dart';
import 'package:crichere_flutter/core/network/api_endpoints.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle background message
  debugPrint("Handling a background message: ${message.messageId}");
}

class NotificationService {
  // Lazily resolved — avoids crashing when Firebase is not yet initialised
  // (e.g. on web before firebase_options.dart is wired up).
  FirebaseMessaging? _fcm;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();
  final AppDatabase _db;
  final Dio _dio;

  NotificationService(this._db, this._dio);

  Future<void> initialize() async {
    // Guard: skip Firebase entirely if it hasn't been initialised.
    // Firebase.apps is empty until Firebase.initializeApp() is called.
    if (Firebase.apps.isEmpty) {
      debugPrint('[NotificationService] Firebase not initialised — skipping push notifications.');
      return;
    }

    _fcm = FirebaseMessaging.instance;

    // Request permission
    NotificationSettings settings = await _fcm!.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');

      // Get token
      String? token = await _fcm!.getToken();
      if (token != null) {
        await _registerDeviceToken(token);
      }

      // Handle token refresh
      _fcm!.onTokenRefresh.listen(_registerDeviceToken);

      if (!kIsWeb) {
        // Initialize local notifications for foreground (native only)
        const AndroidInitializationSettings initializationSettingsAndroid =
            AndroidInitializationSettings('@mipmap/ic_launcher');
        const InitializationSettings initializationSettings =
            InitializationSettings(android: initializationSettingsAndroid);
        await _localNotifications.initialize(initializationSettings);

        // Background messages require a service worker on web
        FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      }

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        _handleIncomingMessage(message, isForeground: true);
      });
    }
  }

  /// Backend `DeviceTokenRequest` requires a non-null `platform` enum — omitting
  /// it returns 400. Resolve it from the running platform.
  String _platform() {
    if (kIsWeb) return 'WEB';
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return 'IOS';
      case TargetPlatform.android:
        return 'ANDROID';
      default:
        return 'ANDROID';
    }
  }

  Future<void> _registerDeviceToken(String token) async {
    try {
      await _dio.post(
        '${ApiEndpoints.notifications}/device-token',
        data: {'token': token, 'platform': _platform()},
      );
    } catch (e) {
      debugPrint('Error registering device token: $e');
    }
  }

  /// Unregisters the current FCM token (call on logout).
  Future<void> unregisterDeviceToken() async {
    try {
      final token = await _fcm?.getToken();
      if (token != null) {
        await _dio.delete(
          '${ApiEndpoints.notifications}/device-token',
          data: {'token': token},
        );
      }
    } catch (e) {
      debugPrint('Error removing device token: $e');
    }
  }

  void _handleIncomingMessage(RemoteMessage message, {required bool isForeground}) async {
    final title = message.notification?.title ?? 'New Notification';
    final body = message.notification?.body ?? '';

    // Save to Drift Database
    await _db.into(_db.notifications).insert(
      NotificationsCompanion.insert(
        title: title,
        message: body,
        receivedAt: DateTime.now(),
        isRead: const Value(false),
      ),
    );

    if (!kIsWeb && isForeground) {
      // Show local notification (native only)
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails('high_importance_channel', 'High Importance Notifications',
              importance: Importance.max, priority: Priority.high);
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await _localNotifications.show(0, title, body, platformChannelSpecifics);
    }
  }
}
