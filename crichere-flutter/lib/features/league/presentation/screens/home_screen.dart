import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'package:crichere_flutter/shared/widgets/cric/cric_widgets.dart';
import '../providers/league_repository_provider.dart';
import '../../../auth/presentation/providers/auth_repository_provider.dart';
import '../../../auth/data/models/auth_response.dart';
import '../../domain/entities/league.dart' as domain;
import '../../../../core/router/app_router.gr.dart';
import '../../../../shared/widgets/shimmer_loading.dart';
import '../../../../core/network/connectivity_service.dart';
import '../../../../core/database/app_database.dart';
import 'package:drift/drift.dart' hide Column;

@RoutePage()
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(0);
    final isAdminView = useState(false);
    final leaguesAsync = ref.watch(leaguesProvider);
    final userAsync = ref.watch(currentUserProvider);
    
    // Global connectivity watcher
    ConnectivityWatcher.watch(ref, context);

    return Scaffold(
      backgroundColor: CricColor.appBg,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            return _WebDashboardLayout(
              selectedIndex: selectedIndex.value,
              onIndexChanged: (i) => selectedIndex.value = i,
              leaguesAsync: leaguesAsync,
              userAsync: userAsync,
            );
          }
          return SafeArea(
            child: IndexedStack(
              index: selectedIndex.value,
              children: [
                _HomeTab(
                  leaguesAsync: leaguesAsync, 
                  userAsync: userAsync,
                  isAdminView: isAdminView.value,
                  onToggleView: () => isAdminView.value = !isAdminView.value,
                ),
                _DiscoverTab(leaguesAsync: leaguesAsync),
                _AlertsTab(),
                _ProfileTab(userAsync: userAsync),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: MediaQuery.of(context).size.width <= 900 
          ? CricBottomNav(
              currentIndex: selectedIndex.value,
              onTap: (index) => selectedIndex.value = index,
            )
          : null,
    );
  }
}

class _WebDashboardLayout extends HookConsumerWidget {
  final int selectedIndex;
  final Function(int) onIndexChanged;
  final AsyncValue<List<domain.League>> leaguesAsync;
  final AsyncValue<AuthResponse> userAsync;

  const _WebDashboardLayout({
    required this.selectedIndex,
    required this.onIndexChanged,
    required this.leaguesAsync,
    required this.userAsync,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        // Sidebar
        Container(
          width: 260,
          color: CricColor.navy,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Padding(
              padding: EdgeInsets.all(24),
                child: Text('🏏 CRICHERE', style: CricTextStyle.logo),
              ),
              const _SidebarSection(title: 'MAIN'),
              _SidebarItem(icon: Icons.home_outlined, label: 'Dashboard', isSelected: selectedIndex == 0, onTap: () => onIndexChanged(0)),
              _SidebarItem(icon: Icons.explore_outlined, label: 'Discover', isSelected: selectedIndex == 1, onTap: () => onIndexChanged(1)),
              const SizedBox(height: 16),
              const _SidebarSection(title: 'MANAGEMENT'),
              _SidebarItem(
                icon: Icons.account_balance_wallet_outlined,
                label: 'Fees & Forfeits',
                onTap: () {
                  final leagues = leaguesAsync.asData?.value;
                  if (leagues != null && leagues.isNotEmpty) {
                    context.router.push(FeeManagementRoute(leagueId: leagues.first.id));
                  }
                },
              ),
              _SidebarItem(
                icon: Icons.admin_panel_settings_outlined, 
                label: 'Platform Admin', 
                onTap: () => context.router.push(const PlatformAdminRoute()),
              ),
              const Spacer(),
              _SidebarItem(icon: Icons.notifications_none, label: 'Alerts', isSelected: selectedIndex == 2, onTap: () => onIndexChanged(2)),
              _SidebarItem(icon: Icons.person_outline, label: 'Profile', isSelected: selectedIndex == 3, onTap: () => onIndexChanged(3)),
              const SizedBox(height: 24),
            ],
          ),
        ),
        // Content
        Expanded(
          child: IndexedStack(
            index: selectedIndex,
            children: [
              _HomeTab(leaguesAsync: leaguesAsync, userAsync: userAsync, isAdminView: true, isWeb: true),
              _DiscoverTab(leaguesAsync: leaguesAsync),
              _AlertsTab(),
              _ProfileTab(userAsync: userAsync),
            ],
          ),
        ),
      ],
    );
  }
}

