import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class ForfeitManagementScreen extends ConsumerWidget {
  final String leagueId;

  const ForfeitManagementScreen({super.key, required this.leagueId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forfeit Management')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person_off_outlined, size: 64, color: Colors.orange),
            const SizedBox(height: 16),
            Text('Forfeit Requests for League: $leagueId', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 24),
            const Expanded(
              child: Center(
                child: Text('No active forfeit requests', style: TextStyle(color: Colors.grey)),
              ),
            ),
            const Text('Feature Placeholder (T034)', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
