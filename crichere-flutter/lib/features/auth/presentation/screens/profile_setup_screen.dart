import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class ProfileSetupScreen extends HookConsumerWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final role = useState<String?>(null);
    final battingStyle = useState<String?>(null);
    final bowlingStyle = useState<String?>(null);
    final isLoading = useState(false);

    final roles = ['BATSMAN', 'BOWLER', 'ALL_ROUNDER', 'WICKET_KEEPER'];
    final battingStyles = ['RIGHT_HAND', 'LEFT_HAND'];
    final bowlingStyles = ['RIGHT_ARM_FAST', 'RIGHT_ARM_SPIN', 'LEFT_ARM_FAST', 'LEFT_ARM_SPIN', 'NONE'];

    return Scaffold(
      appBar: AppBar(title: const Text('Complete Your Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Help us get to know your cricket style!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: role.value,
              decoration: const InputDecoration(
                labelText: 'Playing Role',
                border: OutlineInputBorder(),
              ),
              items: roles.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
              onChanged: (v) => role.value = v,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: battingStyle.value,
              decoration: const InputDecoration(
                labelText: 'Batting Style',
                border: OutlineInputBorder(),
              ),
              items: battingStyles.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (v) => battingStyle.value = v,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: bowlingStyle.value,
              decoration: const InputDecoration(
                labelText: 'Bowling Style',
                border: OutlineInputBorder(),
              ),
              items: bowlingStyles.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (v) => bowlingStyle.value = v,
            ),
            const SizedBox(height: 32),
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
                        // TODO: Implement Update Profile API call
                        // await ref.read(authRepositoryProvider).updateProfile(...)
                        context.router.replaceAll([const HomeRoute()]);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      } finally {
                        isLoading.value = false;
                      }
                    },
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
              child: isLoading.value 
                ? const CircularProgressIndicator() 
                : const Text('Save & Finish'),
            ),
          ],
        ),
      ),
    );
  }
}

// Add HomeRoute for navigation placeholder if not imported correctly
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute() : super('HomeRoute', path: '/home');
}
