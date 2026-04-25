import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/league_repository_provider.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaguesAsync = ref.watch(leaguesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Crichere Leagues')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(leaguesProvider.future),
        child: leaguesAsync.when(
          data: (leagues) => ListView.builder(
            itemCount: leagues.length,
            itemBuilder: (context, index) {
              final league = leagues[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: league.logoUrl != null 
                    ? Image.network(league.logoUrl!) 
                    : const Icon(Icons.sports_cricket),
                  title: Text(league.name),
                  subtitle: Text('Status: ${league.status}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // context.router.push(LeagueDetailRoute(leagueId: league.id));
                  },
                ),
              );
            },
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}
