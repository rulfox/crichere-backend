import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'package:crichere_flutter/shared/widgets/cric/cric_widgets.dart';
import '../providers/league_repository_provider.dart';
import '../../data/models/league_request.dart';

@RoutePage()
class LeagueCreateScreen extends HookConsumerWidget {
  const LeagueCreateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final format = useState('T20');
    final basePrice = useTextEditingController(text: '1000');
    final purse = useTextEditingController(text: '40000');
    final maxPlayers = useTextEditingController(text: '15');
    final waitingListMode = useState('AUTO_PROMOTE');
    final selectedFile = useState<File?>(null);
    final isLoading = useState(false);

    Future<void> pickFile() async {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );
      if (result != null && result.files.single.path != null) {
        selectedFile.value = File(result.files.single.path!);
      }
    }

    return Scaffold(
      backgroundColor: CricColor.appBg,
      appBar: CricAppBar(
        showLogo: false,
        title: 'CREATE LEAGUE',
        leading: IconButton(
          icon: const Icon(Icons.close, color: CricColor.textPrimary),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(CricSpacing.page),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('LEAGUE DETAILS', style: CricTextStyle.overline),
            const SizedBox(height: CricSpacing.md),
            TextField(
              controller: nameController,
              style: CricTextStyle.body,
              decoration: CricDecoration.textField(hint: 'League Name (e.g. TechCup 2026)'),
            ),
            const SizedBox(height: CricSpacing.lg),
            Text('FORMAT', style: CricTextStyle.overline),
            const SizedBox(height: CricSpacing.sm),
            DropdownButtonFormField<String>(
              initialValue: format.value,
              dropdownColor: CricColor.navyMid,
              style: CricTextStyle.body.copyWith(color: CricColor.textPrimary),
              decoration: CricDecoration.textField(hint: 'Match Format'),
              items: ['T20', 'T10', 'ODI', 'TEST'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => format.value = v!,
            ),
            const SizedBox(height: CricSpacing.xl),
            Text('AUCTION RULES', style: CricTextStyle.overline),
            const SizedBox(height: CricSpacing.md),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('START PURSE', style: CricTextStyle.caption),
                      const SizedBox(height: CricSpacing.xs),
                      TextField(
                        controller: purse,
                        keyboardType: TextInputType.number,
                        style: CricTextStyle.body,
                        decoration: CricDecoration.textField(hint: '₹40,000'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: CricSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('BASE PRICE', style: CricTextStyle.caption),
                      const SizedBox(height: CricSpacing.xs),
                      TextField(
                        controller: basePrice,
                        keyboardType: TextInputType.number,
                        style: CricTextStyle.body,
                        decoration: CricDecoration.textField(hint: '₹1,000'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: CricSpacing.lg),
            Text('WAITING LIST MODE', style: CricTextStyle.overline),
            const SizedBox(height: CricSpacing.sm),
            DropdownButtonFormField<String>(
              initialValue: waitingListMode.value,
              dropdownColor: CricColor.navyMid,
              style: CricTextStyle.body.copyWith(color: CricColor.textPrimary),
              decoration: CricDecoration.textField(hint: 'Select Mode'),
              items: ['AUTO_PROMOTE', 'ADMIN_PICKS'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => waitingListMode.value = v!,
            ),
            const SizedBox(height: CricSpacing.xxl),
            Text('PLAYER IMPORT', style: CricTextStyle.overline),
            const SizedBox(height: CricSpacing.sm),
            CricCard(
              padding: const EdgeInsets.all(CricSpacing.base),
              onTap: pickFile,
              child: Column(
                children: [
                  const Icon(Icons.cloud_upload_outlined, size: 32, color: CricColor.gold),
                  const SizedBox(height: CricSpacing.sm),
                  Text(
                    selectedFile.value == null 
                        ? 'TAP TO UPLOAD CSV' 
                        : selectedFile.value!.path.split("/").last,
                    style: CricTextStyle.body.copyWith(color: CricColor.gold, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text('CSV format: phone, name, category, price', style: CricTextStyle.caption),
                ],
              ),
            ),
            const SizedBox(height: CricSpacing.xxl),
            ElevatedButton(
              onPressed: isLoading.value
                  ? null
                  : () async {
                      if (nameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('League name is required')));
                        return;
                      }
                      isLoading.value = true;
                      try {
                        final league = await ref.read(createLeagueUseCaseProvider).call(
                          LeagueCreateRequest(
                            name: nameController.text,
                            format: format.value,
                            waitingListMode: waitingListMode.value,
                          ),
                        );
                        
                        // importPlayers now expects JSON list — file import via CSV removed
                        // Players can be imported via the backend dashboard or API directly
                        
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
              style: CricButtonStyle.primary,
              child: isLoading.value 
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: CricColor.navy)) 
                : const Text('CREATE LEAGUE'),
            ),
            const SizedBox(height: CricSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
