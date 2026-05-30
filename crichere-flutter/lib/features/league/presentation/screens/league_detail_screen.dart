import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'package:crichere_flutter/shared/widgets/cric/cric_widgets.dart';
import '../providers/league_repository_provider.dart';
import '../providers/waitlist_providers.dart';
import '../providers/pricing_providers.dart';
import '../../../../core/router/app_router.gr.dart';
import 'package:crichere_flutter/features/league/domain/entities/league.dart' as domain;
import 'package:crichere_flutter/features/franchise/presentation/providers/franchise_providers.dart';
import 'package:crichere_flutter/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:crichere_flutter/features/player/presentation/providers/player_providers.dart';
import 'package:crichere_flutter/features/auction/presentation/providers/auction_provider.dart';
import 'package:crichere_flutter/shared/widgets/user_picker.dart';

/// Humanises an enum `.name` (`allRegistered` → `All Registered`).
String _humanize(String camel) {
  final spaced = camel.replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (m) => '${m[1]} ${m[2]}');
  return spaced.isEmpty ? spaced : spaced[0].toUpperCase() + spaced.substring(1);
}

/// Humanises a SCREAMING_SNAKE_CASE string (`ADMIN_PICKS` → `Admin Picks`).
String _humanizeSnake(String snake) {
  return snake
      .split('_')
      .where((w) => w.isNotEmpty)
      .map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase())
      .join(' ');
}

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
          length: 6,
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
                      Tab(text: 'ROUNDS'),
                      Tab(text: 'WAITLIST'),
                      Tab(text: 'AUDIT'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _OverviewTab(league: league),
                      _PlayersTab(leagueId: leagueId),
                      _FranchisesTab(leagueId: leagueId),
                      _RoundsTab(league: league),
                      _WaitlistTab(leagueId: leagueId),
                      _AuditTab(league: league),
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

// ---------------------------------------------------------------------------
// Overview tab
// ---------------------------------------------------------------------------

class _OverviewTab extends ConsumerWidget {
  final domain.League league;

  const _OverviewTab({required this.league});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final franchisesAsync = ref.watch(leagueFranchisesProvider(league.id));
    final playersAsync = ref.watch(leaguePlayersProvider(league.id));

    final franchiseCount = franchisesAsync.asData?.value.length;
    final playerCount = playersAsync.asData?.value.length;
    final totalPurse = franchisesAsync.asData?.value
        .fold<int>(0, (sum, f) => sum + f.startingPurse);

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
                          Expanded(child: _OrganiserLabel(createdBy: league.createdBy)),
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
          const SizedBox(height: CricSpacing.lg),

          // KPI stats: Franchises · Players · Purse
          Row(
            children: [
              Expanded(child: _StatTile(label: 'Franchises', value: franchiseCount?.toString() ?? '—')),
              const SizedBox(width: CricSpacing.md),
              Expanded(child: _StatTile(label: 'Players', value: playerCount?.toString() ?? '—')),
              const SizedBox(width: CricSpacing.md),
              Expanded(child: _StatTile(label: 'Purse', value: totalPurse != null ? _money(totalPurse) : '—')),
            ],
          ),
          const SizedBox(height: CricSpacing.lg),

          // League Details config section
          Text('LEAGUE DETAILS', style: CricTextStyle.overline),
          const SizedBox(height: CricSpacing.md),
          CricCard(
            child: Column(
              children: [
                _DetailRow(label: 'Format', value: league.format ?? '—'),
                _DetailRow(label: 'Order mode', value: '🎲 ${_humanizeSnake(league.playerOrderMode)}'),
                _DetailRow(label: 'Waitlist mode', value: '⚡ ${_humanizeSnake(league.waitingListMode)}'),
                _DetailRow(label: 'Must sell all', value: league.mustSellAll ? 'Yes' : 'No'),
                if (league.auctionDate != null)
                  _DetailRow(label: 'Auction date', value: league.auctionDate!.toString().split(' ')[0]),
                if (league.rulesUrl != null)
                  _DetailRow(label: 'Rules', value: 'View PDF', valueColor: CricColor.gold),
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
          // State-aware: register vs waitlist vs already-in.
          _RegistrationActions(league: league),
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
            ],
          ),
        ],
      ),
    );
  }
}

