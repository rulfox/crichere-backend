import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/auth_repository_provider.dart';
import '../../../../core/router/app_router.gr.dart';

@RoutePage()
class PhoneEntryScreen extends HookConsumerWidget {
  const PhoneEntryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneController = useTextEditingController();
    final isLoading = useState(false);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Text(
                'Crichere',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'India\'s First Auction Platform',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixText: '+91 ',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: isLoading.value
                    ? null
                    : () async {
                        isLoading.value = true;
                        try {
                          await ref.read(sendOtpUseCaseProvider).call(phoneController.text);
                          if (!context.mounted) return;
                          context.router.push(OtpRoute(phone: phoneController.text));
                        } catch (e) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        } finally {
                          isLoading.value = false;
                        }
                      },
                child: isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text('Send OTP'),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
