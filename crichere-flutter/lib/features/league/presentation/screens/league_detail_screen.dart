import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'package:crichere_flutter/shared/widgets/cric/cric_widgets.dart';
import '../providers/league_repository_provider.dart';
import '../providers/waitlist_providers.dart';
import '../../../../core/router/app_router.gr.dart';
import 'package:crichere_flutter/features/league/domain/entities/league.dart' as domain;
import 'package:crichere_flutter/features/franchise/presentation/providers/franchise_providers.dart';
import 'package:crichere_flutter/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:crichere_flutter/shared/widgets/user_picker.dart';

@RoutePage()
class LeagueDetailScreen extends ConsumerWidget {
  final String leagueId;

  const LeagueDetailScreen({super.key, required this.leagueId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaguesAsync = ref.watch(leaguesProvider);

    return leaguesAsync.when(
      data: (leagues) {
        final league = leagues.firstWhere(
          (e) => e.id == leagueId,
          orElse: () => throw StateError('League $leagueId not found'),
        );
        return DefaultTabController(
          length: 5,
          child: Scaffold(
            backgroundColor: CricColor.appBg,
            appBar: CricAppBar(
              showLogo: false,
              title: league.name.toUpperCase(),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: CricColor.textPrimary),
                onPressed: () => context.router.pop(),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.share_outlined, color: CricColor.gold),
                  onPressed: () => SharePlus.instance.share(
                    ShareParams(text: 'Check out ${league.name} on Crichere! https://crichere.com'),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Container(
                  color: CricColor.navyMid,
                  child: TabBar(
                    indicatorColor: CricColor.gold,
                    labelColor: CricColor.gold,
                    unselectedLabelColor: CricColor.textFaint,
                    labelStyle: CricTextStyle.badge,
                    isScrollable: true,
                    tabs: const [
                      Tab(text: 'OVERVIEW'),
                      Tab(text: 'PLAYERS'),
                      Tab(text: 'FRANCHISES'),
                      Tab(text: 'WAITLIST'),
                      Tab(text: 'SCHEDULE'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _OverviewTab(league: league),
                      _PlayersTab(leagueId: leagueId),
                      _FranchisesTab(leagueId: leagueId),
                      _WaitlistTab(leagueId: leagueId),
                      _ScheduleTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Scaffold(
        backgroundColor: CricColor.appBg,
        body: Center(child: CircularProgressIndicator(color: CricColor.gold)),
      ),
      error: (err, stack) => Scaffold(
        backgroundColor: CricColor.appBg,
        body: Center(child: Text('Error: $err', style: const TextStyle(color: Colors.red))),
      ),
    );
  }
}

class _OverviewTab extends ConsumerWidget {
  final domain.League league;

  const _OverviewTab({required this.league});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(CricSpacing.page),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CricCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                if (league.bannerUrl != null)
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(CricRadius.card)),
                    child: Image.network(
                      league.bannerUrl!,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  Container(
                    height: 120,
                    width: double.infinity,
                    color: CricColor.slate3,
                    child: const Icon(Icons.image_outlined, color: CricColor.textFaint, size: 40),
                  ),
                Padding(
                  padding: const EdgeInsets.all(CricSpacing.base),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          StatusChip(type: StatusChip.fromLeagueStatus(league.status)),
                          const SizedBox(width: CricSpacing.sm),
                          Text('Organised by ${league.createdBy}', style: CricTextStyle.caption),
                        ],
                      ),
                      const SizedBox(height: CricSpacing.md),
                      Text(league.name, style: CricTextStyle.displayLg.copyWith(fontSize: 24)),
                      const SizedBox(height: CricSpacing.md),
                      Text(
                        '${league.format ?? 'Cricket'} league · Real-time auction bidding',
                        style: CricTextStyle.body,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: CricSpacing.xl),
          if (league.status == 'DRAFT')
            Padding(
              padding: const EdgeInsets.only(bottom: CricSpacing.md),
              child: ElevatedButton.icon(
                onPressed: () async {
                  try {
                    await ref.read(leagueRepositoryProvider).updateLeagueStatus(league.id, 'OPEN');
                    ref.invalidate(leaguesProvider);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('League published! Players can now register.')),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }
                },
                icon: const Icon(Icons.publish, size: 18),
                label: const Text('PUBLISH LEAGUE'),
                style: CricButtonStyle.primary.copyWith(
                  minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 50)),
                  backgroundColor: const WidgetStatePropertyAll(CricColor.green),
                ),
              ),
            ),
          ElevatedButton(
            onPressed: () {
              if (league.currentAuctionId != null) {
                context.router.push(LiveAuctionViewerRoute(auctionId: league.currentAuctionId!));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Auction not initialized yet.')),
                );
              }
            },
            style: CricButtonStyle.primary.copyWith(
              minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 50)),
            ),
            child: const Text('🚪 ENTER AUCTION ROOM'),
          ),
          const SizedBox(height: CricSpacing.md),
          OutlinedButton(
            onPressed: () async {
              try {
                await ref.read(leagueRepositoryProvider).joinWaitlist(league.id);
                ref.invalidate(waitlistProvider(league.id));
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('You have joined the waitlist!')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              }
            },
            style: CricButtonStyle.ghost.copyWith(
              minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 50)),
            ),
            child: const Text('🏏 REGISTER AS PLAYER'),
          ),
          const SizedBox(height: CricSpacing.xxl),
          Text('QUICK ACTIONS', style: CricTextStyle.overline),
          const SizedBox(height: CricSpacing.md),
          Row(
            children: [
              Expanded(
                child: CricCard(
                  onTap: () {
                    if (league.currentAuctionId != null) {
                      context.router.push(AuctioneerPanelRoute(auctionId: league.currentAuctionId!, leagueId: league.id));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Auction not initialized yet.')),
                      );
                    }
                  },
                  child: Column(
                    children: [
                      const Icon(Icons.gavel, color: CricColor.gold),
                      const SizedBox(height: CricSpacing.sm),
                      Text('AUCTIONEER', style: CricTextStyle.badge),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: CricSpacing.md),
              Expanded(
                child: CricCard(
                  onTap: () => context.router.push(FeeManagementRoute(leagueId: league.id)),
                  child: Column(
                    children: [
                      const Icon(Icons.payments_outlined, color: CricColor.green),
                      const SizedBox(height: CricSpacing.sm),
                      Text('FEES', style: CricTextStyle.badge),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: CricSpacing.md),
              Expanded(
                child: CricCard(
                  onTap: () => context.router.push(ForfeitManagementRoute(leagueId: league.id)),
                  child: Column(
                    children: [
                      const Icon(Icons.person_off_outlined, color: CricColor.red),
                      const SizedBox(height: CricSpacing.sm),
                      Text('FORFEITS', style: CricTextStyle.badge),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: CricSpacing.md),
              Expanded(
                child: CricCard(
                  onTap: () => context.router.push(PreAssignmentRoute(leagueId: league.id)),
                  child: Column(
                    children: [
                      const Icon(Icons.stars_outlined, color: CricColor.purple),
                      const SizedBox(height: CricSpacing.sm),
                      Text('PRE-ASSIGN', style: CricTextStyle.badge),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: CricSpacing.md),
              Expanded(
                child: CricCard(
                  onTap: () => context.router.push(PricingRoute(leagueId: league.id)),
                  child: Column(
                    children: [
                      const Icon(Icons.sell_outlined, color: CricColor.blue),
                      const SizedBox(height: CricSpacing.sm),
                      Text('PRICING', style: CricTextStyle.badge),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: CricSpacing.md),
              Expanded(
                child: CricCard(
                  onTap: () {
                    DefaultTabController.of(context).animateTo(3);
                  },
                  child: Column(
                    children: [
                      const Icon(Icons.list_alt_outlined, color: CricColor.cyan),
                      const SizedBox(height: CricSpacing.sm),
                      Text('WAITLIST', style: CricTextStyle.badge),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WaitlistTab extends ConsumerWidget {
  final String leagueId;
  const _WaitlistTab({required this.leagueId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final waitlistAsync = ref.watch(waitlistProvider(leagueId));
    final leagueRepo = ref.watch(leagueRepositoryProvider);

    return waitlistAsync.when(
      data: (entries) {
        if (entries.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.group_add_outlined, size: 48, color: CricColor.textFaint),
                const SizedBox(height: 16),
                Text('Waitlist is empty', style: CricTextStyle.body),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    await leagueRepo.joinWaitlist(leagueId);
                    ref.invalidate(waitlistProvider(leagueId));
                  },
                  style: CricButtonStyle.primary,
                  child: const Text('JOIN WAITLIST'),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(CricSpacing.page),
          itemCount: entries.length,
          itemBuilder: (context, index) {
            final entry = entries[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: CricSpacing.sm),
              child: CricCard(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: CricColor.slate3,
                    child: Text('${entry.position}', style: CricTextStyle.badge.copyWith(color: CricColor.gold)),
                  ),
                  title: Text('User ${entry.userId.substring(0, 8)}…', style: CricTextStyle.headingMd),
                  subtitle: Text('Joined ${entry.createdAt.toString().split(' ')[0]}', style: CricTextStyle.caption),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.upgrade, color: CricColor.green),
                        onPressed: () async {
                          await leagueRepo.promoteFromWaitlist(leagueId, entry.id);
                          ref.invalidate(waitlistProvider(leagueId));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline, color: CricColor.red),
                        onPressed: () async {
                          await leagueRepo.withdrawFromWaitlist(leagueId, entry.id);
                          ref.invalidate(waitlistProvider(leagueId));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator(color: CricColor.gold)),
      error: (e, _) => CricErrorView(error: e),
    );
  }
}

class _PlayersTab extends ConsumerWidget {
  final String leagueId;
  const _PlayersTab({required this.leagueId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playersAsync = ref.watch(leaguePlayersProvider(leagueId));

    return playersAsync.when(
      data: (players) => ListView.builder(
        padding: const EdgeInsets.all(CricSpacing.page),
        itemCount: players.length,
        itemBuilder: (context, index) {
          final player = players[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: CricSpacing.sm),
            child: CricCard(
              child: Row(
                children: [
                  const AvatarCircle(name: 'Player', radius: 18),
                  const SizedBox(width: CricSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(player.playerName ?? 'Player ${player.playerId.substring(0, 8)}', style: CricTextStyle.headingMd),
                        Text('Base: ₹${player.basePriceOverride ?? "1k"}', style: CricTextStyle.caption),
                      ],
                    ),
                  ),
                  const CricBadge(label: 'AVAILABLE', type: CricBadgeType.green),
                ],
              ),
            ),
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator(color: CricColor.gold)),
      error: (e, _) => CricErrorView(error: e),
    );
  }
}

class _FranchisesTab extends ConsumerWidget {
  final String leagueId;
  const _FranchisesTab({required this.leagueId});

  Future<void> _showCreateDialog(BuildContext context, WidgetRef ref) async {
    final nameController = TextEditingController();
    final purseController = TextEditingController(text: '40000');
    final owner = ValueNotifier<({String id, String label})?>(null);
    final saving = ValueNotifier(false);

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: CricColor.slate2,
        title: Text('Create Franchise', style: CricTextStyle.headingMd),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              style: CricTextStyle.body,
              decoration: CricDecoration.textField(hint: 'Franchise name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: purseController,
              keyboardType: TextInputType.number,
              style: CricTextStyle.body,
              decoration: CricDecoration.textField(hint: 'Total purse (₹)'),
            ),
            const SizedBox(height: 12),
            ValueListenableBuilder(
              valueListenable: owner,
              builder: (context, value, _) => OutlinedButton.icon(
                icon: const Icon(Icons.person_outline, size: 18, color: CricColor.gold),
                label: Text(
                  value?.label ?? 'Choose owner',
                  style: CricTextStyle.body.copyWith(
                    color: value == null ? CricColor.textDim : CricColor.textPrimary,
                  ),
                ),
                onPressed: () async {
                  final picked = await showUserPicker(
                    context,
                    ref.read(authRepositoryProvider),
                    title: 'Select franchise owner',
                  );
                  if (picked?.userId != null) {
                    owner.value = (id: picked!.userId!, label: picked.name ?? picked.phone ?? picked.userId!);
                  }
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('CANCEL', style: CricTextStyle.badge.copyWith(color: CricColor.textDim)),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: saving,
            builder: (context, isSaving, _) => ElevatedButton(
              style: CricButtonStyle.primary,
              onPressed: isSaving
                  ? null
                  : () async {
                      final name = nameController.text.trim();
                      final purse = int.tryParse(purseController.text.trim());
                      final ownerId = owner.value?.id;
                      if (name.isEmpty || purse == null || ownerId == null) {
                        ScaffoldMessenger.of(dialogContext).showSnackBar(
                          const SnackBar(content: Text('Name, purse and owner are required.')),
                        );
                        return;
                      }
                      saving.value = true;
                      try {
                        await ref.read(franchiseRepositoryProvider).createFranchise(
                              leagueId: leagueId,
                              name: name,
                              ownerId: ownerId,
                              totalPurse: purse,
                            );
                        ref.invalidate(leagueFranchisesProvider(leagueId));
                        if (dialogContext.mounted) Navigator.pop(dialogContext);
                      } catch (e) {
                        saving.value = false;
                        if (dialogContext.mounted) {
                          ScaffoldMessenger.of(dialogContext)
                              .showSnackBar(SnackBar(content: Text('Create failed: $e')));
                        }
                      }
                    },
              child: isSaving
                  ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('CREATE'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final franchisesAsync = ref.watch(leagueFranchisesProvider(leagueId));

    return franchisesAsync.when(
      data: (franchises) => ListView.builder(
        padding: const EdgeInsets.all(CricSpacing.page),
        itemCount: franchises.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: CricSpacing.md),
              child: OutlinedButton.icon(
                icon: const Icon(Icons.add, color: CricColor.gold),
                label: const Text('CREATE FRANCHISE'),
                style: CricButtonStyle.ghost,
                onPressed: () => _showCreateDialog(context, ref),
              ),
            );
          }
          final franchise = franchises[index - 1];
          return Padding(
            padding: const EdgeInsets.only(bottom: CricSpacing.md),
            child: CricCard(
              onTap: () => context.router.push(FranchiseSquadRoute(franchiseId: franchise.id)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: CricColor.slate3,
                          borderRadius: CricRadius.cardAll,
                        ),
                        child: const Icon(Icons.shield, color: CricColor.blue),
                      ),
                      const SizedBox(width: CricSpacing.md),
                      Expanded(
                        child: Text(franchise.name, style: CricTextStyle.headingMd),
                      ),
                      const Icon(Icons.chevron_right, color: CricColor.textDim),
                    ],
                  ),
                  const SizedBox(height: CricSpacing.lg),
                  PurseBar(spent: franchise.startingPurse - franchise.currentPurse, total: franchise.startingPurse),
                ],
              ),
            ),
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator(color: CricColor.gold)),
      error: (e, _) => CricErrorView(error: e),
    );
  }
}

class _ScheduleTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Schedule coming soon...', style: TextStyle(color: Colors.white)));
  }
}
