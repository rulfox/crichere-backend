import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'package:crichere_flutter/shared/widgets/cric/cric_widgets.dart';
import '../../../auth/presentation/providers/auth_repository_provider.dart';
import '../../../auth/domain/entities/auth_enums.dart';

@RoutePage()
class ProfileEditScreen extends HookConsumerWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final selectedRole = useState<PlayingRole>(PlayingRole.batter);
    final battingStyle = useTextEditingController();
    final bowlingStyle = useTextEditingController();
    final isLoading = useState(false);

    return Scaffold(
      backgroundColor: CricColor.appBg,
      appBar: CricAppBar(
        showLogo: false,
        title: 'EDIT CRICKET PROFILE',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: CricColor.textPrimary),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: userAsync.when(
        data: (user) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(CricSpacing.page),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Stack(
                    children: [
                      AvatarCircle(name: user.name ?? 'P', radius: 50),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: CricColor.gold,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.edit, size: 16, color: CricColor.navy),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: CricSpacing.xxl),
                Text('PRIMARY ROLE', style: CricTextStyle.overline),
                const SizedBox(height: CricSpacing.sm),
                DropdownButtonFormField<PlayingRole>(
                  initialValue: selectedRole.value,
                  dropdownColor: CricColor.navyMid,
                  style: CricTextStyle.body.copyWith(color: CricColor.textPrimary),
                  decoration: CricDecoration.textField(hint: 'Select Role'),
                  items: PlayingRole.values.map((role) {
                    return DropdownMenuItem(value: role, child: Text(role.name.toUpperCase()));
                  }).toList(),
                  onChanged: (val) => selectedRole.value = val!,
                ),
                const SizedBox(height: CricSpacing.lg),
                Text('BATTING STYLE', style: CricTextStyle.overline),
                const SizedBox(height: CricSpacing.sm),
                TextField(
                  controller: battingStyle,
                  style: CricTextStyle.body,
                  decoration: CricDecoration.textField(hint: 'e.g. RHB'),
                ),
                const SizedBox(height: CricSpacing.lg),
                Text('BOWLING STYLE', style: CricTextStyle.overline),
                const SizedBox(height: CricSpacing.sm),
                TextField(
                  controller: bowlingStyle,
                  style: CricTextStyle.body,
                  decoration: CricDecoration.textField(hint: 'e.g. RAM'),
                ),
                const SizedBox(height: CricSpacing.xxl),
                ElevatedButton(
                  onPressed: isLoading.value ? null : () async {
                    isLoading.value = true;
                    try {
                      await ref.read(authRepositoryProvider).updateCricketProfile(
                        user.userId ?? '',
                        selectedRole.value,
                        battingStyle.text,
                        bowlingStyle.text,
                      );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Profile updated successfully')),
                        );
                        context.router.pop();
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    } finally {
                      isLoading.value = false;
                    }
                  },
                  style: CricButtonStyle.primary,
                  child: isLoading.value 
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: CricColor.navy)) 
                    : const Text('SAVE CHANGES'),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: CricColor.gold)),
        error: (e, _) => Center(child: Text('Error: $e', style: const TextStyle(color: Colors.red))),
      ),
    );
  }
}
