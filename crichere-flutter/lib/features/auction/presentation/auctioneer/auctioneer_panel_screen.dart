import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'package:crichere_flutter/core/router/app_router.gr.dart';
import 'package:crichere_flutter/shared/widgets/cric/cric_widgets.dart';
import '../providers/auction_provider.dart';
import '../providers/auction_state_provider.dart';
import '../../domain/entities/auction_event.dart';
import '../../../league/presentation/providers/league_repository_provider.dart';

@RoutePage()
class AuctioneerPanelScreen extends HookConsumerWidget {
  final String auctionId;

  const AuctioneerPanelScreen({super.key, required this.auctionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auctionState = ref.watch(auctionStateProvider);
    final auctionRepo = ref.watch(auctionRepositoryProvider);
    final playersAsync = ref.watch(leaguePlayersProvider(auctionId));
    final franchisesAsync = ref.watch(leagueFranchisesProvider(auctionId));
    
    // Listen to events and update local state
    ref.listen(auctionEventsProvider(auctionId), (previous, next) {
      next.whenData((event) {
        ref.read(auctionStateProvider.notifier).handleEvent(event);
        if (event is AuctionCompleted) {
          context.router.replace(PostAuctionRoute(auctionId: auctionId));
        }
      });
    });

    final selectedFranchiseId = useState<String?>(null);

    void showForceAssignDialog(String playerId, String playerName) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: CricColor.slate2,
          title: Text('Force Assign $playerName', style: CricTextStyle.headingMd),
          content: franchisesAsync.when(
            data: (franchises) => DropdownButtonFormField<String>(
              dropdownColor: CricColor.slate2,
              decoration: CricDecoration.textField(hint: 'Select Franchise'),
              items: franchises.map((f) => DropdownMenuItem(value: f.id, child: Text(f.name, style: CricTextStyle.body))).toList(),
              onChanged: (val) => selectedFranchiseId.value = val,
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text('Error: $e'),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('CANCEL', style: CricTextStyle.badge.copyWith(color: CricColor.textDim))),
            ElevatedButton(
              style: CricButtonStyle.primary,
              onPressed: () async {
                if (selectedFranchiseId.value != null) {
                  await auctionRepo.forceAssign(auctionId, playerId, selectedFranchiseId.value!);
                  if (context.mounted) Navigator.pop(context);
                }
              },
              child: const Text('FORCE ASSIGN'),
            ),
          ],
        ),
      );
    }

    void showPreAssignDialog(String playerId, String playerName) {
      final type = useState('CAPTAIN');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: CricColor.slate2,
          title: Text('Pre-Assign $playerName', style: CricTextStyle.headingMd),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                dropdownColor: CricColor.slate2,
                initialValue: type.value,
                decoration: CricDecoration.textField(hint: 'Assignment Type'),
                items: const [
                  DropdownMenuItem(value: 'CAPTAIN', child: Text('CAPTAIN (Deduct Purse)')),
                  DropdownMenuItem(value: 'ICON', child: Text('ICON (Free)')),
                ],
                onChanged: (val) => type.value = val!,
              ),
              const SizedBox(height: 16),
              franchisesAsync.when(
                data: (franchises) => DropdownButtonFormField<String>(
                  dropdownColor: CricColor.slate2,
                  decoration: CricDecoration.textField(hint: 'Select Franchise'),
                  items: franchises.map((f) => DropdownMenuItem(value: f.id, child: Text(f.name, style: CricTextStyle.body))).toList(),
                  onChanged: (val) => selectedFranchiseId.value = val,
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text('Error: $e'),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('CANCEL', style: CricTextStyle.badge.copyWith(color: CricColor.textDim))),
            ElevatedButton(
              style: CricButtonStyle.primary,
              onPressed: () async {
                if (selectedFranchiseId.value != null) {
                  await auctionRepo.preAssign(auctionId, playerId, selectedFranchiseId.value!, type.value);
                  if (context.mounted) Navigator.pop(context);
                }
              },
              child: const Text('PRE-ASSIGN'),
            ),
          ],
        ),
      );
    }

    void showUndoSoldDialog() {
      final reasonController = TextEditingController();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: CricColor.slate2,
          title: Text('Undo Sold?', style: CricTextStyle.headingMd),
          content: TextField(
            controller: reasonController,
            autofocus: true,
            style: CricTextStyle.body,
            decoration: CricDecoration.textField(hint: 'Reason for undoing'),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('CANCEL', style: CricTextStyle.badge.copyWith(color: CricColor.textDim))),
            ElevatedButton(
              style: CricButtonStyle.primary.copyWith(backgroundColor: const WidgetStatePropertyAll(CricColor.red)),
              onPressed: () async {
                if (reasonController.text.isNotEmpty) {
                  await auctionRepo.undoSold(auctionId, reasonController.text);
                  if (context.mounted) Navigator.pop(context);
                }
              },
              child: const Text('CONFIRM'),
            ),
          ],
        ),
      );
    }

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyZ, control: true): () => auctionRepo.undoBid(auctionId),
        const SingleActivator(LogicalKeyboardKey.enter): () {
          if (auctionState.status == 'BIDDING') auctionRepo.markSold(auctionId);
        },
      },
      child: Focus(
        autofocus: true,
        child: Scaffold(
          backgroundColor: CricColor.appBg,
          appBar: CricAppBar(
            showLogo: true,
            title: 'AUCTIONEER COMMAND CENTER',
            actions: [
              IconButton(icon: const Icon(Icons.settings_outlined, color: CricColor.textDim), onPressed: () {}),
            ],
          ),
          body: Row(
            children: [
              // Left Column: Player Pool
              Container(
                width: 320,
                decoration: BoxDecoration(
                  color: CricColor.navy,
                  border: Border(right: BorderSide(color: CricColor.borderLight, width: 1)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.shuffle, size: 18),
                        label: const Text('RANDOM NEXT'),
                        style: CricButtonStyle.primary.copyWith(
                          minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 44)),
                        ),
                        onPressed: () => auctionRepo.putRandomPlayer(auctionId),
                      ),
                    ),
                    const Divider(color: CricColor.borderLight, height: 1),
                    const SectionHeader(title: ' AVAILABLE PLAYERS'),
                    Expanded(
                      child: playersAsync.when(
                        data: (players) => ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          itemCount: players.length,
                          itemBuilder: (context, index) {
                            final p = players[index];
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              leading: const AvatarCircle(name: '', radius: 14),
                              title: Text(p.playerName, style: CricTextStyle.headingMd.copyWith(fontSize: 14)),
                              subtitle: Text('Base: ₹${p.basePriceOverride ?? "1k"}', style: CricTextStyle.caption),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.assignment_ind_outlined, size: 18, color: CricColor.textDim),
                                    onPressed: () => showPreAssignDialog(p.playerId, p.playerName),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.bolt, size: 18, color: CricColor.textDim),
                                    onPressed: () => showForceAssignDialog(p.playerId, p.playerName),
                                  ),
                                ],
                              ),
                              onTap: () => auctionRepo.putSpecificPlayer(auctionId, p.playerId),
                            );
                          },
                        ),
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (e, _) => Center(child: Text('Error: $e')),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Right Column: Control Panel
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(CricSpacing.xxl),
                  child: Column(
                    children: [
                      if (auctionState.currentPlayerName != null) ...[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('CURRENT PLAYER', style: CricTextStyle.overline),
                                  const SizedBox(height: 8),
                                  Text(auctionState.currentPlayerName!, style: CricTextStyle.displayLg),
                                  const SizedBox(height: 8),
                                  const StatusChip(type: StatusType.t20, customLabel: 'BATTER'),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  '${auctionState.remainingSeconds}s',
                                  style: CricTextStyle.timerNumber.copyWith(
                                    fontSize: 48,
                                    color: auctionState.remainingSeconds <= 10 ? CricColor.red : CricColor.textPrimary,
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        auctionState.isTimerRunning ? Icons.pause_circle_outline : Icons.play_circle_outline,
                                        color: CricColor.gold,
                                      ),
                                      onPressed: () {
                                        if (auctionState.isTimerRunning) {
                                          auctionRepo.pauseTimer(auctionId, auctionState.remainingSeconds);
                                        } else {
                                          auctionRepo.startTimer(auctionId, auctionState.remainingSeconds == 0 ? 60 : auctionState.remainingSeconds);
                                        }
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.refresh, color: CricColor.textDim),
                                      onPressed: () => auctionRepo.resetTimer(auctionId, 60),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(width: 24),
                            CricBadge(label: auctionState.status, type: CricBadgeType.gold),
                          ],
                        ),
                        const Spacer(),
                        
                        Column(
                          children: [
                            Text('CURRENT BID', style: CricTextStyle.overline),
                            const SizedBox(height: 8),
                            Text(
                              '₹${auctionState.currentBid}',
                              style: CricTextStyle.bidNumber.copyWith(fontSize: 80),
                            ),
                            const SizedBox(height: 8),
                            if (auctionState.leadingFranchise != null)
                              Text(
                                'by ${auctionState.leadingFranchise}',
                                style: CricTextStyle.headingMd.copyWith(color: CricColor.gold, fontSize: 20),
                              )
                            else
                              Text('No Bids', style: CricTextStyle.caption),
                            const SizedBox(height: 24),
                            Text('MIN NEXT BID: ₹${auctionState.currentBid + auctionState.bidIncrement}', 
                              style: CricTextStyle.headingMd.copyWith(color: CricColor.gold.withValues(alpha: 0.7))),
                          ],
                        ),
                        
                        const Spacer(),
                        
                        // Dynamic Increment Buttons
                        franchisesAsync.when(
                          data: (franchises) => Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            alignment: WrapAlignment.center,
                            children: franchises.take(4).map((f) => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CricColor.slate3,
                                foregroundColor: CricColor.textPrimary,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              ),
                              onPressed: () => auctionRepo.recordBid(auctionId, f.id, auctionState.currentBid + auctionState.bidIncrement),
                              child: Text('${f.name}: +₹${auctionState.bidIncrement}', style: CricTextStyle.badge),
                            )).toList(),
                          ),
                          loading: () => const CircularProgressIndicator(),
                          error: (_, ___) => const SizedBox(),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _AuctionButton(
                              label: 'UNDO BID',
                              icon: Icons.undo,
                              color: CricColor.red,
                              onPressed: () => auctionRepo.undoBid(auctionId),
                              isOutlined: true,
                            ),
                            const SizedBox(width: CricSpacing.lg),
                            _AuctionButton(
                              label: 'UNSOLD',
                              icon: Icons.close,
                              color: CricColor.gold,
                              onPressed: () => auctionRepo.markUnsold(auctionId),
                            ),
                            const SizedBox(width: CricSpacing.lg),
                            _AuctionButton(
                              label: 'SOLD',
                              icon: Icons.check,
                              color: CricColor.green,
                              onPressed: () => auctionRepo.markSold(auctionId),
                            ),
                          ],
                        ),
                      ] else
                        Expanded(
                          child: Center(
                            child: Text('Select a player from the left to start bidding', style: CricTextStyle.body),
                          ),
                        ),                      
                      if (auctionState.status == 'SOLD')
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: TextButton.icon(
                            icon: const Icon(Icons.history, size: 16),
                            label: const Text('UNDO SOLD'),
                            style: TextButton.styleFrom(foregroundColor: CricColor.textDim),
                            onPressed: showUndoSoldDialog,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuctionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;
  final bool isOutlined;

  const _AuctionButton({
    required this.label,
    required this.icon,
    required this.color,
    this.onPressed,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 20),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: CricTextStyle.badge.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(borderRadius: CricRadius.btnAll),
        ),
      );
    }

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        textStyle: CricTextStyle.badge.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: CricRadius.btnAll),
        elevation: 0,
      ),
    );
  }
}
