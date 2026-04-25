import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:crichere_flutter/features/league/presentation/providers/league_repository_provider.dart';
import 'package:crichere_flutter/core/database/app_database.dart';
import 'package:drift/drift.dart' hide Column;

@RoutePage()
class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(appDatabaseProvider);
    final notificationsStream = db.select(db.notifications).watch();

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: StreamBuilder(
        stream: notificationsStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final notifications = snapshot.data!;
          if (notifications.isEmpty) return const Center(child: Text('No notifications'));
          
          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final n = notifications[index];
              return ListTile(
                title: Text(n.title),
                subtitle: Text(n.message),
                trailing: Text(n.receivedAt.toString().substring(11, 16)),
                leading: Icon(n.isRead ? Icons.notifications_none : Icons.notifications_active, 
                             color: n.isRead ? Colors.grey : Colors.blue),
                onTap: () async {
                  await (db.update(db.notifications)..where((t) => t.id.equals(n.id)))
                      .write(const NotificationsCompanion(isRead: Value(true)));
                },
              );
            },
          );
        },
      ),
    );
  }
}