class _SidebarSection extends StatelessWidget {
  final String title;
  const _SidebarSection({required this.title});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    child: Text(title, style: CricTextStyle.overline.copyWith(color: CricColor.textFaint)),
  );
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const _SidebarItem({required this.icon, required this.label, this.isSelected = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: isSelected ? CricColor.gold : CricColor.textDim, size: 20),
      title: Text(label, style: CricTextStyle.body.copyWith(color: isSelected ? CricColor.textPrimary : CricColor.textDim, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
      onTap: onTap,
      dense: true,
      selected: isSelected,
      selectedTileColor: CricColor.gold.withValues(alpha: 0.1),
    );
  }
}

class _HomeTab extends ConsumerWidget {
  final AsyncValue<List<domain.League>> leaguesAsync;
  final AsyncValue<AuthResponse> userAsync;
  final bool isAdminView;
  final VoidCallback? onToggleView;
  final bool isWeb;

  const _HomeTab({
    required this.leaguesAsync, 
    required this.userAsync, 
    this.isAdminView = false, 
    this.onToggleView,
    this.isWeb = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () => ref.refresh(leaguesProvider.future),
      color: CricColor.gold,
      backgroundColor: CricColor.slate2,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(CricSpacing.page),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(isWeb ? 'Welcome back,' : 'Good evening,', style: CricTextStyle.caption),
                          userAsync.when(
                            data: (user) => Text(
                              user.name ?? 'Player',
                              style: CricTextStyle.headingMd.copyWith(fontSize: 18),
                            ),
                            loading: () => const Text('...', style: TextStyle(color: Colors.white)),
                            error: (e, s) => const Text('Player', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          if (!isWeb)
                            TextButton.icon(
                              onPressed: onToggleView,
                              icon: Icon(isAdminView ? Icons.person_outline : Icons.admin_panel_settings_outlined, color: CricColor.gold, size: 18),
                              label: Text(isAdminView ? 'PLAYER' : 'ADMIN', style: CricTextStyle.badge.copyWith(color: CricColor.gold)),
                            ),
                          const SizedBox(width: 8),
                          userAsync.when(
                            data: (user) => AvatarCircle(name: user.name ?? '', radius: 22),
                            loading: () => const CircleAvatar(radius: 22, backgroundColor: CricColor.slate3),
                            error: (e, s) => const CircleAvatar(radius: 22, backgroundColor: CricColor.slate3),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: CricSpacing.xxl),
                  
                  if (isAdminView) _AdminOverview(leaguesAsync: leaguesAsync) else _PlayerOverview(leaguesAsync: leaguesAsync),
                ],
              ),
            ),
          ),
          
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

class _PlayerOverview extends StatelessWidget {
  final AsyncValue<List<domain.League>> leaguesAsync;
  const _PlayerOverview({required this.leaguesAsync});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'LIVE NOW'),
        leaguesAsync.when(
          data: (leagues) {
            final liveLeague = leagues.where((l) => l.status == 'AUCTION_LIVE').firstOrNull;
            if (liveLeague == null) {
              return CricCard(
                padding: const EdgeInsets.all(CricSpacing.base),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: CricSpacing.md),
                    child: Text('No live auctions right now', style: CricTextStyle.body.copyWith(color: CricColor.textDim)),
                  ),
                ),
              );
            }
            return CricCard(
              padding: const EdgeInsets.all(CricSpacing.base),
              onTap: () => context.router.push(LiveAuctionViewerRoute(auctionId: liveLeague.id)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const StatusChip(type: StatusType.live),
                  const SizedBox(height: CricSpacing.md),
                  Text(liveLeague.name, style: CricTextStyle.displayLg.copyWith(fontSize: 24)),
                  const SizedBox(height: CricSpacing.xs),
                  Text('Auction in progress · Tap to join', style: CricTextStyle.body),
                ],
              ),
            );
          },
          loading: () => ShimmerLoading.rectangular(height: 80),
          error: (_, __) => const SizedBox.shrink(),
        ),
        const SizedBox(height: CricSpacing.lg),
        const SectionHeader(title: 'MY LEAGUES', actionLabel: 'See all'),
        leaguesAsync.when(
          data: (leagues) => Column(
            children: leagues.map((league) => Padding(
              padding: const EdgeInsets.only(bottom: CricSpacing.sm),
              child: CricCard(
                onTap: () => context.router.push(LeagueDetailRoute(leagueId: league.id)),
                child: Row(
                  children: [
                    const Icon(Icons.sports_cricket, color: CricColor.gold),
                    const SizedBox(width: CricSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(league.name, style: CricTextStyle.headingMd),
                          Text(league.status.toUpperCase(), style: CricTextStyle.caption),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: CricColor.textFaint),
                  ],
                ),
              ),
            )).toList(),
          ),
          loading: () => ShimmerLoading.rectangular(height: 100),
          error: (e, _) => Text('Error: $e'),
        ),
      ],
    );
  }
}

