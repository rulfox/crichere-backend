import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'package:crichere_flutter/shared/widgets/cric/cric_widgets.dart';
import '../../../auction/presentation/providers/auction_state_provider.dart';
import '../providers/spectator_providers.dart';

/// Read-only public spectator view, reached via a share token.
///
/// Gates on the public status endpoint: only LIVE auctions stream events; a
/// valid-but-not-live auction (`error.auction_not_live`) shows a waiting state.
@RoutePage()
class SpectatorScreen extends ConsumerWidget {
  final String token;

  const SpectatorScreen({super.key, required this.token});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusAsync = ref.watch(publicViewStatusProvider(token));

    return Scaffold(
      backgroundColor: CricColor.appBg,
      appBar: CricAppBar(
        showLogo: false,
        title: 'LIVE',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: CricColor.textPrimary),
          onPressed: () => context.router.maybePop(),
        ),
      ),
      body: statusAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: CricColor.gold)),
        error: (e, _) => _Waiting(
          title: 'LINK UNAVAILABLE',
          message: 'This view link is invalid or has expired.',
          onRetry: () => ref.invalidate(publicViewStatusProvider(token)),
        ),
        data: (status) {
          final state = (status is Map ? status['status']?.toString() : null) ?? '';
          if (state == 'COMPLETED') {
            return const _Waiting(title: 'AUCTION COMPLETE', message: 'This auction has finished.');
          }
          if (state != 'LIVE') {
            return _Waiting(
              title: 'NOT LIVE YET',
              message: 'The auction has not started. This page will update when it goes live.',
              onRetry: () => ref.invalidate(publicViewStatusProvider(token)),
            );
          }
          return _SpectatorLive(token: token);
        },
      ),
    );
  }
}

class _SpectatorLive extends ConsumerWidget {
  final String token;
  const _SpectatorLive({required this.token});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Feed the public SSE stream into the shared auction-state reducer.
    ref.listen(publicViewEventsProvider(token), (prev, next) {
      next.whenData((event) => ref.read(auctionStateProvider.notifier).handleEvent(event));
    });
    final s = ref.watch(auctionStateProvider);

    if (s.currentPlayerName == null) {
      return const _Waiting(title: 'WAITING', message: 'Waiting for the next player…');
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(CricSpacing.page),
      child: Column(
        children: [
          CricCard(
            padding: const EdgeInsets.all(CricSpacing.xl),
            child: Column(
              children: [
                AvatarCircle(name: s.currentPlayerName ?? '', radius: 48),
                const SizedBox(height: 16),
                Text(s.currentPlayerName!, style: CricTextStyle.displayLg.copyWith(fontSize: 32)),
                const SizedBox(height: 8),
                Text('${s.remainingSeconds}s',
                    style: CricTextStyle.timerNumber.copyWith(
                      fontSize: 28,
                      color: s.remainingSeconds <= 10 ? CricColor.red : CricColor.textPrimary,
                    )),
                const SizedBox(height: CricSpacing.lg),
                Text('CURRENT BID', style: CricTextStyle.overline),
                const SizedBox(height: 4),
                Text('₹${s.currentBid}', style: CricTextStyle.bidNumber.copyWith(fontSize: 64)),
                if (s.leadingFranchise != null) ...[
                  const SizedBox(height: 8),
                  Text('by ${s.leadingFranchise}',
                      style: CricTextStyle.headingMd.copyWith(color: CricColor.gold)),
                ],
                const SizedBox(height: 12),
                CricBadge(
                  label: s.status,
                  type: s.status == 'SOLD'
                      ? CricBadgeType.green
                      : (s.status == 'UNSOLD' ? CricBadgeType.red : CricBadgeType.gold),
                ),
              ],
            ),
          ),
          const SizedBox(height: CricSpacing.xxl),
          const SectionHeader(title: 'FRANCHISE PURSES'),
          ...s.franchises.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: CricCard(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(f.franchiseName ?? 'Franchise', style: CricTextStyle.headingMd),
                    Text('₹${f.currentAmount}',
                        style: CricTextStyle.headingMd.copyWith(color: CricColor.gold)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Waiting extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onRetry;
  const _Waiting({required this.title, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(CricSpacing.page),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.hourglass_empty, size: 48, color: CricColor.textFaint),
            const SizedBox(height: 16),
            Text(title, style: CricTextStyle.displayLg.copyWith(fontSize: 22)),
            const SizedBox(height: 8),
            Text(message, textAlign: TextAlign.center, style: CricTextStyle.body),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(style: CricButtonStyle.primary, onPressed: onRetry, child: const Text('REFRESH')),
            ],
          ],
        ),
      ),
    );
  }
}