/// Resolves and shows the league organiser's name. Backend only returns the
/// `createdBy` UUID, so it's fetched via `/users/{id}`.
class _OrganiserLabel extends ConsumerWidget {
  final String createdBy;
  const _OrganiserLabel({required this.createdBy});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userByIdProvider(createdBy));
    final name = userAsync.asData?.value.name;
    return Text(
      name != null ? 'By $name' : 'League organiser',
      style: CricTextStyle.caption,
      overflow: TextOverflow.ellipsis,
    );
  }
}

/// Shows the right call-to-action for the current user based on their state:
/// - already registered  → "You're registered"
/// - already on waitlist  → "On the waitlist · position #N"
/// - registration open    → "Register as Player"
/// - registration closed/full → "Join Waitlist"
/// - league not published (DRAFT) → nothing (admin publishes first)
class _RegistrationActions extends ConsumerWidget {
  final domain.League league;
  const _RegistrationActions({required this.league});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(currentUserProvider).asData?.value;
    final players = ref.watch(leaguePlayersProvider(league.id)).asData?.value;
    final waitlist = ref.watch(waitlistProvider(league.id)).asData?.value;

    // Not published yet — registration hasn't opened; nothing for players to do.
    if (league.status == 'DRAFT') return const SizedBox.shrink();

    // Essential data still loading.
    if (me == null || players == null) {
      return const SizedBox(
        height: 50,
        child: Center(child: CircularProgressIndicator(color: CricColor.gold, strokeWidth: 2)),
      );
    }

    final isRegistered = players.any((p) => p.playerId == me.id);
    if (isRegistered) {
      return const _StatusBanner(
        icon: Icons.verified,
        color: CricColor.green,
        text: 'You\'re registered for this league',
      );
    }

    final onWaitlist = waitlist != null &&
        waitlist.any((e) => e.userId == me.id && e.status == 'WAITING');
    if (onWaitlist) {
      final position = waitlist
          .firstWhere((e) => e.userId == me.id && e.status == 'WAITING')
          .position;
      return _StatusBanner(
        icon: Icons.hourglass_bottom,
        color: CricColor.cyan,
        text: 'On the waitlist · position #$position',
      );
    }

    // Room available (registration open) → register; otherwise → waitlist.
    final registrationOpen = league.status == 'OPEN';
    if (registrationOpen) {
      return OutlinedButton(
        onPressed: () => _showSelfRegisterSheet(context, ref, league),
        style: CricButtonStyle.ghost.copyWith(
          minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 50)),
        ),
        child: const Text('🏏 REGISTER AS PLAYER'),
      );
    }

    return OutlinedButton(
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
      child: const Text('⏳ JOIN WAITLIST'),
    );
  }
}

class _StatusBanner extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  const _StatusBanner({required this.icon, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: CricSpacing.base, vertical: CricSpacing.md),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: CricRadius.cardAll,
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: CricSpacing.md),
          Expanded(child: Text(text, style: CricTextStyle.body.copyWith(color: color))),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;
  const _StatTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return CricCard(
      padding: const EdgeInsets.symmetric(vertical: CricSpacing.base),
      child: Column(
        children: [
          Text(value, style: CricTextStyle.displayLg.copyWith(fontSize: 20)),
          const SizedBox(height: 2),
          Text(label.toUpperCase(), style: CricTextStyle.overline),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  const _DetailRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: CricSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: CricTextStyle.caption),
          Text(value, style: CricTextStyle.body.copyWith(color: valueColor ?? CricColor.textPrimary)),
        ],
      ),
    );
  }
}

String _money(int v) {
  if (v >= 100000) return '₹${(v / 100000).toStringAsFixed(v % 100000 == 0 ? 0 : 1)}L';
  if (v >= 1000) return '₹${(v / 1000).toStringAsFixed(v % 1000 == 0 ? 0 : 1)}k';
  return '₹$v';
}