class _AdminOverview extends StatelessWidget {
  final AsyncValue<List<domain.League>> leaguesAsync;
  const _AdminOverview({required this.leaguesAsync});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Fee Alert Banner
        CricCard(
          color: CricColor.red.withValues(alpha: 0.1),
          borderColor: CricColor.red.withValues(alpha: 0.3),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: CricColor.red),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('FEE PAYMENTS DUE', style: CricTextStyle.badge.copyWith(color: CricColor.red)),
                    Text('Pending payments in your leagues', style: CricTextStyle.caption),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  final leagues = leaguesAsync.asData?.value;
                  if (leagues != null && leagues.isNotEmpty) {
                    context.router.push(FeeManagementRoute(leagueId: leagues.first.id));
                  }
                },
                child: Text('VIEW →', style: CricTextStyle.badge.copyWith(color: CricColor.red)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const SectionHeader(title: 'MY MANAGED LEAGUES'),
        leaguesAsync.when(
          data: (leagues) => Column(
            children: leagues.map((league) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: CricCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(league.name, style: CricTextStyle.headingMd),
                        CricBadge(label: league.status, type: league.status == 'AUCTION_LIVE' ? CricBadgeType.red : CricBadgeType.gold),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _AdminAction(icon: Icons.settings_outlined, label: 'MANAGE', onTap: () => context.router.push(LeagueDetailRoute(leagueId: league.id))),
                        _AdminAction(icon: Icons.gavel_outlined, label: 'AUCTION', onTap: () => context.router.push(AuctioneerPanelRoute(auctionId: league.id))),
                        _AdminAction(icon: Icons.edit_outlined, label: 'EDIT', onTap: () => context.router.push(LeagueDetailRoute(leagueId: league.id))),
                      ],
                    ),
                  ],
                ),
              ),
            )).toList(),
          ),
          loading: () => ShimmerLoading.rectangular(height: 100),
          error: (e, _) => Text('Error: $e'),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () => context.router.push(const LeagueCreateRoute()),
          icon: const Icon(Icons.add, size: 18),
          label: const Text('CREATE NEW LEAGUE'),
          style: CricButtonStyle.primary.copyWith(
            minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 48)),
          ),
        ),
      ],
    );
  }
}

class _AdminAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _AdminAction({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Icon(icon, color: CricColor.gold, size: 20),
            const SizedBox(height: 4),
            Text(label, style: CricTextStyle.caption.copyWith(fontSize: 10, color: CricColor.gold)),
          ],
        ),
      ),
    );
  }
}

class _DiscoverTab extends StatelessWidget {
  final AsyncValue<List<domain.League>> leaguesAsync;
  const _DiscoverTab({required this.leaguesAsync});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(CricSpacing.page),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Discover Leagues', style: CricTextStyle.displayLg.copyWith(fontSize: 24)),
              const SizedBox(height: 16),
              TextField(
                style: CricTextStyle.body,
                decoration: CricDecoration.textField(
                  hint: 'Search leagues, cities, formats...',
                  prefix: const Icon(Icons.search, color: CricColor.textFaint),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: leaguesAsync.when(
            data: (leagues) {
              final live = leagues.where((l) => l.status == 'AUCTION_LIVE').toList();
              final upcoming = leagues.where((l) => l.status != 'AUCTION_LIVE' && l.status != 'COMPLETED').toList();

              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: CricSpacing.page),
                children: [
                  if (live.isNotEmpty) ...[
                    const SectionHeader(title: '🔴 LIVE NOW'),
                    ...live.map((l) => _LeagueDiscoveryCard(league: l)),
                  ],
                  const SizedBox(height: CricSpacing.lg),
                  const SectionHeader(title: 'UPCOMING AUCTIONS'),
                  ...upcoming.map((l) => _LeagueDiscoveryCard(league: l)),
                  const SizedBox(height: 100),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
          ),
        ),
      ],
    );
  }
}

