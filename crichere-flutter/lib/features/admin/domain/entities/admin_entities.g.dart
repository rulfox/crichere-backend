// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlatformMetrics _$PlatformMetricsFromJson(Map<String, dynamic> json) =>
    _PlatformMetrics(
      totalUsers: (json['totalUsers'] as num).toInt(),
      activeLeagues: (json['activeLeagues'] as num).toInt(),
      ongoingAuctions: (json['ongoingAuctions'] as num).toInt(),
      totalRevenue: (json['totalRevenue'] as num).toInt(),
      activityLog: (json['activityLog'] as List<dynamic>)
          .map((e) => DailyActivity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlatformMetricsToJson(_PlatformMetrics instance) =>
    <String, dynamic>{
      'totalUsers': instance.totalUsers,
      'activeLeagues': instance.activeLeagues,
      'ongoingAuctions': instance.ongoingAuctions,
      'totalRevenue': instance.totalRevenue,
      'activityLog': instance.activityLog,
    };

_DailyActivity _$DailyActivityFromJson(Map<String, dynamic> json) =>
    _DailyActivity(
      date: DateTime.parse(json['date'] as String),
      usersJoined: (json['usersJoined'] as num).toInt(),
      auctionsStarted: (json['auctionsStarted'] as num).toInt(),
    );

Map<String, dynamic> _$DailyActivityToJson(_DailyActivity instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'usersJoined': instance.usersJoined,
      'auctionsStarted': instance.auctionsStarted,
    };