/// Self-registration bottom sheet: registers the logged-in user into the
/// league, with category-price chips (POST /players/register).
Future<void> _showSelfRegisterSheet(BuildContext context, WidgetRef ref, domain.League league) async {
  final me = ref.read(currentUserProvider).asData?.value;
  if (me == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Still loading your profile. Try again in a moment.')),
    );
    return;
  }

  await showModalBottomSheet<void>(
    context: context,
    backgroundColor: CricColor.slate2,
    isScrollControlled: true,
    builder: (sheetContext) => Padding(
      padding: EdgeInsets.only(
        left: CricSpacing.page,
        right: CricSpacing.page,
        top: CricSpacing.lg,
        bottom: MediaQuery.of(sheetContext).viewInsets.bottom + CricSpacing.lg,
      ),
      child: _RegisterForm(
        leagueId: league.id,
        userId: me.id,
        title: 'Register as Player',
        subtitle: '${league.name} · ${me.name ?? me.phone ?? ''}',
        onDone: () {
          ref.invalidate(leaguePlayersProvider(league.id));
          Navigator.pop(sheetContext);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registered! An admin will record your fee.')),
          );
        },
      ),
    ),
  );
}

/// Shared register form with category-price chips. Used by both the admin
/// "Register Player" dialog and the self-register sheet.
class _RegisterForm extends ConsumerStatefulWidget {
  final String leagueId;
  final String? userId; // when null, an admin picks the user
  final String title;
  final String? subtitle;
  final VoidCallback onDone;

  const _RegisterForm({
    required this.leagueId,
    required this.userId,
    required this.title,
    required this.onDone,
    this.subtitle,
  });

  @override
  ConsumerState<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<_RegisterForm> {
  ({String id, String label})? _pickedUser;
  String? _category;
  int? _basePrice;
  final _tagController = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pricesAsync = ref.watch(categoryPricesProvider(widget.leagueId));
    final needsUserPick = widget.userId == null;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: CricTextStyle.headingMd),
          if (widget.subtitle != null) ...[
            const SizedBox(height: 4),
            Text(widget.subtitle!, style: CricTextStyle.caption),
          ],
          const SizedBox(height: CricSpacing.md),

          if (needsUserPick) ...[
            OutlinedButton.icon(
              icon: const Icon(Icons.person_outline, size: 18, color: CricColor.gold),
              label: Text(
                _pickedUser?.label ?? 'Choose user',
                style: CricTextStyle.body.copyWith(
                  color: _pickedUser == null ? CricColor.textDim : CricColor.textPrimary,
                ),
              ),
              onPressed: () async {
                final picked = await showUserPicker(
                  context,
                  ref.read(authRepositoryProvider),
                  title: 'Select player',
                );
                if (picked?.userId != null) {
                  setState(() => _pickedUser = (id: picked!.userId!, label: picked.name ?? picked.phone ?? picked.userId!));
                }
              },
            ),
            const SizedBox(height: CricSpacing.md),
          ],