class _LeagueDiscoveryCard extends StatelessWidget {
  final domain.League league;
  const _LeagueDiscoveryCard({required this.league});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: CricSpacing.md),
      child: CricCard(
        onTap: () => context.router.push(LeagueDetailRoute(leagueId: league.id)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const AvatarCircle(name: '', radius: 18),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(league.name, style: CricTextStyle.headingMd),
                      Text('Mumbai · 6 franchises', style: CricTextStyle.caption),
                    ],
                  ),
                ),
                CricBadge(
                  label: league.status == 'AUCTION_LIVE' ? 'LIVE' : 'OPEN',
                  type: league.status == 'AUCTION_LIVE' ? CricBadgeType.red : CricBadgeType.blue,
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (league.status == 'AUCTION_LIVE')
              const StatusChip(type: StatusType.live, customLabel: '47 watching')
            else
              Text('⏱ Jun 15 · Purse ₹40k', style: CricTextStyle.caption.copyWith(color: CricColor.gold)),
          ],
        ),
      ),
    );
  }
}

class _AlertsTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(appDatabaseProvider);
    final notificationsStream = db.select(db.notifications).watch();

    return Column(
      children: [
        const SectionHeader(title: ' ALERTS'),
        Expanded(
          child: StreamBuilder<List<Notification>>(
            stream: notificationsStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
              final alerts = snapshot.data!;
              if (alerts.isEmpty) {
                return const Center(child: Text('No new alerts', style: TextStyle(color: Colors.white)));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(CricSpacing.page),
                itemCount: alerts.length,
                itemBuilder: (context, index) {
                  final a = alerts[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: CricSpacing.sm),
                    child: CricCard(
                      child: ListTile(
                        leading: Icon(a.isRead ? Icons.notifications_none : Icons.notifications_active, color: a.isRead ? CricColor.textFaint : CricColor.gold),
                        title: Text(a.title, style: CricTextStyle.headingMd),
                        subtitle: Text(a.message, style: CricTextStyle.caption),
                        onTap: () => (db.update(db.notifications)..where((t) => t.id.equals(a.id))).write(const NotificationsCompanion(isRead: Value(true))),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ProfileTab extends ConsumerWidget {
  final AsyncValue<AuthResponse> userAsync;

  const _ProfileTab({required this.userAsync});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(CricSpacing.page),
      child: Column(
        children: [
          const SectionHeader(title: 'PROFILE'),
          userAsync.when(
            data: (user) => CricCard(
              child: Column(
                children: [
                  AvatarCircle(name: user.name ?? '', radius: 40),
                  const SizedBox(height: CricSpacing.md),
                  Text(user.name ?? 'Player', style: CricTextStyle.headingMd),
                  Text(user.phone ?? '', style: CricTextStyle.caption),
                  const SizedBox(height: CricSpacing.xl),
                  ListTile(
                    leading: const Icon(Icons.edit, color: CricColor.gold),
                    title: const Text('Edit Cricket Profile', style: TextStyle(color: Colors.white)),
                    onTap: () => context.router.push(const ProfileEditRoute()),
                  ),
                  ListTile(
                    leading: const Icon(Icons.admin_panel_settings, color: CricColor.cyan),
                    title: const Text('Platform Admin Dashboard', style: TextStyle(color: Colors.white)),
                    onTap: () => context.router.push(const PlatformAdminRoute()),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: CricColor.red),
                    title: const Text('Logout', style: TextStyle(color: Colors.white)),
                    onTap: () async {
                      await ref.read(authRepositoryProvider).logout();
                      if (context.mounted) {
                        context.router.replaceAll([const PhoneEntryRoute()]);
                      }
                    },
                  ),
                ],
              ),
            ),
            loading: () => ShimmerLoading.rectangular(height: 200),
            error: (e, s) => Text('Error loading profile: $e'),
          ),
        ],
      ),
    );
  }
}
