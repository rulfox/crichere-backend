import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:async';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import '../providers/auth_repository_provider.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/router/app_router.gr.dart';
import '../../domain/entities/auth_enums.dart';

@RoutePage()
class OtpScreen extends HookConsumerWidget {
  final String phone;

  const OtpScreen({super.key, required this.phone});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllers = List.generate(6, (_) => useTextEditingController());
    final focusNodes = List.generate(6, (_) => useFocusNode());
    final isLoading = useState(false);
    final timeLeft = useState(300);

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

    return Scaffold(
      backgroundColor: CricColor.appBg,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            return Row(
              children: [
                const Expanded(child: _AuthWebBrandingPanel()),
                Container(
                  width: 500,
                  color: CricColor.appBg,
                  padding: const EdgeInsets.symmetric(horizontal: 64),
                  child: _OtpVerifyForm(
                    phone: phone,
                    controllers: controllers,
                    focusNodes: focusNodes,
                    isLoading: isLoading,
                    timeLeft: timeLeft.value,
                    onVerify: () => _handleVerify(context, ref, getOtp(), isLoading),
                  ),
                ),
              ],
            );
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: CricSpacing.page),
              child: _OtpVerifyForm(
                phone: phone,
                controllers: controllers,
                focusNodes: focusNodes,
                isLoading: isLoading,
                timeLeft: timeLeft.value,
                onVerify: () => _handleVerify(context, ref, getOtp(), isLoading),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _handleVerify(BuildContext context, WidgetRef ref, String otp, ValueNotifier<bool> isLoading) async {
    if (otp.length < 6) return;
    
    isLoading.value = true;
    try {
      final response = await ref.read(verifyOtpUseCaseProvider).call(phone, otp);
      if (response.accessToken != null) {
        ref.read(authStateProvider.notifier).setAuthenticated();
        if (!context.mounted) return;
        if (response.isNewUser || response.profileStatus == ProfileStatus.ghost) {
          if (response.profileStatus == ProfileStatus.ghost) {
            context.router.replaceAll([ClaimProfileRoute(profileId: response.userId ?? '', suggestedName: '')]);
          } else {
            context.router.replaceAll([const ProfileSetupRoute()]);
          }
        } else {
          context.router.replaceAll([const HomeRoute()]);
        }
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      isLoading.value = false;
    }
  }
}

class _AuthWebBrandingPanel extends StatelessWidget {
  const _AuthWebBrandingPanel();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [CricColor.navy, CricColor.appBg],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -100,
            top: -100,
            child: Icon(Icons.sports_cricket, size: 400, color: CricColor.gold.withValues(alpha: 0.03)),
          ),
          Padding(
            padding: const EdgeInsets.all(64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('🏏 CRICHERE', style: CricTextStyle.logo.copyWith(fontSize: 48)),
                const Spacer(),
                Text('Real-time live auctions.', style: CricTextStyle.displayLg.copyWith(fontSize: 56)),
                const SizedBox(height: 24),
                Text('Verify your identity and join the league.', style: CricTextStyle.body.copyWith(fontSize: 20, color: CricColor.textDim)),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OtpVerifyForm extends StatelessWidget {
  final String phone;
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final ValueNotifier<bool> isLoading;
  final int timeLeft;
  final VoidCallback onVerify;

  const _OtpVerifyForm({
    required this.phone,
    required this.controllers,
    required this.focusNodes,
    required this.isLoading,
    required this.timeLeft,
    required this.onVerify,
  });

  String formatTime(int seconds) {
    final mins = (seconds / 60).floor();
    final secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 64),
        Text('VERIFY OTP', style: CricTextStyle.overline),
        const SizedBox(height: 16),
        Text('Sent via SMS to +91 $phone', style: CricTextStyle.body.copyWith(color: CricColor.textMid)),
        const SizedBox(height: 48),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            6,
            (index) => SizedBox(
              width: 56,
              height: 64,
              child: TextField(
                controller: controllers[index],
                focusNode: focusNodes[index],
                textAlign: TextAlign.center,
                style: CricTextStyle.displayLg.copyWith(fontSize: 24),
                keyboardType: TextInputType.number,
                maxLength: 1,
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: CricColor.slate3,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(borderRadius: CricRadius.inputAll, borderSide: BorderSide(color: CricColor.borderMid)),
                  focusedBorder: OutlineInputBorder(borderRadius: CricRadius.inputAll, borderSide: const BorderSide(color: CricColor.gold, width: 1.5)),
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
        const SizedBox(height: 48),
        Center(
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.timer_outlined, size: 14, color: CricColor.textDim),
                  const SizedBox(width: 4),
                  Text(
                    formatTime(timeLeft),
                    style: CricTextStyle.timerNumber.copyWith(
                      fontSize: 16,
                      color: timeLeft < 60 ? CricColor.red : CricColor.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('Attempt 1 of 3', style: CricTextStyle.caption),
            ],
          ),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: isLoading.value || timeLeft == 0 ? null : onVerify,
          style: CricButtonStyle.primary,
          child: isLoading.value
              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: CricColor.navy))
              : const Text('VERIFY & CONTINUE →'),
        ),
        const SizedBox(height: 16),
        Center(
          child: TextButton(
            onPressed: timeLeft > 0 ? null : () {},
            child: Text('RESEND OTP', style: CricTextStyle.badge.copyWith(color: timeLeft > 0 ? CricColor.textFaint : CricColor.gold)),
          ),
        ),
        const SizedBox(height: 64),
      ],
    );
  }
}

