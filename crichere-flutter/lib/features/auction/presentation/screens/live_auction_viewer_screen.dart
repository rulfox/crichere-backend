import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'package:crichere_flutter/core/router/app_router.gr.dart';
import 'package:crichere_flutter/shared/widgets/cric/cric_widgets.dart';
import '../providers/auction_provider.dart';
import '../providers/auction_state_provider.dart';
import '../../domain/entities/auction_event.dart';

@RoutePage()
class LiveAuctionViewerScreen extends ConsumerWidget {
  final String auctionId;

  const LiveAuctionViewerScreen({super.key, required this.auctionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(auctionEventsProvider(auctionId));
    final auctionState = ref.watch(auctionStateProvider);

    // Listen to events and update local state
    ref.listen(auctionEventsProvider(auctionId), (previous, next) {
      next.whenData((event) {
        ref.read(auctionStateProvider.notifier).handleEvent(event);
        if (event is AuctionCompleted) {
          context.router.replace(PostAuctionRoute(auctionId: auctionId));
        }
      });
    });

    return Scaffold(
      backgroundColor: CricColor.appBg,
      appBar: CricAppBar(
        showLogo: false,
        title: 'LIVE AUCTION',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: CricColor.textPrimary),
          onPressed: () => context.router.pop(),
        ),
        actions: [
          _ConnectionStatusIndicator(eventsAsync: eventsAsync),
        ],
      ),
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 1000) {
                return _WebAuctionLayout(auctionState: auctionState);
              }
              return _MobileAuctionLayout(auctionState: auctionState);
            },
          ),
          
          // Reconnection Overlay
          if (eventsAsync.isLoading || eventsAsync.hasError)
            _ReconnectionOverlay(
              isError: eventsAsync.hasError,
              onRetry: () => ref.invalidate(auctionEventsProvider(auctionId)),
            ),
        ],
      ),
    );
  }
}

class _ReconnectionOverlay extends StatelessWidget {
  final bool isError;
  final VoidCallback onRetry;

  const _ReconnectionOverlay({required this.isError, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.8),
      child: Center(
        child: CricCard(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isError)
                const Icon(Icons.cloud_off_outlined, color: CricColor.red, size: 48)
              else
                const CircularProgressIndicator(color: CricColor.gold),
              const SizedBox(height: 24),
              Text(
                isError ? 'CONNECTION LOST' : 'RECONNECTING...',
                style: CricTextStyle.displayLg.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 12),
              Text(
                isError 
                  ? 'We lost connection to the auction room. Syncing latest state...'
                  : 'Syncing sequence with server state.',
                textAlign: TextAlign.center,
                style: CricTextStyle.body.copyWith(color: CricColor.textDim),
              ),
              if (isError) ...[
                const SizedBox(height: 32),
                ElevatedButton(
                  style: CricButtonStyle.primary,
                  onPressed: onRetry,
                  child: const Text('RETRY NOW'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileAuctionLayout extends StatelessWidget {
  final AuctionState auctionState;
  const _MobileAuctionLayout({required this.auctionState});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(CricSpacing.page),
            child: Column(
              children: [
                if (auctionState.currentPlayerName != null)
                  _PlayerAuctionDisplay(
                    name: auctionState.currentPlayerName!,
                    currentBid: auctionState.currentBid,
                    leadingFranchise: auctionState.leadingFranchise,
                    status: auctionState.status,
                    remainingSeconds: auctionState.remainingSeconds,
                    isTimerRunning: auctionState.isTimerRunning,
                  )
                else
                  const _WaitingState(),
                
                const SizedBox(height: CricSpacing.xxl),
                const SectionHeader(title: 'BID HISTORY'),
                const _BidHistoryList(),
              ],
            ),
          ),
        ),
        const _FranchisePurseCarousel(),
      ],
    );
  }
}

class _WebAuctionLayout extends StatelessWidget {
  final AuctionState auctionState;
  const _WebAuctionLayout({required this.auctionState});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left Column: Bid History
        Container(
          width: 320,
          decoration: BoxDecoration(
            color: CricColor.navy,
            border: Border(right: BorderSide(color: CricColor.borderLight, width: 1)),
          ),
          child: const Column(
            children: [
              SectionHeader(title: 'BID HISTORY'),
              Expanded(child: _BidHistoryList()),
            ],
          ),
        ),

        // Center Column: Player Display
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(CricSpacing.xxl),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: auctionState.currentPlayerName != null
                  ? _PlayerAuctionDisplay(
                      name: auctionState.currentPlayerName!,
                      currentBid: auctionState.currentBid,
                      leadingFranchise: auctionState.leadingFranchise,
                      status: auctionState.status,
                      remainingSeconds: auctionState.remainingSeconds,
                      isTimerRunning: auctionState.isTimerRunning,
                      isLarge: true,
                    )
                  : const _WaitingState(),
              ),
            ),
          ),
        ),

        // Right Column: Franchise Purses
        Container(
          width: 320,
          decoration: BoxDecoration(
            color: CricColor.navy,
            border: Border(left: BorderSide(color: CricColor.borderLight, width: 1)),
          ),
          child: Column(
            children: [
              const SectionHeader(title: 'FRANCHISE PURSES'),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(CricSpacing.base),
                  itemCount: 8,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: CricCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Franchise ${index + 1}', style: CricTextStyle.headingMd),
                          const SizedBox(height: 12),
                          const PurseBar(spent: 12000, total: 40000, height: 4),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WaitingState extends StatelessWidget {
  const _WaitingState();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.hourglass_empty, size: 48, color: CricColor.textFaint),
            const SizedBox(height: 16),
            Text('Waiting for next player...', style: CricTextStyle.body),
          ],
        ),
      ),
    );
  }
}

