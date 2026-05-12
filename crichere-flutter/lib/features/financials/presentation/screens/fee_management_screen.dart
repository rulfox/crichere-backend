import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class FeeManagementScreen extends ConsumerWidget {
  final String leagueId;

  const FeeManagementScreen({super.key, required this.leagueId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fee Management')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.payments_outlined, size: 64, color: Colors.blue),
            const SizedBox(height: 16),
            Text('Fee Management for League: $leagueId', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 24),
            const Card(
              margin: EdgeInsets.all(16),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Total Obligations'),
                      trailing: Text('₹1,50,000'),
                    ),
                    ListTile(
                      title: Text('Collected'),
                      trailing: Text('₹80,000', style: TextStyle(color: Colors.green)),
                    ),
                    ListTile(
                      title: Text('Pending'),
                      trailing: Text('₹70,000', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              ),
            ),
            const Text('Feature Placeholder (T034)', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Implement fee recording
        },
        label: const Text('RECORD PAYMENT'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
