import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/auction_provider.dart';
import '../providers/auction_state_provider.dart';

@RoutePage()
class LiveAuctionViewerScreen extends ConsumerWidget {
  final String auctionId;

  const LiveAuctionViewerScreen({super.key, required this.auctionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(auctionEventsProvider(auctionId));
    final auctionState = ref.watch(auctionStateProvider);

    // Listen to events and update local state
    ref.listen(auctionEventsProvider(auctionId), (previous, next) {
      next.whenData((event) {
        ref.read(auctionStateProvider.notifier).handleEvent(event);
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Auction'),
        actions: [
          _ConnectionStatusIndicator(eventsAsync: eventsAsync),
        ],
      ),
      body: Column(
        children: [
          if (auctionState.currentPlayerName != null)
            _PlayerAuctionCard(
              name: auctionState.currentPlayerName!,
              currentBid: auctionState.currentBid,
              leadingFranchise: auctionState.leadingFranchise,
              status: auctionState.status,
            )
          else
            const Expanded(child: Center(child: Text('Waiting for next player...'))),

          if (auctionState.bidHistory.isNotEmpty)
            _BidHistoryStrip(history: auctionState.bidHistory),
        ],
      ),
    );
  }
}

class _ConnectionStatusIndicator extends StatelessWidget {
  final AsyncValue eventsAsync;
  const _ConnectionStatusIndicator({required this.eventsAsync});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: eventsAsync.when(
        data: (_) => const Row(
          children: [
            Icon(Icons.circle, color: Colors.green, size: 12),
            SizedBox(width: 4),
            Text('LIVE', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
        loading: () => const Icon(Icons.circle, color: Colors.orange, size: 12),
        error: (_, _) => const Row(
          children: [
            Icon(Icons.circle, color: Colors.red, size: 12),
            SizedBox(width: 4),
            Text('OFFLINE', style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class _PlayerAuctionCard extends StatelessWidget {
  final String name;
  final int currentBid;
  final String? leadingFranchise;
  final String status;

  const _PlayerAuctionCard({
    required this.name,
    required this.currentBid,
    this.leadingFranchise,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)],
      ),
      child: Column(
        children: [
          const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
          const SizedBox(height: 16),
          Semantics(
            liveRegion: true,
            child: Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 24),
          const Text('CURRENT BID', style: TextStyle(color: Colors.grey, letterSpacing: 1.2)),
          Semantics(
            liveRegion: true,
            label: 'The bid is now $currentBid',
            child: Text('₹$currentBid', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.blue)),
          ),
          if (leadingFranchise != null) ...[
            const SizedBox(height: 8),
            Text('by $leadingFranchise', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          ],
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: status == 'SOLD' ? Colors.green : (status == 'UNSOLD' ? Colors.orange : Colors.blue),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(status, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class _BidHistoryStrip extends StatelessWidget {
  final List history;
  const _BidHistoryStrip({required this.history});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final bid = history[index];
          return Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(bid.franchiseName, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                Text('₹${bid.amount}', style: const TextStyle(color: Colors.blue)),
              ],
            ),
          );
        },
      ),
    );
  }
}
