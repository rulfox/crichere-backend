import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'package:crichere_flutter/core/export/file_share.dart';
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
                      Text('${summary.totalSold}', style: CricTextStyle.displayLg.copyWith(fontSize: 24, color: CricColor.green)),
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
                      Text('₹${(summary.totalSpent / 1000).toStringAsFixed(1)}k', style: CricTextStyle.displayLg.copyWith(fontSize: 24, color: CricColor.gold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: CricSpacing.xl),
          const SectionHeader(title: ' TOP BUY'),
          if (summary.highestSale != null) Padding(
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
                        Text(summary.highestSale!.playerName, style: CricTextStyle.headingMd),
                        Text(summary.highestSale!.franchiseName, style: CricTextStyle.caption),
                      ],
                    ),
                  ),
                  Text('₹${summary.highestSale!.amount}', style: CricTextStyle.headingMd.copyWith(color: CricColor.gold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SquadsTab extends ConsumerWidget {
  final AuctionSummary summary;
  const _SquadsTab({required this.summary});

  Future<void> _exportFranchise(
    BuildContext context,
    WidgetRef ref,
    String franchiseId,
    String franchiseName,
    bool asImage,
  ) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Preparing ${asImage ? 'image' : 'PDF'} for $franchiseName…')),
    );
    try {
      final repo = ref.read(auctionRepositoryProvider);
      final bytes = asImage
          ? await repo.exportFranchiseImage(summary.auctionId, franchiseId)
          : await repo.exportFranchisePdf(summary.auctionId, franchiseId);
      await FileShare.shareBytes(
        bytes,
        fileName: asImage ? '${franchiseName}_squad.png' : '${franchiseName}_squad.pdf',
        mimeType: asImage ? 'image/png' : 'application/pdf',
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Export failed: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      padding: const EdgeInsets.all(CricSpacing.page),
      itemCount: summary.franchiseSummaries.length,
      itemBuilder: (context, index) {
        final res = summary.franchiseSummaries[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: CricSpacing.md),
          child: CricCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(res.franchiseName, style: CricTextStyle.headingMd)),
                    CricBadge(label: '${res.squadCount} Players', type: CricBadgeType.gold),
                    PopupMenuButton<String>(
                      color: CricColor.slate2,
                      icon: const Icon(Icons.ios_share, size: 18, color: CricColor.textDim),
                      onSelected: (v) => _exportFranchise(
                        context, ref, res.franchiseId, res.franchiseName, v == 'image',
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(value: 'pdf', child: Text('Export PDF', style: CricTextStyle.body)),
                        PopupMenuItem(value: 'image', child: Text('Export image', style: CricTextStyle.body)),
                      ],
                    ),
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
    if (summary.totalUnsold == 0) {
      return const Center(child: Text('All players sold!', style: TextStyle(color: Colors.white)));
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(CricSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.person_off_outlined, color: CricColor.textFaint, size: 48),
            const SizedBox(height: 16),
            Text('${summary.totalUnsold} unsold player${summary.totalUnsold == 1 ? '' : 's'}', style: CricTextStyle.headingMd),
            const SizedBox(height: 8),
            Text('Detailed unsold list available via the league dashboard', style: CricTextStyle.caption, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _ExportsTab extends ConsumerWidget {
  final AuctionSummary summary;
  const _ExportsTab({required this.summary});

  String get _replayLink => 'https://crichere.com/view/${summary.auctionId}';

  Future<void> _shareLink(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: _replayLink));
    await SharePlus.instance.share(ShareParams(text: 'Check out this auction replay: $_replayLink'));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Link copied and ready to share!')),
      );
    }
  }

  Future<void> _downloadPdf(BuildContext context) async {
    try {
      final doc = pw.Document();
      doc.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (ctx) => [
            pw.Header(level: 0, child: pw.Text('Auction Report', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold))),
            pw.SizedBox(height: 16),
            pw.Text('Total Players Sold: ${summary.totalSold}'),
            pw.Text('Total Amount Spent: ₹${summary.totalSpent}'),
            pw.SizedBox(height: 24),
            pw.Header(level: 1, child: pw.Text('Top Buy', style: pw.TextStyle(fontSize: 16))),
            if (summary.highestSale != null) pw.Text('${summary.highestSale!.playerName} → ${summary.highestSale!.franchiseName}: ₹${summary.highestSale!.amount}'),
            pw.SizedBox(height: 24),
            pw.Header(level: 1, child: pw.Text('Franchise Results', style: pw.TextStyle(fontSize: 16))),
            ...summary.franchiseSummaries.map((f) => pw.Text(
              '${f.franchiseName}: ${f.squadCount} players, ₹${f.totalSpent} spent, ₹${f.remainingPurse} remaining',
            )),
          ],
        ),
      );
      final bytes = await doc.save();
      await FileShare.shareBytes(bytes, fileName: 'auction_report.pdf', mimeType: 'application/pdf');
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('PDF error: $e')));
      }
    }
  }

  /// Fetches the canonical server-rendered summary PDF and shares it.
  Future<void> _downloadServerPdf(BuildContext context, WidgetRef ref) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Preparing official report…')),
    );
    try {
      final bytes = await ref.read(auctionRepositoryProvider).exportSummaryPdf(summary.auctionId);
      await FileShare.shareBytes(
        bytes,
        fileName: 'auction_${summary.auctionId}_summary.pdf',
        mimeType: 'application/pdf',
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Export failed: $e')));
      }
    }
  }

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
              Text('Anyone can view the full auction replay without logging in.', style: CricTextStyle.caption),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: _replayLink));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link copied!')));
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: CricColor.slate3, borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(_replayLink, style: CricTextStyle.mono.copyWith(color: CricColor.gold), overflow: TextOverflow.ellipsis),
                      ),
                      const Icon(Icons.copy_outlined, color: CricColor.textFaint, size: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _shareLink(context),
                  icon: const Icon(Icons.share, size: 16),
                  label: const Text('SHARE LINK'),
                  style: CricButtonStyle.ghost,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const SectionHeader(title: 'REPORTS & EXPORTS'),
        const SizedBox(height: 12),
        CricCard(
          onTap: () => _downloadServerPdf(context, ref),
          child: const ListTile(
            leading: Icon(Icons.workspace_premium_outlined, color: CricColor.gold),
            title: Text('Official Auction Report', style: TextStyle(color: Colors.white)),
            subtitle: Text('PDF • Server-generated, full detail', style: TextStyle(color: CricColor.textFaint, fontSize: 12)),
            trailing: Icon(Icons.download, color: CricColor.textDim),
          ),
        ),
        const SizedBox(height: 12),
        CricCard(
          onTap: () => _downloadPdf(context),
          child: const ListTile(
            leading: Icon(Icons.picture_as_pdf, color: CricColor.red),
            title: Text('Quick Summary Report', style: TextStyle(color: Colors.white)),
            subtitle: Text('PDF • Generated on device', style: TextStyle(color: CricColor.textFaint, fontSize: 12)),
            trailing: Icon(Icons.download, color: CricColor.textDim),
          ),
        ),
        const SizedBox(height: 12),
        CricCard(
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Excel export available on your league dashboard at crichere.com')),
          ),
          child: const ListTile(
            leading: Icon(Icons.table_chart, color: CricColor.green),
            title: Text('Auction Data', style: TextStyle(color: Colors.white)),
            subtitle: Text('XLSX • Raw bidding data', style: TextStyle(color: CricColor.textFaint, fontSize: 12)),
            trailing: Icon(Icons.download, color: CricColor.textDim),
          ),
        ),
        const SizedBox(height: 12),
        CricCard(
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Squad image export coming soon!')),
          ),
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
