import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'package:crichere_flutter/shared/widgets/cric/cric_widgets.dart';
import '../providers/admin_providers.dart';
import '../../../../features/league/domain/entities/league.dart';
import '../../../../core/router/app_router.gr.dart';

@RoutePage()
class PlatformAdminScreen extends ConsumerWidget {
  const PlatformAdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsync = ref.watch(platformMetricsProvider);
    final leaguesAsync = ref.watch(adminLeaguesProvider);

    return Scaffold(
      backgroundColor: CricColor.appBg,
      appBar: const CricAppBar(
        showLogo: true,
        title: 'PLATFORM ADMIN DASHBOARD',
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 900;
          return Padding(
            padding: const EdgeInsets.all(CricSpacing.page),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Metrics Overview
                metricsAsync.when(
                  data: (metrics) => GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: isWide ? 4 : 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: isWide ? 2.5 : 2,
                    children: [
                      _MetricCard(label: 'Total Users', value: metrics.totalUsers.toString(), icon: Icons.people_outline),
                      _MetricCard(label: 'Active Leagues', value: metrics.activeLeagues.toString(), icon: Icons.emoji_events_outlined),
                      _MetricCard(label: 'Live Auctions', value: metrics.ongoingAuctions.toString(), icon: Icons.gavel_outlined, color: CricColor.red),
                      _MetricCard(label: 'Total Revenue', value: '₹${metrics.totalRevenue}', icon: Icons.payments_outlined, color: CricColor.green),
                    ],
                  ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Error loading metrics: $e', style: CricTextStyle.body),
                ),
                
                const SizedBox(height: 32),
                const SectionHeader(title: 'GLOBAL LEAGUE MANAGEMENT'),
                const SizedBox(height: 16),
                
                // Leagues Table/List
                Expanded(
                  child: leaguesAsync.when(
                    data: (leagues) {
                      void onManage(League l) => context.router.push(LeagueDetailRoute(leagueId: l.id));
                      void onSuspend(League l) async {
                        try {
                          await ref.read(adminRepositoryProvider).suspendLeague(l.id, true, null);
                          ref.invalidate(adminLeaguesProvider);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${l.name} has been suspended.')),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                          }
                        }
                      }
                      return isWide
                        ? _LeaguesTable(leagues: leagues, onManage: onManage, onSuspend: onSuspend)
                        : _LeaguesListView(leagues: leagues, onManage: onManage, onSuspend: onSuspend);
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Text('Error loading leagues: $e', style: CricTextStyle.body),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? color;

  const _MetricCard({required this.label, required this.value, required this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return CricCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (color ?? CricColor.gold).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color ?? CricColor.gold, size: 24),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label, style: CricTextStyle.overline.copyWith(fontSize: 10)),
              const SizedBox(height: 4),
              Text(value, style: CricTextStyle.displayLg.copyWith(fontSize: 20, color: color)),
            ],
          ),
        ],
      ),
    );
  }
}

class _LeaguesTable extends StatelessWidget {
  final List<League> leagues;
  final void Function(League) onManage;
  final void Function(League) onSuspend;
  const _LeaguesTable({required this.leagues, required this.onManage, required this.onSuspend});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CricColor.navy,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: CricColor.borderLight),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: DataTable(
          headingRowColor: const WidgetStatePropertyAll(CricColor.slate2),
          columns: [
            DataColumn(label: Text('LEAGUE', style: CricTextStyle.badge)),
            DataColumn(label: Text('STATUS', style: CricTextStyle.badge)),
            DataColumn(label: Text('CREATED BY', style: CricTextStyle.badge)),
            DataColumn(label: Text('AUCTION DATE', style: CricTextStyle.badge)),
            DataColumn(label: Text('ACTIONS', style: CricTextStyle.badge)),
          ],
          rows: leagues.map((l) => DataRow(cells: [
            DataCell(Text(l.name, style: CricTextStyle.headingMd)),
            DataCell(CricBadge(label: l.status, type: l.status == 'LIVE' ? CricBadgeType.green : CricBadgeType.gold)),
            DataCell(Text(l.createdBy, style: CricTextStyle.body)),
            DataCell(Text(l.auctionDate?.toIso8601String().split('T')[0] ?? 'N/A', style: CricTextStyle.caption)),
            DataCell(Row(
              children: [
                TextButton(onPressed: () => onManage(l), child: Text('MANAGE', style: CricTextStyle.badge.copyWith(color: CricColor.gold))),
                const SizedBox(width: 8),
                TextButton(onPressed: () => onSuspend(l), child: Text('SUSPEND', style: CricTextStyle.badge.copyWith(color: CricColor.red))),
              ],
            )),
          ])).toList(),
        ),
      ),
    );
  }
}

class _LeaguesListView extends StatelessWidget {
  final List<League> leagues;
  final void Function(League) onManage;
  final void Function(League) onSuspend;
  const _LeaguesListView({required this.leagues, required this.onManage, required this.onSuspend});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: leagues.length,
      itemBuilder: (context, index) {
        final l = leagues[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: CricCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(l.name, style: CricTextStyle.headingMd),
                    CricBadge(label: l.status, type: l.status == 'LIVE' ? CricBadgeType.green : CricBadgeType.gold),
                  ],
                ),
                const SizedBox(height: 8),
                Text('By ${l.createdBy}', style: CricTextStyle.caption),
                const Divider(color: CricColor.borderLight, height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () => onSuspend(l), child: Text('SUSPEND', style: CricTextStyle.badge.copyWith(color: CricColor.red))),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      style: CricButtonStyle.primary.copyWith(
                        minimumSize: const WidgetStatePropertyAll(Size(80, 32)),
                      ),
                      onPressed: () => onManage(l),
                      child: const Text('MANAGE', style: TextStyle(fontSize: 10)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
