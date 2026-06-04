import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'package:crichere_flutter/shared/widgets/cric/cric_widgets.dart';
import '../providers/auth_repository_provider.dart';
import '../../domain/entities/auth_enums.dart';
import '../../../../core/router/app_router.gr.dart';

@RoutePage()
class ClaimProfileScreen extends HookConsumerWidget {
  final String profileId;
  final String suggestedName;

  const ClaimProfileScreen({
    super.key,
    required this.profileId,
    required this.suggestedName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController(text: suggestedName);
    final selectedRole = useState<PlayingRole>(PlayingRole.allRounder);
    final selectedExperience = useState<ExperienceLevel>(ExperienceLevel.district);
    final battingStyle = useState<BattingStyle>(BattingStyle.rightHand);
    final bowlingType = useState<BowlingType>(BowlingType.offSpin);
    final cityController = useTextEditingController();
    final jerseyController = useTextEditingController();
    final isLoading = useState(false);

    return Scaffold(
      backgroundColor: CricColor.appBg,
      appBar: const CricAppBar(showLogo: true, title: 'CLAIM PROFILE'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: CricSpacing.page),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: CricSpacing.xl),
            const Center(
              child: Stack(
                children: [
                  AvatarCircle(name: '?', radius: 48),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: CricColor.gold,
                      radius: 14,
                      child: Icon(Icons.camera_alt, size: 14, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Center(child: Text('Tap to upload · JPEG/PNG/WebP', style: CricTextStyle.caption)),
            const SizedBox(height: 24),
            Text(
              'Ghost profile found!',
              style: CricTextStyle.displayLg.copyWith(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: CricSpacing.sm),
            Text(
              'A profile with your number was created by a league admin. Is this you?',
              style: CricTextStyle.body,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: CricSpacing.xxl),
            CricCard(
              padding: const EdgeInsets.all(CricSpacing.base),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const AvatarCircle(name: 'Rahul Kumar', radius: 18),
                      const SizedBox(width: CricSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Pre-added to TechCup 2026', style: CricTextStyle.headingMd),
                            Text('By Rahul Kumar', style: CricTextStyle.caption),
                          ],
                        ),
                      ),
                      const CricBadge(label: 'GHOST', type: CricBadgeType.gray),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: CricSpacing.xxl),
            Text('CONFIRM YOUR DETAILS', style: CricTextStyle.overline),
            const SizedBox(height: CricSpacing.md),
            TextField(
              controller: nameController,
              style: CricTextStyle.body,
              decoration: CricDecoration.textField(hint: 'Full Name'),
            ),
            const SizedBox(height: CricSpacing.lg),
            Text('PLAYING ROLE', style: CricTextStyle.overline),
            const SizedBox(height: CricSpacing.sm),
            Wrap(
              spacing: CricSpacing.sm,
              children: PlayingRole.values.map((role) {
                final isSelected = selectedRole.value == role;
                return ChoiceChip(
                  label: Text(role.name.toUpperCase()),
                  selected: isSelected,
                  onSelected: (_) => selectedRole.value = role,
                  selectedColor: CricColor.gold.withValues(alpha: 0.2),
                  labelStyle: CricTextStyle.badge.copyWith(color: isSelected ? CricColor.gold : CricColor.textFaint),
                  backgroundColor: CricColor.slate3,
                );
              }).toList(),
            ),
            const SizedBox(height: CricSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('BATTING', style: CricTextStyle.overline),
                      const SizedBox(height: CricSpacing.sm),
                      DropdownButtonFormField<BattingStyle>(
                        initialValue: battingStyle.value,
                        dropdownColor: CricColor.slate2,
                        decoration: CricDecoration.textField(hint: 'Style'),
                        items: BattingStyle.values.map((s) => DropdownMenuItem(value: s, child: Text(s.name, style: const TextStyle(color: Colors.white)))).toList(),
                        onChanged: (v) => battingStyle.value = v!,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('BOWLING', style: CricTextStyle.overline),
                      const SizedBox(height: CricSpacing.sm),
                      DropdownButtonFormField<BowlingType>(
                        value: bowlingType.value,
                        dropdownColor: CricColor.slate2,
                        decoration: CricDecoration.textField(hint: 'Type'),
                        items: BowlingType.values.map((s) => DropdownMenuItem(value: s, child: Text(s.name, style: const TextStyle(color: Colors.white)))).toList(),
                        onChanged: (v) => bowlingType.value = v!,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: CricSpacing.lg),
            Text('EXPERIENCE LEVEL', style: CricTextStyle.overline),
            const SizedBox(height: CricSpacing.sm),
            Wrap(
              spacing: CricSpacing.sm,
              children: ExperienceLevel.values.map((exp) {
                final isSelected = selectedExperience.value == exp;
                return ChoiceChip(
                  label: Text(exp.name.toUpperCase()),
                  selected: isSelected,
                  onSelected: (_) => selectedExperience.value = exp,
                  selectedColor: CricColor.gold.withValues(alpha: 0.2),
                  labelStyle: CricTextStyle.badge.copyWith(color: isSelected ? CricColor.gold : CricColor.textFaint),
                  backgroundColor: CricColor.slate3,
                );
              }).toList(),
            ),
            const SizedBox(height: CricSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('CITY', style: CricTextStyle.overline),
                      const SizedBox(height: CricSpacing.sm),
                      TextField(
                        controller: cityController,
                        style: CricTextStyle.body,
                        decoration: CricDecoration.textField(hint: 'City'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: CricSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('JERSEY #', style: CricTextStyle.overline),
                      const SizedBox(height: CricSpacing.sm),
                      TextField(
                        controller: jerseyController,
                        style: CricTextStyle.body,
                        keyboardType: TextInputType.number,
                        decoration: CricDecoration.textField(hint: '7'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: CricSpacing.xxl),
            ElevatedButton(
              onPressed: isLoading.value
                  ? null
                  : () async {
                      isLoading.value = true;
                      try {
                        await ref.read(authRepositoryProvider).claimProfile(
                          name: nameController.text,
                          playingRole: selectedRole.value,
                          experienceLevel: selectedExperience.value,
                          battingStyle: battingStyle.value,
                          bowlingType: bowlingType.value,
                          city: cityController.text,
                          jerseyNumber: jerseyController.text,
                        );
                        if (context.mounted) {
                          context.router.replaceAll([const HomeRoute()]);
                        }
                      } catch (e) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      } finally {
                        isLoading.value = false;
                      }
                    },
              style: CricButtonStyle.success,
              child: isLoading.value
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Text('✓ CONFIRM & ACTIVATE PROFILE'),
            ),
            const SizedBox(height: CricSpacing.base),
            Center(
              child: TextButton(
                onPressed: () {
                  context.router.replaceAll([const ProfileSetupRoute()]);
                },
                child: Text(
                  'NO, CREATE NEW PROFILE',
                  style: CricTextStyle.badge.copyWith(color: CricColor.textFaint),
                ),
              ),
            ),
            const SizedBox(height: CricSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