          Text('PLAYER CATEGORY (for base price)', style: CricTextStyle.overline),
          const SizedBox(height: CricSpacing.sm),
          pricesAsync.when(
            data: (prices) {
              if (prices.isEmpty) {
                return Text('No category prices configured. Base price will default.',
                    style: CricTextStyle.caption);
              }
              return Wrap(
                spacing: CricSpacing.sm,
                runSpacing: CricSpacing.sm,
                children: prices.map((p) {
                  final selected = _category == p.category;
                  return ChoiceChip(
                    selected: selected,
                    label: Text('${p.category}  ${_money(p.price)}'),
                    labelStyle: CricTextStyle.badge.copyWith(
                      color: selected ? CricColor.navy : CricColor.textPrimary,
                    ),
                    selectedColor: CricColor.gold,
                    backgroundColor: CricColor.slate3,
                    onSelected: (_) => setState(() {
                      _category = p.category;
                      _basePrice = p.price;
                    }),
                  );
                }).toList(),
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.all(8),
              child: LinearProgressIndicator(color: CricColor.gold),
            ),
            error: (e, _) => Text('Couldn\'t load categories: $e', style: CricTextStyle.caption),
          ),
          // Tag is an admin-assigned attribute (e.g. MARQUEE), so it only
          // appears in the admin "Register Player" dialog — not when a player
          // registers themselves.
          if (needsUserPick) ...[
            const SizedBox(height: CricSpacing.md),
            TextField(
              controller: _tagController,
              style: CricTextStyle.body,
              decoration: CricDecoration.textField(hint: 'Tag (optional, e.g. MARQUEE)'),
            ),
          ],
          const SizedBox(height: CricSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('CANCEL', style: CricTextStyle.badge.copyWith(color: CricColor.textDim)),
              ),
              const SizedBox(width: CricSpacing.sm),
              ElevatedButton(
                style: CricButtonStyle.primary,
                onPressed: _saving ? null : _submit,
                child: _saving
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('✓ CONFIRM REGISTRATION'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final userId = widget.userId ?? _pickedUser?.id;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please choose a user.')),
      );
      return;
    }
    setState(() => _saving = true);
    try {
      await ref.read(playerApiProvider).registerPlayer({
        'leagueId': widget.leagueId,
        'userId': userId,
        if (_basePrice != null) 'basePrice': _basePrice,
        if (_category != null) 'category': _category,
        if (_tagController.text.trim().isNotEmpty) 'tag': _tagController.text.trim(),
      });
      widget.onDone();
    } catch (e) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Register failed: $e')));
      }
    }
  }
}

// ---------------------------------------------------------------------------
// Waitlist tab
// ---------------------------------------------------------------------------

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

// ---------------------------------------------------------------------------
// Players tab
// ---------------------------------------------------------------------------

class _PlayersTab extends ConsumerWidget {
  final String leagueId;
  const _PlayersTab({required this.leagueId});

