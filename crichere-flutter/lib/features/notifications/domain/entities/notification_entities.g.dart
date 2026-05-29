// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) =>
    _AppNotification(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: $enumDecode(
        _$NotificationTypeEnumMap,
        json['type'],
        unknownValue: NotificationType.unknown,
      ),
      title: json['title'] as String,
      body: json['body'] as String,
      payload: json['payload'] as Map<String, dynamic>?,
      readAt: json['readAt'] == null
          ? null
          : DateTime.parse(json['readAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$AppNotificationToJson(_AppNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'title': instance.title,
      'body': instance.body,
      'payload': instance.payload,
      'readAt': instance.readAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$NotificationTypeEnumMap = {
  NotificationType.auctionStarted: 'AUCTION_STARTED',
  NotificationType.playerSold: 'PLAYER_SOLD',
  NotificationType.forfeitApproved: 'FORFEIT_APPROVED',
  NotificationType.waitingListPromoted: 'WAITING_LIST_PROMOTED',
  NotificationType.feePaymentRecorded: 'FEE_PAYMENT_RECORDED',
  NotificationType.franchiseInvite: 'FRANCHISE_INVITE',
  NotificationType.ghostProfileInvite: 'GHOST_PROFILE_INVITE',
  NotificationType.unknown: 'unknown',
};

_NotificationListResponse _$NotificationListResponseFromJson(
  Map<String, dynamic> json,
) => _NotificationListResponse(
  notifications:
      (json['notifications'] as List<dynamic>?)
          ?.map((e) => AppNotification.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <AppNotification>[],
  unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
  totalElements: (json['totalElements'] as num?)?.toInt() ?? 0,
  totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
  pageNumber: (json['pageNumber'] as num?)?.toInt() ?? 0,
  pageSize: (json['pageSize'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$NotificationListResponseToJson(
  _NotificationListResponse instance,
) => <String, dynamic>{
  'notifications': instance.notifications,
  'unreadCount': instance.unreadCount,
  'totalElements': instance.totalElements,
  'totalPages': instance.totalPages,
  'pageNumber': instance.pageNumber,
  'pageSize': instance.pageSize,
};
