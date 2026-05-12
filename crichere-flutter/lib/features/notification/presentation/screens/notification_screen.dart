import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'package:crichere_flutter/shared/widgets/cric/cric_widgets.dart';
import 'package:crichere_flutter/core/database/app_database.dart';
import 'package:crichere_flutter/features/league/presentation/providers/league_repository_provider.dart';
import 'package:drift/drift.dart' hide Column;

@RoutePage()
class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(appDatabaseProvider);
    final notificationsStream = db.select(db.notifications).watch();

    return Scaffold(
      backgroundColor: CricColor.appBg,
      appBar: CricAppBar(
        showLogo: false,
        title: 'NOTIFICATIONS',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: CricColor.textPrimary),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: StreamBuilder<List<Notification>>(
        stream: notificationsStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: CricColor.gold));
          final notifications = snapshot.data!;
          if (notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.notifications_off_outlined, size: 48, color: CricColor.textFaint),
                  const SizedBox(height: 16),
                  Text('All caught up!', style: CricTextStyle.body),
                ],
              ),
            );
          }
          
          return ListView.builder(
            padding: const EdgeInsets.all(CricSpacing.page),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final n = notifications[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: CricSpacing.sm),
                child: CricCard(
                  padding: const EdgeInsets.all(12),
                  onTap: () async {
                    await (db.update(db.notifications)..where((t) => t.id.equals(n.id)))
                        .write(const NotificationsCompanion(isRead: Value(true)));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: n.isRead ? CricColor.slate3 : CricColor.badgeBg(CricColor.gold),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          n.isRead ? Icons.notifications_none : Icons.notifications_active, 
                          size: 18, 
                          color: n.isRead ? CricColor.textFaint : CricColor.gold,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(n.title, style: CricTextStyle.headingMd.copyWith(fontSize: 14)),
                            const SizedBox(height: 2),
                            Text(n.message, style: CricTextStyle.body.copyWith(fontSize: 13)),
                            const SizedBox(height: 6),
                            Text(
                              '2 hours ago', // Dummy time formatting
                              style: CricTextStyle.caption.copyWith(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      if (!n.isRead)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(color: CricColor.gold, shape: BoxShape.circle),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
