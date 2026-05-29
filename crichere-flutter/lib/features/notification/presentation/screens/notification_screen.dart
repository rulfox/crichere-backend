import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'package:crichere_flutter/shared/widgets/cric/cric_widgets.dart';
import 'package:crichere_flutter/features/notifications/domain/entities/notification_entities.dart';
import 'package:crichere_flutter/features/notifications/presentation/providers/notification_providers.dart';

String _formatTime(DateTime dt) {
  final now = DateTime.now();
  final diff = now.difference(dt);
  if (diff.inMinutes < 1) return 'just now';
  if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
  if (diff.inHours < 24) return '${diff.inHours}h ago';
  if (diff.inDays < 7) return '${diff.inDays}d ago';
  return DateFormat('d MMM').format(dt);
}

@RoutePage()
class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Server is the source of truth for notification history + read-state
    // (syncs across devices). FCM still populates the local cache for instant
    // foreground display, but the center reflects the backend.
    final notificationsAsync = ref.watch(notificationsProvider());
    final api = ref.watch(notificationApiProvider);

    Future<void> refresh() async => ref.invalidate(notificationsProvider);

    return Scaffold(
      backgroundColor: CricColor.appBg,
      appBar: CricAppBar(
        showLogo: false,
        title: 'NOTIFICATIONS',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: CricColor.textPrimary),
          onPressed: () => context.router.pop(),
        ),
        actions: [
          IconButton(
            tooltip: 'Mark all read',
            icon: const Icon(Icons.done_all, color: CricColor.textPrimary),
            onPressed: () async {
              await api.markAllAsRead();
              await refresh();
            },
          ),
        ],
      ),
      body: notificationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: CricColor.gold)),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(CricSpacing.page),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.cloud_off_outlined, size: 48, color: CricColor.textFaint),
                const SizedBox(height: 16),
                Text('Could not load notifications', style: CricTextStyle.body),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: CricButtonStyle.primary,
                  onPressed: refresh,
                  child: const Text('RETRY'),
                ),
              ],
            ),
          ),
        ),
        data: (list) {
          final notifications = list.notifications;
          if (notifications.isEmpty) {
            return RefreshIndicator(
              color: CricColor.gold,
              onRefresh: refresh,
              child: ListView(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.35),
                  const Icon(Icons.notifications_off_outlined, size: 48, color: CricColor.textFaint),
                  const SizedBox(height: 16),
                  Center(child: Text('All caught up!', style: CricTextStyle.body)),
                ],
              ),
            );
          }

          return RefreshIndicator(
            color: CricColor.gold,
            onRefresh: refresh,
            child: ListView.builder(
              padding: const EdgeInsets.all(CricSpacing.page),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final n = notifications[index];
                final isRead = n.readAt != null;
                return Dismissible(
                  key: ValueKey(n.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 24),
                    color: CricColor.red,
                    child: const Icon(Icons.delete_outline, color: Colors.white),
                  ),
                  onDismissed: (_) async {
                    await api.deleteNotification(n.id);
                    await refresh();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: CricSpacing.sm),
                    child: CricCard(
                      padding: const EdgeInsets.all(12),
                      onTap: isRead
                          ? null
                          : () async {
                              await api.markAsRead(n.id);
                              await refresh();
                            },
                      child: _NotificationRow(notification: n, isRead: isRead),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _NotificationRow extends StatelessWidget {
  final AppNotification notification;
  final bool isRead;
  const _NotificationRow({required this.notification, required this.isRead});

  @override
  Widget build(BuildContext context) {
    final n = notification;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isRead ? CricColor.slate3 : CricColor.badgeBg(CricColor.gold),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isRead ? Icons.notifications_none : Icons.notifications_active,
            size: 18,
            color: isRead ? CricColor.textFaint : CricColor.gold,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(n.title, style: CricTextStyle.headingMd.copyWith(fontSize: 14)),
              const SizedBox(height: 2),
              Text(n.body, style: CricTextStyle.body.copyWith(fontSize: 13)),
              if (n.createdAt != null) ...[
                const SizedBox(height: 6),
                Text(_formatTime(n.createdAt!), style: CricTextStyle.caption.copyWith(fontSize: 10)),
              ],
            ],
          ),
        ),
        if (!isRead)
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(color: CricColor.gold, shape: BoxShape.circle),
          ),
      ],
    );
  }
}
