import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/league_repository_provider.dart';
import '../../../../core/router/app_router.gr.dart';

@RoutePage()
class LeagueDetailScreen extends ConsumerWidget {
  final String leagueId;

  const LeagueDetailScreen({super.key, required this.leagueId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaguesAsync = ref.watch(leaguesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('League Details')),
      body: leaguesAsync.when(
        data: (leagues) {
          final league = leagues.firstWhere((e) => e.id == leagueId);
          return Column(
            children: [
              if (league.logoUrl != null) Image.network(league.logoUrl!),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(league.name, style: Theme.of(context).textTheme.headlineMedium),
              ),
              Text('Status: ${league.status}'),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => context.router.push(LiveAuctionViewerRoute(auctionId: leagueId)),
                child: const Text('WATCH LIVE AUCTION'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.router.push(AuctioneerPanelRoute(auctionId: leagueId)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
                child: const Text('AUCTIONEER PANEL (WEB)'),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
