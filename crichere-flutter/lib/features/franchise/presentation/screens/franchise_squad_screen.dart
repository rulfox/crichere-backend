import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../providers/franchise_providers.dart';
import 'package:crichere_flutter/core/export/export_service.dart';

@RoutePage()
class FranchiseSquadScreen extends ConsumerStatefulWidget {
  final String franchiseId;

  const FranchiseSquadScreen({super.key, required this.franchiseId});

  @override
  ConsumerState<FranchiseSquadScreen> createState() => _FranchiseSquadScreenState();
}

class _FranchiseSquadScreenState extends ConsumerState<FranchiseSquadScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();
  final _exportService = ExportService();

  @override
  Widget build(BuildContext context) {
    final squadAsync = ref.watch(squadProvider(widget.franchiseId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Franchise Squad'),
        actions: [
          squadAsync.whenData((squad) => IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () => _exportService.exportSquadToPdf(squad),
          )).value ?? const SizedBox.shrink(),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              final image = await _screenshotController.capture();
              if (image != null) {
                final directory = await getTemporaryDirectory();
                final imagePath = await File('${directory.path}/squad.png').create();
                await imagePath.writeAsBytes(image);
                await Share.shareXFiles([XFile(imagePath.path)], text: 'My Crichere Squad');
              }
            },
          ),
        ],
      ),
      body: squadAsync.when(
        data: (squad) => Screenshot(
          controller: _screenshotController,
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.blue[50],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Purse Remaining:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('₹${squad.purseRemaining}', style: const TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: squad.players.length,
                    itemBuilder: (context, index) {
                      final player = squad.players[index];
                      return Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(radius: 30, child: Icon(Icons.person)),
                            const SizedBox(height: 8),
                            Text(player.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text(player.role),
                            const SizedBox(height: 4),
                            Chip(
                              label: Text(player.assignmentType, style: const TextStyle(fontSize: 10)),
                              visualDensity: VisualDensity.compact,
                            ),
                            Text('₹${player.price}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
