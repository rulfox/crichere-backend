import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'package:crichere_flutter/shared/widgets/cric/cric_widgets.dart';
import '../../domain/entities/league_player.dart';
import '../providers/league_repository_provider.dart';
import '../../../auction/presentation/providers/auction_provider.dart';

@RoutePage()
class PreAssignmentScreen extends HookConsumerWidget {
  final String leagueId;

  const PreAssignmentScreen({super.key, required this.leagueId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playersAsync = ref.watch(leaguePlayersProvider(leagueId));
    final franchisesAsync = ref.watch(leagueFranchisesProvider(leagueId));
    // franchiseId -> {'CAPTAIN': player, 'ICON': player}
    final selections = useState<Map<String, Map<String, LeaguePlayer?>>>({});

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
                child: Text(
                  'Assign Captains and Icons to franchises. These players will be removed from the auction pool.',
                  style: CricTextStyle.caption,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(CricSpacing.page),
                  itemCount: franchises.length,
                  itemBuilder: (context, index) {
                    final franchise = franchises[index];
                    final franchiseSelections = selections.value[franchise.id] ?? {};
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
                              assignedPlayer: franchiseSelections['CAPTAIN']?.playerName ?? 'Unassigned',
                              isAssigned: franchiseSelections['CAPTAIN'] != null,
                              onTap: () => _showPlayerPicker(
                                context, ref, players, franchise.id, 'CAPTAIN', selections,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _AssignmentSlot(
                              label: '⚡ ICON',
                              assignedPlayer: franchiseSelections['ICON']?.playerName ?? 'Unassigned',
                              isAssigned: franchiseSelections['ICON'] != null,
                              onTap: () => _showPlayerPicker(
                                context, ref, players, franchise.id, 'ICON', selections,
                              ),
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
          loading: () => const Center(child: CircularProgressIndicator(color: CricColor.gold)),
          error: (e, _) => Center(child: Text('Error loading franchises: $e', style: CricTextStyle.body.copyWith(color: CricColor.red))),
        ),
        loading: () => const Center(child: CircularProgressIndicator(color: CricColor.gold)),
        error: (e, _) => Center(child: Text('Error loading players: $e', style: CricTextStyle.body.copyWith(color: CricColor.red))),
      ),
    );
  }

  void _showPlayerPicker(
    BuildContext context,
    WidgetRef ref,
    List<LeaguePlayer> players,
    String franchiseId,
    String type,
    ValueNotifier<Map<String, Map<String, LeaguePlayer?>>> selections,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: CricColor.navy,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text('SELECT $type', style: CricTextStyle.headingMd),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: players.length,
              itemBuilder: (_, index) {
                final p = players[index];
                final isSelected = selections.value[franchiseId]?[type]?.playerId == p.playerId;
                return ListTile(
                  leading: AvatarCircle(name: p.playerName ?? '', radius: 16),
                  title: Text(p.playerName ?? 'Player ${p.playerId.substring(0, 8)}', style: CricTextStyle.body),
                  subtitle: Text('Base: ₹${p.basePriceOverride ?? 1000}', style: CricTextStyle.caption),
                  trailing: isSelected ? const Icon(Icons.check_circle, color: CricColor.green) : null,
                  onTap: () async {
                    Navigator.pop(ctx);
                    try {
                      await ref.read(auctionRepositoryProvider).preAssign(
                        leagueId,
                        p.playerId,
                        franchiseId,
                        type,
                      );
                      // Update local state to reflect the selection
                      final updated = Map<String, Map<String, LeaguePlayer?>>.from(selections.value);
                      updated[franchiseId] = Map<String, LeaguePlayer?>.from(updated[franchiseId] ?? {});
                      updated[franchiseId]![type] = p;
                      selections.value = updated;
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to assign: $e')),
                        );
                      }
                    }
                  },
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
  final bool isAssigned;
  final VoidCallback onTap;

  const _AssignmentSlot({
    required this.label,
    required this.assignedPlayer,
    required this.isAssigned,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: CricColor.slate3,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isAssigned ? CricColor.green.withValues(alpha: 0.4) : CricColor.borderMid),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: CricTextStyle.overline.copyWith(color: CricColor.gold)),
                Text(
                  assignedPlayer,
                  style: CricTextStyle.body.copyWith(color: isAssigned ? CricColor.textPrimary : CricColor.textDim),
                ),
              ],
            ),
            Icon(
              isAssigned ? Icons.check_circle : Icons.add_circle_outline,
              color: isAssigned ? CricColor.green : CricColor.gold,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
