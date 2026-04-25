import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/franchise_providers.dart';

@RoutePage()
class FranchiseSquadScreen extends ConsumerWidget {
  final String franchiseId;

  const FranchiseSquadScreen({super.key, required this.franchiseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final squadAsync = ref.watch(squadProvider(franchiseId));

    return Scaffold(
      appBar: AppBar(title: const Text('Franchise Squad')),
      body: squadAsync.when(
        data: (squad) => Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue[50],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Purse Remaining:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('₹${squad.purseRemaining}', style: const TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: squad.players.length,
                itemBuilder: (context, index) {
                  final player = squad.players[index];
                  return Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(radius: 30, child: Icon(Icons.person)),
                        const SizedBox(height: 8),
                        Text(player.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(player.role),
                        const SizedBox(height: 4),
                        Chip(
                          label: Text(player.assignmentType, style: const TextStyle(fontSize: 10)),
                          visualDensity: VisualDensity.compact,
                        ),
                        Text('₹${player.price}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
