import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:async';
import '../providers/auth_repository_provider.dart';
import '../../../../core/providers/auth_provider.dart';

@RoutePage()
class OtpScreen extends HookConsumerWidget {
  final String phone;

  const OtpScreen({super.key, required this.phone});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllers = List.generate(6, (_) => useTextEditingController());
    final focusNodes = List.generate(6, (_) => useFocusNode());
    final isLoading = useState(false);
    final timeLeft = useState(300); // 5 minutes in seconds

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (timeLeft.value > 0) {
          timeLeft.value--;
        } else {
          timer.cancel();
        }
      });
      return timer.cancel;
    }, []);

    String getOtp() => controllers.map((c) => c.text).join();

    String formatTime(int seconds) {
      final mins = (seconds / 60).floor();
      final secs = seconds % 60;
      return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter the 6-digit code sent to\n+91 $phone',
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                6,
                (index) => SizedBox(
                  width: 45,
                  child: TextField(
                    controller: controllers[index],
                    focusNode: focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: const InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        focusNodes[index + 1].requestFocus();
                      } else if (value.isEmpty && index > 0) {
                        focusNodes[index - 1].requestFocus();
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Time remaining: ${formatTime(timeLeft.value)}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: timeLeft.value < 60 ? Colors.red : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: isLoading.value || timeLeft.value == 0
                  ? null
                  : () async {
                      final otp = getOtp();
                      if (otp.length < 6) return;
                      
                      isLoading.value = true;
                      try {
                        final response = await ref.read(authRepositoryProvider).verify(phone, otp);
                        if (response.accessToken != null) {
                           ref.read(authStateProvider.notifier).setAuthenticated();
                           // Navigation handled by router based on auth state
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      } finally {
                        isLoading.value = false;
                      }
                    },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: isLoading.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Verify & Proceed'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: timeLeft.value > 0 
                ? null 
                : () {
                    // TODO: Implement Resend OTP
                    timeLeft.value = 300;
                  },
              child: const Text('Resend OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
