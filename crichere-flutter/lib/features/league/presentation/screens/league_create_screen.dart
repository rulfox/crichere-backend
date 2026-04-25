import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:file_picker/file_picker.dart' as fp;
import 'dart:io';
import '../providers/league_repository_provider.dart';
import '../../data/models/league_request.dart';

@RoutePage()
class LeagueCreateScreen extends HookConsumerWidget {
  const LeagueCreateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final format = useState('T20');
    final basePrice = useTextEditingController(text: '100000');
    final purse = useTextEditingController(text: '10000000');
    final maxPlayers = useTextEditingController(text: '15');
    final waitingListMode = useState('AUTO_PROMOTE');
    final selectedFile = useState<File?>(null);
    final isLoading = useState(false);

    Future<void> pickFile() async {
      final result = await fp.FilePicker.pickFiles(
        type: fp.FileType.custom,
        allowedExtensions: ['csv'],
      );
      if (result != null && result.files.single.path != null) {
        selectedFile.value = File(result.files.single.path!);
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Create New League')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'League Name', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: format.value,
              decoration: const InputDecoration(labelText: 'Match Format', border: OutlineInputBorder()),
              items: ['T20', 'ODI', 'TEST'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => format.value = v!,
            ),
            const SizedBox(height: 16),
            TextField(controller: basePrice, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Default Base Price (₹)', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            TextField(controller: purse, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Purse Per Franchise (₹)', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            TextField(controller: maxPlayers, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Max Players Per Franchise', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: waitingListMode.value,
              decoration: const InputDecoration(labelText: 'Waiting List Mode', border: OutlineInputBorder()),
              items: ['AUTO_PROMOTE', 'MANUAL'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => waitingListMode.value = v!,
            ),
            const SizedBox(height: 24),
            const Text('Player Import (CSV)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              icon: const Icon(Icons.upload_file),
              label: Text(selectedFile.value == null ? 'SELECT CSV FILE' : 'FILE SELECTED: ${selectedFile.value!.path.split("/").last}'),
              onPressed: pickFile,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: isLoading.value
                  ? null
                  : () async {
                      isLoading.value = true;
                      try {
                        final league = await ref.read(createLeagueUseCaseProvider).call(
                          LeagueCreateRequest(
                            name: nameController.text,
                            format: format.value,
                            basePrice: int.parse(basePrice.text),
                            purseAmount: int.parse(purse.text),
                            maxPlayersPerFranchise: int.parse(maxPlayers.text),
                            waitingListMode: waitingListMode.value,
                          ),
                        );
                        
                        if (selectedFile.value != null) {
                          await ref.read(importPlayersUseCaseProvider).call(league.id, selectedFile.value!);
                        }
                        
                        if (context.mounted) {
                          context.router.pop();
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('League created successfully!')));
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                        }
                      } finally {
                        isLoading.value = false;
                      }
                    },
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16), backgroundColor: Colors.blue, foregroundColor: Colors.white),
              child: isLoading.value ? const CircularProgressIndicator(color: Colors.white) : const Text('CREATE LEAGUE'),
            ),
          ],
        ),
      ),
    );
  }
}
