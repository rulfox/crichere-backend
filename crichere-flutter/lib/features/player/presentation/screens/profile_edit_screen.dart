import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
      appBar: AppBar(title: const Text('Edit Cricket Profile')),
      body: userAsync.when(
        data: (user) {
          // Initialize values once
          useEffect(() {
            // Assuming user has these fields, need to check AuthResponse/User entity
            return null;
          }, []);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Primary Role'),
                DropdownButtonFormField<PlayingRole>(
                  initialValue: selectedRole.value,
                  items: PlayingRole.values.map((role) {
                    return DropdownMenuItem(value: role, child: Text(role.name.toUpperCase()));
                  }).toList(),
                  onChanged: (val) => selectedRole.value = val!,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: battingStyle,
                  decoration: const InputDecoration(labelText: 'Batting Style (e.g. RHB)'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: bowlingStyle,
                  decoration: const InputDecoration(labelText: 'Bowling Style (e.g. RAM)'),
                ),
                const SizedBox(height: 32),
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
                  child: const Text('SAVE PROFILE'),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
