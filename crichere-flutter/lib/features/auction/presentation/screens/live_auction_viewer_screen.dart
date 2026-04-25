import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/auction_provider.dart';
import '../../domain/entities/auction_event.dart';

@RoutePage()
class LiveAuctionViewerScreen extends ConsumerWidget {
  final String auctionId;

  const LiveAuctionViewerScreen({super.key, required this.auctionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(auctionEventsProvider(auctionId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Auction'),
        actions: [
          eventsAsync.when(
            data: (_) => const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.circle, color: Colors.green, size: 12),
            ),
            loading: () => const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.circle, color: Colors.orange, size: 12),
            ),
            error: (_, __) => const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.circle, color: Colors.red, size: 12),
            ),
          ),
        ],
      ),
      body: eventsAsync.when(
        data: (event) {
          // This only shows the LATEST event. 
          // Realistically, we'd want to maintain a state.
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Last Event: ${event.runtimeType}'),
                // Display based on event type
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
