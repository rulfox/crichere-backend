import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'package:crichere_flutter/shared/widgets/cric/cric_widgets.dart';
import '../providers/league_repository_provider.dart';

@RoutePage()
class PreAssignmentScreen extends ConsumerWidget {
  final String leagueId;

  const PreAssignmentScreen({super.key, required this.leagueId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playersAsync = ref.watch(leaguePlayersProvider(leagueId));
    final franchisesAsync = ref.watch(leagueFranchisesProvider(leagueId));

    return Scaffold(
      backgroundColor: CricColor.appBg,
      appBar: CricAppBar(
        showLogo: false,
        title: 'PRE-ASSIGNMENT',
        leading: IconButton(
          icon: const Icon(Icons.close, color: CricColor.textPrimary),
          onPressed: () => context.router.pop(),
        ),
        actions: [
          TextButton(
            onPressed: () => context.router.pop(),
            child: Text('DONE', style: CricTextStyle.badge.copyWith(color: CricColor.gold)),
          ),
        ],
      ),
      body: playersAsync.when(
        data: (players) => franchisesAsync.when(
          data: (franchises) => Column(
            children: [
              Container(
                padding: const EdgeInsets.all(CricSpacing.base),
                color: CricColor.navyMid,
                child: Column(
                  children: [
                    Text(
                      'Assign Captains and Icons to franchises. These players will be removed from the auction pool.',
                      style: CricTextStyle.caption,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(CricSpacing.page),
                  itemCount: franchises.length,
                  itemBuilder: (context, index) {
                    final franchise = franchises[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: CricCard(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(franchise.name, style: CricTextStyle.headingMd),
                            const SizedBox(height: 12),
                            _AssignmentSlot(
                              label: '★ CAPTAIN',
                              assignedPlayer: 'Unassigned',
                              onTap: () => _showPlayerPicker(context, players, 'CAPTAIN'),
                            ),
                            const SizedBox(height: 8),
                            _AssignmentSlot(
                              label: '★ ICON',
                              assignedPlayer: 'Unassigned',
                              onTap: () => _showPlayerPicker(context, players, 'ICON'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error loading franchises: $e')),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error loading players: $e')),
      ),
    );
  }

  void _showPlayerPicker(BuildContext context, List<dynamic> players, String type) {
    showModalBottomSheet(
      context: context,
      backgroundColor: CricColor.navy,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text('SELECT $type', style: CricTextStyle.headingMd),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                final p = players[index];
                return ListTile(
                  leading: const AvatarCircle(name: '', radius: 16),
                  title: Text(p.playerName, style: CricTextStyle.body),
                  subtitle: Text('Base: ₹${p.basePriceOverride ?? 1000}', style: CricTextStyle.caption),
                  onTap: () => Navigator.pop(context),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AssignmentSlot extends StatelessWidget {
  final String label;
  final String assignedPlayer;
  final VoidCallback onTap;

  const _AssignmentSlot({required this.label, required this.assignedPlayer, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: CricColor.slate3,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: CricColor.borderMid),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: CricTextStyle.overline.copyWith(color: CricColor.gold)),
                Text(assignedPlayer, style: CricTextStyle.body),
              ],
            ),
            const Icon(Icons.add_circle_outline, color: CricColor.gold, size: 20),
          ],
        ),
      ),
    );
  }
}
