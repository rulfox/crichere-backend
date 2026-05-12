import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
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
      backgroundColor: CricColor.appBg,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            return Row(
              children: [
                Expanded(child: _AuthWebBrandingPanel()),
                Container(
                  width: 500,
                  color: CricColor.appBg,
                  padding: const EdgeInsets.symmetric(horizontal: 64),
                  child: _PhoneEntryForm(phoneController: phoneController, isLoading: isLoading),
                ),
              ],
            );
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: CricSpacing.page),
              child: _PhoneEntryForm(phoneController: phoneController, isLoading: isLoading),
            ),
          );
        },
      ),
    );
  }
}

class _AuthWebBrandingPanel extends StatelessWidget {
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
                Text('India\'s #1 cricket auction platform.', style: CricTextStyle.displayLg.copyWith(fontSize: 56)),
                const SizedBox(height: 24),
                Text('Real-time live auctions for every league.', style: CricTextStyle.body.copyWith(fontSize: 20, color: CricColor.textDim)),
                const SizedBox(height: 64),
                Row(
                  children: [
                    _StatItem(label: 'Leagues', value: '500+'),
                    const SizedBox(width: 48),
                    _StatItem(label: 'Players', value: '50k+'),
                    const SizedBox(width: 48),
                    _StatItem(label: 'Concurrent Viewers', value: '100k+'),
                  ],
                ),
                const Spacer(),
                Text('✓ JWT secured · Keychain/Keystore · No passwords stored', style: CricTextStyle.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label, value;
  const _StatItem({required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(value, style: CricTextStyle.displayLg.copyWith(color: CricColor.gold, fontSize: 32)),
      Text(label, style: CricTextStyle.overline.copyWith(fontSize: 12)),
    ],
  );
}

class _PhoneEntryForm extends HookConsumerWidget {
  final TextEditingController phoneController;
  final ValueNotifier<bool> isLoading;

  const _PhoneEntryForm({required this.phoneController, required this.isLoading});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(flex: 2),
        Center(
          child: Column(
            children: [
              if (MediaQuery.of(context).size.width <= 900) ...[
                Text('🏏 CRICHERE', style: CricTextStyle.logo.copyWith(fontSize: 32)),
                const SizedBox(height: CricSpacing.sm),
              ],
              Text(
                'Your league. Your auction. Live.',
                style: CricTextStyle.body.copyWith(color: CricColor.textMid),
              ),
              const SizedBox(height: CricSpacing.xs),
              Text(
                'India\'s #1 cricket auction platform',
                style: CricTextStyle.caption,
              ),
            ],
          ),
        ),
        const Spacer(flex: 3),
        Text(
          'SIGN IN',
          style: CricTextStyle.overline,
        ),
        const SizedBox(height: CricSpacing.sm),
        Text(
          'Enter your Indian mobile number',
          style: CricTextStyle.headingMd,
        ),
        const SizedBox(height: CricSpacing.xl),
        TextField(
          controller: phoneController,
          style: CricTextStyle.body.copyWith(color: CricColor.textPrimary),
          decoration: CricDecoration.textField(
            hint: '98765 43210',
            prefix: Container(
              padding: const EdgeInsets.only(left: 16, right: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🇮🇳', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 4),
                  Text(
                    '+91',
                    style: CricTextStyle.body.copyWith(
                      color: CricColor.textDim,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: CricSpacing.sm),
        Text(
          'Format: 10-digit number starting with 6-9',
          style: CricTextStyle.caption.copyWith(fontSize: 11),
        ),
        const SizedBox(height: CricSpacing.xxl),
        ElevatedButton(
          onPressed: isLoading.value
              ? null
              : () async {
                  if (phoneController.text.length != 10) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter a valid 10-digit number')),
                    );
                    return;
                  }
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
          style: CricButtonStyle.primary,
          child: isLoading.value
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: CricColor.navy),
                )
              : const Text('🔒 SEND OTP'),
        ),
        const SizedBox(height: CricSpacing.xxl),
        Center(
          child: Text(
            '✓ OTP-only authentication',
            style: CricTextStyle.caption.copyWith(color: CricColor.green),
          ),
        ),
        const Spacer(),
        Center(
          child: Text(
            'v1.0.0 · ap-south-1',
            style: CricTextStyle.mono.copyWith(fontSize: 10),
          ),
        ),
        const SizedBox(height: CricSpacing.md),
      ],
    );
  }
}