  Future<void> _showRegisterDialog(BuildContext context, WidgetRef ref) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: CricColor.slate2,
        insetPadding: const EdgeInsets.all(CricSpacing.page),
        child: Padding(
          padding: const EdgeInsets.all(CricSpacing.base),
          child: _RegisterForm(
            leagueId: leagueId,
            userId: null,
            title: 'Register Player',
            onDone: () {
              ref.invalidate(leaguePlayersProvider(leagueId));
              Navigator.pop(dialogContext);
            },
          ),
        ),
      ),
    );
  }

  Future<void> _importCsv(BuildContext context, WidgetRef ref) async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
      withData: true,
    );
    final bytes = result?.files.single.bytes;
    if (bytes == null) return;

    // Parse CSV: first row is the header, each subsequent row a player object.
    final lines = const LineSplitter().convert(utf8.decode(bytes)).where((l) => l.trim().isNotEmpty).toList();
    if (lines.length < 2) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('CSV needs a header row and at least one player.')),
        );
      }
      return;
    }
    final headers = lines.first.split(',').map((h) => h.trim()).toList();
    final players = <Map<String, dynamic>>[];
    for (final line in lines.skip(1)) {
      final cells = line.split(',');
      final row = <String, dynamic>{};
      for (var i = 0; i < headers.length && i < cells.length; i++) {
        final key = headers[i];
        final raw = cells[i].trim();
        if (raw.isEmpty) continue;
        // basePrice-style numeric columns become ints.
        final asInt = int.tryParse(raw);
        row[key] = (key.toLowerCase().contains('price') && asInt != null) ? asInt : raw;
      }
      if (row.isNotEmpty) players.add(row);
    }

    try {
      await ref.read(leagueRepositoryProvider).importPlayers(leagueId, players);
      ref.invalidate(leaguePlayersProvider(leagueId));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Imported ${players.length} players.')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Import failed: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playersAsync = ref.watch(leaguePlayersProvider(leagueId));

    return playersAsync.when(
      data: (players) => ListView.builder(
        padding: const EdgeInsets.all(CricSpacing.page),
        itemCount: players.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: CricSpacing.md),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.person_add_alt_1, color: CricColor.gold),
                      label: const Text('REGISTER'),
                      style: CricButtonStyle.ghost,
                      onPressed: () => _showRegisterDialog(context, ref),
                    ),
                  ),
                  const SizedBox(width: CricSpacing.md),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.upload_file, color: CricColor.cyan),
                      label: const Text('BULK CSV'),
                      style: CricButtonStyle.ghost,
                      onPressed: () => _importCsv(context, ref),
                    ),
                  ),
                ],
              ),
            );
          }
          final player = players[index - 1];
          return Padding(
            padding: const EdgeInsets.only(bottom: CricSpacing.sm),
            child: CricCard(
              child: Row(
                children: [
                  AvatarCircle(name: player.playerName ?? 'Player', radius: 18),
                  const SizedBox(width: CricSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(player.playerName ?? 'Player ${player.playerId.substring(0, 8)}', style: CricTextStyle.headingMd),
                        const SizedBox(height: 2),
                        Wrap(
                          spacing: CricSpacing.xs,
                          runSpacing: 2,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            if (player.category != null)
                              CricBadge(label: player.category!, type: CricBadgeType.blue),
                            Text('Base ${_money(player.basePriceOverride ?? player.basePrice ?? 0)}',
                                style: CricTextStyle.caption),
                            Text('· ${_humanizeSnake(player.status)}',
                                style: CricTextStyle.caption.copyWith(color: CricColor.textDim)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  CricBadge(
                    label: player.auctionEligible ? 'ELIGIBLE' : 'FEE DUE',
                    type: player.auctionEligible ? CricBadgeType.green : CricBadgeType.red,
                  ),
                  _PlayerActionsMenu(leagueId: leagueId, player: player),
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

class _PlayerActionsMenu extends ConsumerWidget {
  final String leagueId;
  final dynamic player; // LeaguePlayer
  const _PlayerActionsMenu({required this.leagueId, required this.player});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: CricColor.textDim),
      color: CricColor.slate2,
      onSelected: (value) async {
        switch (value) {
          case 'eligible':
            try {
              await ref.read(leagueRepositoryProvider)
                  .updatePlayerEligibility(leagueId, player.id, !(player.auctionEligible as bool));
              ref.invalidate(leaguePlayersProvider(leagueId));
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
              }
            }
          case 'preassign':
            context.router.push(PreAssignmentRoute(leagueId: leagueId));
          case 'pay':
            context.router.push(FeeManagementRoute(leagueId: leagueId));
          case 'remove':
            try {
              await ref.read(leagueRepositoryProvider).removePlayer(leagueId, player.id);
              ref.invalidate(leaguePlayersProvider(leagueId));
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
              }
            }
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'eligible',
          child: Text(player.auctionEligible == true ? 'Mark fee due' : 'Mark eligible',
              style: CricTextStyle.body),
        ),
        PopupMenuItem(value: 'preassign', child: Text('Pre-assign', style: CricTextStyle.body)),
        PopupMenuItem(value: 'pay', child: Text('Record payment', style: CricTextStyle.body)),
        PopupMenuItem(value: 'remove', child: Text('Remove', style: CricTextStyle.body.copyWith(color: CricColor.red))),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Franchises tab
// ---------------------------------------------------------------------------

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

  Future<void> _showInviteDialog(BuildContext context, WidgetRef ref, String franchiseId, String franchiseName) async {
    final emailController = TextEditingController();
    final saving = ValueNotifier(false);

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: CricColor.slate2,
        title: Text('Invite to $franchiseName', style: CricTextStyle.headingMd),
        content: TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          style: CricTextStyle.body,
          decoration: CricDecoration.textField(hint: 'Email address'),
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
                      final email = emailController.text.trim();
                      if (email.isEmpty) {
                        ScaffoldMessenger.of(dialogContext).showSnackBar(
                          const SnackBar(content: Text('Email is required.')),
                        );
                        return;
                      }
                      saving.value = true;
                      try {
                        await ref.read(franchiseRepositoryProvider).createInvite(franchiseId, email);
                        if (dialogContext.mounted) Navigator.pop(dialogContext);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Invite sent to $email')),
                          );
                        }
                      } catch (e) {
                        saving.value = false;
                        if (dialogContext.mounted) {
                          ScaffoldMessenger.of(dialogContext)
                              .showSnackBar(SnackBar(content: Text('Invite failed: $e')));
                        }
                      }
                    },
              child: isSaving
                  ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('SEND INVITE'),
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
                      TextButton.icon(
                        icon: const Icon(Icons.mail_outline, size: 16, color: CricColor.gold),
                        label: Text('INVITE', style: CricTextStyle.badge.copyWith(color: CricColor.gold)),
                        onPressed: () => _showInviteDialog(context, ref, franchise.id, franchise.name),
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

// ---------------------------------------------------------------------------
// Rounds tab
// ---------------------------------------------------------------------------

class _RoundsTab extends ConsumerWidget {
  final domain.League league;
  const _RoundsTab({required this.league});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auctionId = league.currentAuctionId;
    if (auctionId == null) {
      return _EmptyState(
        icon: Icons.layers_outlined,
        message: 'No auction created yet.\nRounds appear once the auction is initialized.',
      );
    }

    final roundsAsync = ref.watch(auctionRoundsProvider(auctionId));
    return roundsAsync.when(
      data: (rounds) {
        if (rounds.isEmpty) {
          return _EmptyState(icon: Icons.layers_outlined, message: 'No rounds configured yet.');
        }
        return ListView.builder(
          padding: const EdgeInsets.all(CricSpacing.page),
          itemCount: rounds.length,
          itemBuilder: (context, index) {
            final r = rounds[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: CricSpacing.sm),
              child: CricCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Round ${r.roundNumber}${r.name != null ? ' · ${r.name}' : ''}',
                            style: CricTextStyle.headingMd),
                        CricBadge(label: _humanize(r.bidMode.name), type: CricBadgeType.gold),
                      ],
                    ),
                    const SizedBox(height: CricSpacing.xs),
                    Text(
                      '${_humanize(r.franchiseEligibilityRule.name)} · ${_humanize(r.playerPoolSource.name)} · ${_humanize(r.currencyType.name)}',
                      style: CricTextStyle.caption,
                    ),
                    if (r.countdownSeconds != null)
                      Padding(
                        padding: const EdgeInsets.only(top: CricSpacing.xs),
                        child: Text('Timer ${r.countdownSeconds}s · Anti-snipe ${r.antiSnipeSeconds ?? 0}s',
                            style: CricTextStyle.caption.copyWith(color: CricColor.textDim)),
                      ),
                  ],
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

// ---------------------------------------------------------------------------
// Audit tab
// ---------------------------------------------------------------------------

class _AuditTab extends ConsumerWidget {
  final domain.League league;
  const _AuditTab({required this.league});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auctionId = league.currentAuctionId;
    if (auctionId == null) {
      return _EmptyState(
        icon: Icons.history,
        message: 'No auction yet.\nThe audit log records every auction action.',
      );
    }

    final logAsync = ref.watch(auctionAuditLogProvider(auctionId));
    return logAsync.when(
      data: (entries) {
        if (entries.isEmpty) {
          return _EmptyState(icon: Icons.history, message: 'No audit entries yet.');
        }
        return ListView.builder(
          padding: const EdgeInsets.all(CricSpacing.page),
          itemCount: entries.length,
          itemBuilder: (context, index) {
            final e = entries[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: CricSpacing.sm),
              child: CricCard(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: CricColor.slate3,
                      child: Text('#${e.sequenceNumber}',
                          style: CricTextStyle.badge.copyWith(fontSize: 9, color: CricColor.gold)),
                    ),
                    const SizedBox(width: CricSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_humanize(e.action.name), style: CricTextStyle.headingMd),
                          if (e.payload.isNotEmpty)
                            Text(
                              e.payload.entries.map((kv) => '${kv.key}: ${kv.value}').join(' · '),
                              style: CricTextStyle.caption.copyWith(color: CricColor.textDim),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          if (e.createdAt != null)
                            Text(e.createdAt!.toString().split('.')[0],
                                style: CricTextStyle.caption.copyWith(color: CricColor.textFaint)),
                        ],
                      ),
                    ),
                  ],
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

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String message;
  const _EmptyState({required this.icon, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: CricColor.textFaint),
          const SizedBox(height: 16),
          Text(message, textAlign: TextAlign.center, style: CricTextStyle.body),
        ],
      ),
    );
  }
}
