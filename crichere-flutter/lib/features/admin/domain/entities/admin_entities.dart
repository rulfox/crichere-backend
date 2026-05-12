import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_entities.freezed.dart';
part 'admin_entities.g.dart';

@freezed
abstract class PlatformMetrics with _$PlatformMetrics {
  const factory PlatformMetrics({
    required int totalUsers,
    required int activeLeagues,
    required int ongoingAuctions,
    required int totalRevenue,
    required List<DailyActivity> activityLog,
  }) = _PlatformMetrics;

  factory PlatformMetrics.fromJson(Map<String, dynamic> json) => _$PlatformMetricsFromJson(json);
}

@freezed
abstract class DailyActivity with _$DailyActivity {
  const factory DailyActivity({
    required DateTime date,
    required int usersJoined,
    required int auctionsStarted,
  }) = _DailyActivity;

  factory DailyActivity.fromJson(Map<String, dynamic> json) => _$DailyActivityFromJson(json);
}
