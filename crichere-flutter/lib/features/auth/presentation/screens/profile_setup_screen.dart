import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'package:crichere_flutter/shared/widgets/cric/cric_widgets.dart';
import '../../../../core/router/app_router.gr.dart';
import '../../domain/entities/auth_enums.dart';
import '../providers/auth_repository_provider.dart';

@RoutePage()
class ProfileSetupScreen extends HookConsumerWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final role = useState<PlayingRole?>(null);
    final battingStyle = useState<BattingStyle?>(null);
    final bowlingStyle = useState<BowlingStyle?>(null);
    final isLoading = useState(false);

    return Scaffold(
      backgroundColor: CricColor.appBg,
      appBar: const CricAppBar(showLogo: true, title: 'PROFILE SETUP'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: CricSpacing.page),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: CricSpacing.xxl),
            Text(
              'CREATE YOUR PROFILE',
              style: CricTextStyle.displayLg.copyWith(fontSize: 24),
            ),
            const SizedBox(height: CricSpacing.sm),
            Text(
              'Help us get to know your cricket style!',
              style: CricTextStyle.body,
            ),
            const SizedBox(height: CricSpacing.xxl),
            Center(
              child: Stack(
                children: [
                  const AvatarCircle(name: '', radius: 50),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: CricColor.gold,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, size: 20, color: CricColor.navy),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: CricSpacing.xxl),
            Text('FULL NAME', style: CricTextStyle.overline),
            const SizedBox(height: CricSpacing.sm),
            TextField(
              controller: nameController,
              style: CricTextStyle.body,
              decoration: CricDecoration.textField(hint: 'e.g. Anjali Sharma'),
            ),
            const SizedBox(height: CricSpacing.lg),
            Text('PLAYING ROLE', style: CricTextStyle.overline),
            const SizedBox(height: CricSpacing.sm),
            DropdownButtonFormField<PlayingRole>(
              initialValue: role.value,
              dropdownColor: CricColor.navyMid,
              style: CricTextStyle.body.copyWith(color: CricColor.textPrimary),
              decoration: CricDecoration.textField(hint: 'Select Role'),
              items: PlayingRole.values.map((r) => DropdownMenuItem(value: r, child: Text(r.name.toUpperCase()))).toList(),
              onChanged: (v) => role.value = v,
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
                        dropdownColor: CricColor.navyMid,
                        style: CricTextStyle.body.copyWith(color: CricColor.textPrimary),
                        decoration: CricDecoration.textField(hint: 'Style'),
                        items: BattingStyle.values.map((s) => DropdownMenuItem(value: s, child: Text(s.name.toUpperCase()))).toList(),
                        onChanged: (v) => battingStyle.value = v,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: CricSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('BOWLING', style: CricTextStyle.overline),
                      const SizedBox(height: CricSpacing.sm),
                      DropdownButtonFormField<BowlingStyle>(
                        initialValue: bowlingStyle.value,
                        dropdownColor: CricColor.navyMid,
                        style: CricTextStyle.body.copyWith(color: CricColor.textPrimary),
                        decoration: CricDecoration.textField(hint: 'Style'),
                        items: BowlingStyle.values.map((s) => DropdownMenuItem(value: s, child: Text(s.name.toUpperCase()))).toList(),
                        onChanged: (v) => bowlingStyle.value = v,
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
                      if (nameController.text.isEmpty || role.value == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please fill required fields')),
                        );
                        return;
                      }
                      isLoading.value = true;
                      try {
                        final user = await ref.read(currentUserProvider.future);
                        await ref.read(authRepositoryProvider).updateCricketProfile(
                          user.id,
                          role.value!,
                          battingStyle.value?.name ?? '',
                          bowlingStyle.value?.name ?? '',
                        );
                        if (!context.mounted) return;
                        context.router.replaceAll([const HomeRoute()]);
                      } catch (e) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      } finally {
                        isLoading.value = false;
                      }
                    },
              style: CricButtonStyle.primary,
              child: isLoading.value 
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: CricColor.navy),
                  ) 
                : const Text('SAVE & FINISH'),
            ),
            const SizedBox(height: CricSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