class _BidHistoryList extends ConsumerWidget {
  const _BidHistoryList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auctionState = ref.watch(auctionStateProvider);
    if (auctionState.bidHistory.isEmpty) {
      return Center(child: Text('No bids yet', style: CricTextStyle.caption));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: auctionState.bidHistory.length,
      itemBuilder: (context, index) {
        final bid = auctionState.bidHistory[auctionState.bidHistory.length - 1 - index];
        return Padding(
          padding: const EdgeInsets.only(bottom: CricSpacing.sm),
          child: CricCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const AvatarCircle(name: '', radius: 14),
                    const SizedBox(width: 12),
                    Text(bid.franchiseName, style: CricTextStyle.headingMd),
                  ],
                ),
                Text(
                  '₹${bid.amount}',
                  style: CricTextStyle.headingMd.copyWith(color: CricColor.gold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FranchisePurseCarousel extends StatelessWidget {
  const _FranchisePurseCarousel();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: CricColor.navyMid,
        border: Border(top: BorderSide(color: CricColor.borderLight, width: 1)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(CricSpacing.base),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Container(
            width: 160,
            margin: const EdgeInsets.only(right: 12),
            child: CricCard(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Franchise ${index + 1}', style: CricTextStyle.badge, maxLines: 1, overflow: TextOverflow.ellipsis),
                  const Spacer(),
                  const PurseBar(spent: 12000, total: 40000, height: 3),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ConnectionStatusIndicator extends StatelessWidget {
  final AsyncValue eventsAsync;
  const _ConnectionStatusIndicator({required this.eventsAsync});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: eventsAsync.when(
        data: (_) => const Row(
          children: [
            LiveDot(),
            SizedBox(width: 8),
            Text('LIVE', style: TextStyle(color: CricColor.red, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
          ],
        ),
        loading: () => const Icon(Icons.circle, color: CricColor.gold, size: 8),
        error: (_, _) => const Row(
          children: [
            Icon(Icons.circle, color: CricColor.textFaint, size: 8),
            SizedBox(width: 8),
            Text('OFFLINE', style: TextStyle(color: CricColor.textFaint, fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
class _PlayerAuctionDisplay extends StatelessWidget {
  final String name;
  final int currentBid;
  final String? leadingFranchise;
  final String status;
  final int remainingSeconds;
  final bool isTimerRunning;
  final bool isLarge;

  const _PlayerAuctionDisplay({
    required this.name,
    required this.currentBid,
    this.leadingFranchise,
    required this.status,
    required this.remainingSeconds,
    required this.isTimerRunning,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    final isAntiSnipe = remainingSeconds <= 10 && isTimerRunning;

    return Column(
      children: [
        CricCard(
          borderColor: isAntiSnipe ? CricColor.red : null,
          padding: EdgeInsets.all(isLarge ? CricSpacing.xxl : CricSpacing.xl),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 48),
                  AvatarCircle(name: 'Player', radius: isLarge ? 60 : 40),
                  Column(
                    children: [
                      Text(
                        '${remainingSeconds}s',
                        style: CricTextStyle.timerNumber.copyWith(
                          fontSize: isLarge ? 48 : 32,
                          color: remainingSeconds <= 10 ? CricColor.red : CricColor.textPrimary,
                        ),
                      ),
                      if (isTimerRunning)
                        const LiveDot()
                      else
                        const Icon(Icons.pause, size: 12, color: CricColor.textDim),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(name, style: isLarge ? CricTextStyle.displayLg.copyWith(fontSize: 48) : CricTextStyle.displayLg),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const StatusChip(type: StatusType.t20, customLabel: 'AR'),
                  const SizedBox(width: 8),
                  Text('Base: ₹1,000', style: CricTextStyle.caption),
                ],
              ),
              const SizedBox(height: CricSpacing.xxl),
              Text('CURRENT BID', style: CricTextStyle.overline),
              const SizedBox(height: 8),
              Text(
                '₹$currentBid',
                style: CricTextStyle.bidNumber.copyWith(fontSize: isLarge ? 100 : 64),
              ),
              if (leadingFranchise != null) ...[
                const SizedBox(height: 8),
                Text(
                  'by $leadingFranchise',
                  style: CricTextStyle.headingMd.copyWith(color: CricColor.gold, fontSize: isLarge ? 24 : 18),
                ),
              ],
              const SizedBox(height: CricSpacing.xl),
              if (isAntiSnipe)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    '⚡ ANTI-SNIPE ACTIVE',
                    style: CricTextStyle.badge.copyWith(color: CricColor.red),
                  ),
                ),
              CricBadge(
                label: status,
                type: status == 'SOLD' ? CricBadgeType.green : (status == 'UNSOLD' ? CricBadgeType.red : CricBadgeType.gold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
