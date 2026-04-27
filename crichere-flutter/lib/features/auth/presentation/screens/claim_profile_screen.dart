import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/auth_repository_provider.dart';
import '../../domain/entities/auth_enums.dart';

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
    final selectedRole = useState<PlayingRole>(PlayingRole.batter);
    final isLoading = useState(false);

    return Scaffold(
      appBar: AppBar(title: const Text('Claim Your Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.verified_user, size: 64, color: Colors.blue),
            const SizedBox(height: 24),
            const Text(
              'We found a matching profile!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'A profile with your number was created by a league admin. Is this you?',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Confirm Your Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Select Your Primary Playing Role:'),
            const SizedBox(height: 8),
            DropdownButtonFormField<PlayingRole>(
              value: selectedRole.value,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: PlayingRole.values.map((role) {
                return DropdownMenuItem(
                  value: role,
                  child: Text(role.name.toUpperCase()),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) selectedRole.value = value;
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: isLoading.value
                  ? null
                  : () async {
                      isLoading.value = true;
                      try {
                        await ref.read(authRepositoryProvider).claimProfile(
                          nameController.text,
                          selectedRole.value,
                        );
                        // After claiming, maybe show setup or go home
                        // context.router.replaceAll([const HomeRoute()]);
                      } catch (e) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      } finally {
                        isLoading.value = false;
                      }
                    },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Yes, This is Me'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // TODO: Handle "This is not me" - create fresh profile
              },
              child: const Text('No, Create New Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
