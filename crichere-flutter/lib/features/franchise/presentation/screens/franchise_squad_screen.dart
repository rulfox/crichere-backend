import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'package:crichere_flutter/shared/widgets/cric/cric_widgets.dart';
import '../providers/franchise_providers.dart';

@RoutePage()
class FranchiseSquadScreen extends ConsumerStatefulWidget {
  final String franchiseId;

  const FranchiseSquadScreen({super.key, required this.franchiseId});

  @override
  ConsumerState<FranchiseSquadScreen> createState() => _FranchiseSquadScreenState();
}

class _FranchiseSquadScreenState extends ConsumerState<FranchiseSquadScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final squadAsync = ref.watch(squadProvider(widget.franchiseId));

    return Scaffold(
      backgroundColor: CricColor.appBg,
      appBar: CricAppBar(
        showLogo: false,
        title: 'FRANCHISE SQUAD',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: CricColor.textPrimary),
          onPressed: () => context.router.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.group_add_outlined, color: CricColor.gold),
            onPressed: () => _showInviteSheet(context),
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: CricColor.gold),
            onPressed: () async {
              final image = await _screenshotController.capture();
              if (image != null) {
                final directory = await getTemporaryDirectory();
                final imagePath = await File('${directory.path}/squad.png').create();
                await imagePath.writeAsBytes(image);
                // Simple share for now
              }
            },
          ),
        ],
      ),
      body: squadAsync.when(
        data: (squad) => squad.players.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(CricSpacing.xxl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.group_outlined, color: CricColor.textFaint, size: 64),
                    const SizedBox(height: CricSpacing.md),
                    Text('No players yet', style: CricTextStyle.headingMd),
                    const SizedBox(height: CricSpacing.sm),
                    Text('Players will appear here after the auction', style: CricTextStyle.caption, textAlign: TextAlign.center),
                  ],
                ),
              ),
            )
          : Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(CricSpacing.page),
              child: CricCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('SQUAD SIZE', style: CricTextStyle.overline),
                        Text('${squad.players.length}/15', style: CricTextStyle.headingMd),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('PURSE LEFT', style: CricTextStyle.overline),
                        Text('₹${squad.purseRemaining}', style: CricTextStyle.displayLg.copyWith(fontSize: 20, color: CricColor.gold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SectionHeader(title: ' PLAYERS'),
            Expanded(
              child: Screenshot(
                controller: _screenshotController,
                child: Container(
                  color: CricColor.appBg,
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: CricSpacing.page),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.85,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: squad.players.length,
                    itemBuilder: (context, index) {
                      final player = squad.players[index];
                      return CricCard(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AvatarCircle(name: '', radius: 24),
                            const SizedBox(height: 8),
                            Text(
                              player.name, 
                              style: CricTextStyle.headingMd.copyWith(fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                            Text(player.role, style: CricTextStyle.caption),
                            const SizedBox(height: 8),
                            CricBadge(
                              label: player.assignmentType,
                              type: player.assignmentType == 'ICON' ? CricBadgeType.gold : CricBadgeType.blue,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '₹${player.price}',
                              style: CricTextStyle.headingMd.copyWith(color: CricColor.gold),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator(color: CricColor.gold)),
        error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.red))),
      ),
    );
  }

  void _showInviteSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: CricColor.navy,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(CricSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('INVITE CO-OWNER', style: CricTextStyle.displayLg.copyWith(fontSize: 20)),
            const SizedBox(height: 8),
            Text(
              'Anyone with this link can join your team as a co-owner and bid in the live auction.',
              style: CricTextStyle.body.copyWith(color: CricColor.textDim),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CricColor.slate3,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: CricColor.borderMid),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'https://crichere.com/invite/${widget.franchiseId}',
                      style: CricTextStyle.mono.copyWith(color: CricColor.gold),
                    ),
                  ),
                  const Icon(Icons.copy, color: CricColor.textFaint, size: 18),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.share, size: 18),
              label: const Text('SHARE VIA WHATSAPP'),
              style: CricButtonStyle.primary.copyWith(
                minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 56)),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('REVOKE LINK', style: CricTextStyle.badge.copyWith(color: CricColor.red)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
