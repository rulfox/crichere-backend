import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class AuctioneerPanelScreen extends ConsumerWidget {
  final String auctionId;

  const AuctioneerPanelScreen({super.key, required this.auctionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auctioneer Panel')),
      body: Row(
        children: [
          // Left Column: Player Pool
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[200],
              child: const Center(child: Text('Player Pool')),
            ),
          ),
          // Right Column: Control Panel
          Expanded(
            flex: 2,
            child: Column(
              children: [
                const Expanded(child: Center(child: Text('Current Player & Bidding'))),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: () {}, child: const Text('RECORD BID')),
                      ElevatedButton(
                        onPressed: () {}, 
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        child: const Text('SOLD'),
                      ),
                      ElevatedButton(
                        onPressed: () {}, 
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                        child: const Text('UNSOLD'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
