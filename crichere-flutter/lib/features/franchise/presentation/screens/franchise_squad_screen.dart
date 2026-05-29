import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  Future<void> _showInviteDialog() async {
    final emailController = TextEditingController();
    final sending = ValueNotifier(false);

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: CricColor.slate2,
        title: Text('Invite Owner', style: CricTextStyle.headingMd),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Send an invite email so the recipient can claim ownership of this franchise.',
                style: CricTextStyle.caption),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              style: CricTextStyle.body,
              decoration: CricDecoration.textField(hint: 'owner@example.com'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('CANCEL', style: CricTextStyle.badge.copyWith(color: CricColor.textDim)),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: sending,
            builder: (context, isSending, _) => ElevatedButton(
              style: CricButtonStyle.primary,
              onPressed: isSending
                  ? null
                  : () async {
                      final email = emailController.text.trim();
                      if (email.isEmpty) return;
                      sending.value = true;
                      try {
                        final invite = await ref
                            .read(franchiseRepositoryProvider)
                            .createInvite(widget.franchiseId, email);
                        if (dialogContext.mounted) Navigator.pop(dialogContext);
                        _showInviteResult(invite.inviteUrl);
                      } catch (e) {
                        sending.value = false;
                        if (dialogContext.mounted) {
                          ScaffoldMessenger.of(dialogContext)
                              .showSnackBar(SnackBar(content: Text('Invite failed: $e')));
                        }
                      }
                    },
              child: isSending
                  ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('SEND INVITE'),
            ),
          ),
        ],
      ),
    );
  }

  void _showInviteResult(String? inviteUrl) {
    if (!mounted) return;
    if (inviteUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invite sent.')));
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Invite sent — link copied to clipboard.'),
        action: SnackBarAction(
          label: 'COPY',
          onPressed: () => Clipboard.setData(ClipboardData(text: inviteUrl)),
        ),
      ),
    );
    Clipboard.setData(ClipboardData(text: inviteUrl));
  }

  @override
  Widget build(BuildContext context) {
    final squadAsync = ref.watch(squadProvider(widget.franchiseId));
    final franchiseAsync = ref.watch(franchiseProvider(widget.franchiseId));

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
            tooltip: 'Invite owner',
            icon: const Icon(Icons.person_add_alt_1_outlined, color: CricColor.textPrimary),
            onPressed: _showInviteDialog,
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: CricColor.gold),
            onPressed: () async {
              final image = await _screenshotController.capture();
              if (image != null) {
                final directory = await getTemporaryDirectory();
                final imagePath = await File('${directory.path}/squad.png').create();
                await imagePath.writeAsBytes(image);
                // Simple share logic here
              }
            },
          ),
        ],
      ),
      body: franchiseAsync.when(
        data: (franchise) => squadAsync.when(
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
                          Text('₹${franchise.currentPurse}', style: CricTextStyle.displayLg.copyWith(fontSize: 20, color: CricColor.gold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SectionHeader(title: ' PLAYERS'),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: CricSpacing.page),
                  itemCount: squad.players.length,
                  itemBuilder: (context, index) {
                    final player = squad.players[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: CricSpacing.sm),
                      child: CricCard(
                        child: Row(
                          children: [
                            AvatarCircle(
                              name: player.playerName,
                              radius: 20,
                            ),
                            const SizedBox(width: CricSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(player.playerName, style: CricTextStyle.body),
                                  Text(player.playerCategory ?? 'N/A', style: CricTextStyle.caption),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('₹${player.finalPrice}', style: CricTextStyle.body.copyWith(color: CricColor.gold)),
                                Text(player.assignmentType ?? 'SOLD', style: CricTextStyle.overline.copyWith(color: CricColor.textFaint)),
                              ],
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
          error: (e, s) => Center(child: Text('Error: $e')),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
