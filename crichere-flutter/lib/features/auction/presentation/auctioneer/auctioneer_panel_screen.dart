import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/auction_provider.dart';
import '../providers/auction_state_provider.dart';
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
    
    final selectedFranchiseId = useState<String?>(null);

    void showForceAssignDialog(String playerId, String playerName) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Force Assign $playerName'),
          content: franchisesAsync.when(
            data: (franchises) => DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Select Franchise'),
              items: franchises.map((f) => DropdownMenuItem(value: f.id, child: Text(f.name))).toList(),
              onChanged: (val) => selectedFranchiseId.value = val,
            ),
            loading: () => const CircularProgressIndicator(),
            error: (e, _) => Text('Error loading franchises: $e'),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL')),
            ElevatedButton(
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
          title: Text('Pre-Assign $playerName'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                initialValue: type.value,
                items: const [
                  DropdownMenuItem(value: 'CAPTAIN', child: Text('CAPTAIN (Deduct Purse)')),
                  DropdownMenuItem(value: 'ICON', child: Text('ICON (Free)')),
                ],
                onChanged: (val) => type.value = val!,
              ),
              const SizedBox(height: 16),
              franchisesAsync.when(
                data: (franchises) => DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Select Franchise'),
                  items: franchises.map((f) => DropdownMenuItem(value: f.id, child: Text(f.name))).toList(),
                  onChanged: (val) => selectedFranchiseId.value = val,
                ),
                loading: () => const CircularProgressIndicator(),
                error: (e, _) => Text('Error: $e'),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL')),
            ElevatedButton(
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
          title: const Text('Undo Sold?'),
          content: TextField(
            controller: reasonController,
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Reason for undoing'),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL')),
            ElevatedButton(
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
          appBar: AppBar(title: const Text('Auctioneer Control Panel')),
          body: Row(
            children: [
              // Left Column: Player Pool
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.grey[100],
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.shuffle),
                          label: const Text('RANDOM NEXT'),
                          onPressed: () => auctionRepo.putRandomPlayer(auctionId),
                        ),
                      ),
                      const Divider(),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('AVAILABLE PLAYERS', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        child: playersAsync.when(
                          data: (players) => ListView.builder(
                            itemCount: players.length,
                            itemBuilder: (context, index) {
                              final p = players[index];
                              return ListTile(
                                title: Text(p.playerName),
                                subtitle: Text('Base: ₹${p.basePriceOverride ?? "Default"}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.assignment_ind, size: 20),
                                      onPressed: () => showPreAssignDialog(p.playerId, p.playerName),
                                      tooltip: 'Pre-assign',
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.flash_on, size: 20),
                                      onPressed: () => showForceAssignDialog(p.playerId, p.playerName),
                                      tooltip: 'Force Assign',
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
              ),
              
              // Right Column: Control Panel
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      if (auctionState.currentPlayerName != null) ...[
                        Semantics(
                          liveRegion: true,
                          child: Text(
                            'Current Player: ${auctionState.currentPlayerName}',
                            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 32),
                        const Text('CURRENT BID', style: TextStyle(color: Colors.grey)),
                        Semantics(
                          liveRegion: true,
                          label: 'Current bid is ${auctionState.currentBid}',
                          child: Text(
                            '₹${auctionState.currentBid}',
                            style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: Colors.blue),
                          ),
                        ),
                        Text('Leading: ${auctionState.leadingFranchise ?? "No Bids"}'),
                        
                        const Spacer(),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _ActionButton(label: 'UNDO BID (Ctrl+Z)', icon: Icons.undo, color: Colors.red, onPressed: () => auctionState.status == 'BIDDING' ? auctionRepo.undoBid(auctionId) : null, isOutlined: true),
                            _ActionButton(label: 'UNSOLD', icon: Icons.close, color: Colors.orange, onPressed: () => auctionRepo.markUnsold(auctionId)),
                            _ActionButton(label: 'SOLD (Enter)', icon: Icons.check, color: Colors.green, onPressed: () => auctionRepo.markSold(auctionId)),
                          ],
                        ),
                      ] else
                        const Center(child: Text('Select a player to start')),
                      
                      if (auctionState.status == 'SOLD')
                        TextButton.icon(
                          icon: const Icon(Icons.history),
                          label: const Text('UNDO SOLD'),
                          onPressed: showUndoSoldDialog,
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

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;
  final bool isOutlined;

  const _ActionButton({required this.label, required this.icon, required this.color, required this.onPressed, this.isOutlined = false});

  @override
  Widget build(BuildContext context) {
    final style = isOutlined 
      ? OutlinedButton.styleFrom(foregroundColor: color, side: BorderSide(color: color), padding: const EdgeInsets.all(20))
      : ElevatedButton.styleFrom(backgroundColor: color, foregroundColor: Colors.white, padding: const EdgeInsets.all(20));
    
    return isOutlined 
      ? OutlinedButton.icon(onPressed: onPressed, icon: Icon(icon), label: Text(label), style: style)
      : ElevatedButton.icon(onPressed: onPressed, icon: Icon(icon), label: Text(label), style: style);
  }
}
