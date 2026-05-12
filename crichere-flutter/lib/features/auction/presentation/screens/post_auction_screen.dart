import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'package:crichere_flutter/shared/widgets/cric/cric_widgets.dart';
import '../providers/auction_provider.dart';
import '../../domain/entities/auction_summary.dart';

@RoutePage()
class PostAuctionScreen extends ConsumerWidget {
  final String auctionId;

  const PostAuctionScreen({super.key, required this.auctionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(getAuctionSummaryProvider(auctionId));

    return summaryAsync.when(
      data: (summary) => DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: CricColor.appBg,
          appBar: CricAppBar(
            showLogo: false,
            title: 'AUCTION RESULTS',
            leading: IconButton(
              icon: const Icon(Icons.close, color: CricColor.textPrimary),
              onPressed: () => context.router.pop(),
            ),
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
                  tabs: const [
                    Tab(text: 'SUMMARY'),
                    Tab(text: 'SQUADS'),
                    Tab(text: 'UNSOLD'),
                    Tab(text: 'EXPORTS'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _SummaryTab(summary: summary),
                    _SquadsTab(summary: summary),
                    _UnsoldTab(summary: summary),
                    _ExportsTab(summary: summary),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      loading: () => const Scaffold(
        backgroundColor: CricColor.appBg,
        body: Center(child: CircularProgressIndicator(color: CricColor.gold)),
      ),
      error: (e, _) => Scaffold(
        backgroundColor: CricColor.appBg,
        body: Center(child: Text('Error: $e', style: const TextStyle(color: Colors.red))),
      ),
    );
  }
}

class _SummaryTab extends StatelessWidget {
  final AuctionSummary summary;
  const _SummaryTab({required this.summary});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(CricSpacing.page),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CricCard(
                  child: Column(
                    children: [
                      Text('SOLD', style: CricTextStyle.overline),
                      const SizedBox(height: 4),
                      Text('${summary.totalPlayersSold}', style: CricTextStyle.displayLg.copyWith(fontSize: 24, color: CricColor.green)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CricCard(
                  child: Column(
                    children: [
                      Text('TOTAL SPENT', style: CricTextStyle.overline),
                      const SizedBox(height: 4),
                      Text('₹${(summary.totalAmountSpent / 1000).toStringAsFixed(1)}k', style: CricTextStyle.displayLg.copyWith(fontSize: 24, color: CricColor.gold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: CricSpacing.xl),
          const SectionHeader(title: ' TOP BUYS'),
          ...summary.topBuys.map((buy) => Padding(
            padding: const EdgeInsets.only(bottom: CricSpacing.sm),
            child: CricCard(
              child: Row(
                children: [
                  const AvatarCircle(name: '', radius: 16),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(buy.playerName, style: CricTextStyle.headingMd),
                        Text(buy.franchiseName, style: CricTextStyle.caption),
                      ],
                    ),
                  ),
                  Text('₹${buy.amount}', style: CricTextStyle.headingMd.copyWith(color: CricColor.gold)),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}

class _SquadsTab extends StatelessWidget {
  final AuctionSummary summary;
  const _SquadsTab({required this.summary});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(CricSpacing.page),
      itemCount: summary.franchiseResults.length,
      itemBuilder: (context, index) {
        final res = summary.franchiseResults[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: CricSpacing.md),
          child: CricCard(
            onTap: () {
              // Navigate to squad detail if needed
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(res.franchiseName, style: CricTextStyle.headingMd),
                    CricBadge(label: '${res.playersCount} Players', type: CricBadgeType.gold),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Spent: ₹${res.totalSpent}', style: CricTextStyle.caption),
                    Text('Purse: ₹${res.remainingPurse}', style: CricTextStyle.caption.copyWith(color: CricColor.green)),
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

class _UnsoldTab extends StatelessWidget {
  final AuctionSummary summary;
  const _UnsoldTab({required this.summary});

  @override
  Widget build(BuildContext context) {
    if (summary.unsoldPlayerIds.isEmpty) {
      return const Center(child: Text('All players sold!', style: TextStyle(color: Colors.white)));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(CricSpacing.page),
      itemCount: summary.unsoldPlayerIds.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: CricSpacing.sm),
          child: CricCard(
            child: Text('Player ${summary.unsoldPlayerIds[index]}', style: CricTextStyle.body),
          ),
        );
      },
    );
  }
}

class _ExportsTab extends ConsumerWidget {
  final AuctionSummary summary;
  const _ExportsTab({required this.summary});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(CricSpacing.page),
      children: [
        // Public Replay Link
        CricCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('PUBLIC AUCTION REPLAY', style: CricTextStyle.overline),
              const SizedBox(height: 12),
              Text(
                'Anyone can view the full auction replay without logging in.',
                style: CricTextStyle.caption,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: CricColor.slate3,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'https://app.crichere.in/view/${summary.auctionId.substring(0, 8)}...',
                        style: CricTextStyle.mono.copyWith(color: CricColor.gold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.copy_outlined, color: CricColor.textFaint, size: 16),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.share, size: 16),
                      label: const Text('SHARE LINK'),
                      style: CricButtonStyle.ghost,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const SectionHeader(title: 'REPORTS & EXPORTS'),
        const SizedBox(height: 12),
        CricCard(
          onTap: () {
            // Full Auction Report PDF
          },
          child: const ListTile(
            leading: Icon(Icons.picture_as_pdf, color: CricColor.red),
            title: Text('Full Auction Report', style: TextStyle(color: Colors.white)),
            subtitle: Text('PDF • Summary & All Squads', style: TextStyle(color: CricColor.textFaint, fontSize: 12)),
            trailing: Icon(Icons.download, color: CricColor.textDim),
          ),
        ),
        const SizedBox(height: 12),
        CricCard(
          onTap: () {
            // Excel Export
          },
          child: const ListTile(
            leading: Icon(Icons.table_chart, color: CricColor.green),
            title: Text('Auction Data', style: TextStyle(color: Colors.white)),
            subtitle: Text('XLSX • Raw bidding data', style: TextStyle(color: CricColor.textFaint, fontSize: 12)),
            trailing: Icon(Icons.download, color: CricColor.textDim),
          ),
        ),
        const SizedBox(height: 12),
        CricCard(
          onTap: () {
            // Share Squad Image
          },
          child: const ListTile(
            leading: Icon(Icons.image_outlined, color: CricColor.blue),
            title: Text('Squad Images', style: TextStyle(color: Colors.white)),
            subtitle: Text('PNG • Optimized for WhatsApp', style: TextStyle(color: CricColor.textFaint, fontSize: 12)),
            trailing: Icon(Icons.share, color: CricColor.textDim),
          ),
        ),
      ],
    );
  }
}
