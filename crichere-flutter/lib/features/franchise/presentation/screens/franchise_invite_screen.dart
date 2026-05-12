import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'package:crichere_flutter/shared/widgets/cric/cric_widgets.dart';
import 'package:crichere_flutter/core/router/app_router.gr.dart';
import 'package:crichere_flutter/core/providers/auth_provider.dart';
import '../providers/franchise_providers.dart';
import '../../domain/entities/franchise_invite.dart';

@RoutePage()
class FranchiseInviteScreen extends HookConsumerWidget {
  final String token;

  const FranchiseInviteScreen({super.key, @PathParam('token') required this.token});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final validationAsync = useMemoized(() => ref.read(franchiseRepositoryProvider).validateInvite(token), [token]);
    final AsyncSnapshot<InviteValidationResponse> snapshot = useFuture(validationAsync);
    final authState = ref.watch(authStateProvider);
    final isAccepting = useState(false);

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Scaffold(
        backgroundColor: CricColor.appBg,
        body: Center(child: CircularProgressIndicator(color: CricColor.gold)),
      );
    }

    if (snapshot.hasError) {
      return Scaffold(
        backgroundColor: CricColor.appBg,
        body: Padding(
          padding: const EdgeInsets.all(CricSpacing.page),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: CricColor.red, size: 64),
              const SizedBox(height: 24),
              Text('Invalid or Expired Invite', style: CricTextStyle.displayLg, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              Text(
                'This invite link is no longer valid. Please ask the league admin for a new one.',
                style: CricTextStyle.body.copyWith(color: CricColor.textDim),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: CricButtonStyle.primary,
                onPressed: () => context.router.replaceAll([const HomeRoute()]),
                child: const Text('GO TO HOME'),
              ),
            ],
          ),
        ),
      );
    }

    final invite = snapshot.data!;

    return Scaffold(
      backgroundColor: CricColor.appBg,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [CricColor.gold.withValues(alpha: 0.1), CricColor.appBg],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(CricSpacing.page),
            child: Column(
              children: [
                const Spacer(),
                const Icon(Icons.stadium_outlined, color: CricColor.gold, size: 80),
                const SizedBox(height: 32),
                Text('CRICHERE', style: CricTextStyle.displayLg.copyWith(letterSpacing: 4)),
                const SizedBox(height: 48),
                Text("You've been invited to own", style: CricTextStyle.body.copyWith(color: CricColor.textDim)),
                const SizedBox(height: 12),
                Text(invite.franchiseName, style: CricTextStyle.displayLg, textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.emoji_events_outlined, color: CricColor.gold, size: 16),
                    const SizedBox(width: 8),
                    Text(invite.leagueName, style: CricTextStyle.headingMd.copyWith(color: CricColor.gold)),
                  ],
                ),
                const SizedBox(height: 48),
                CricCard(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      _InviteInfoRow(label: 'Starting Purse', value: '₹50,000'), // Should be dynamic in future
                      const Divider(color: CricColor.borderLight, height: 24),
                      _InviteInfoRow(label: 'Player Slots', value: '15'),
                      const Divider(color: CricColor.borderLight, height: 24),
                      _InviteInfoRow(label: 'Invited By', value: invite.invitedBy),
                    ],
                  ),
                ),
                const Spacer(),
                if (authState == AuthState.authenticated)
                  ElevatedButton(
                    style: CricButtonStyle.primary.copyWith(
                      minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 56)),
                    ),
                    onPressed: isAccepting.value ? null : () async {
                      isAccepting.value = true;
                      try {
                        await ref.read(franchiseRepositoryProvider).acceptInvite(token);
                        if (context.mounted) {
                          context.router.replaceAll([const HomeRoute()]);
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to accept invite: $e')),
                          );
                        }
                      } finally {
                        isAccepting.value = false;
                      }
                    },
                    child: isAccepting.value 
                      ? const CircularProgressIndicator(color: Colors.black)
                      : Text('CLAIM TEAM — ${invite.franchiseName}'),
                  )
                else
                  Column(
                    children: [
                      ElevatedButton(
                        style: CricButtonStyle.primary.copyWith(
                          minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 56)),
                        ),
                        onPressed: () => context.router.push(const PhoneEntryRoute()),
                        child: const Text('LOG IN TO ACCEPT →'),
                      ),
                      const SizedBox(height: 16),
                      Text('Accepting will join you to this franchise.', 
                        style: CricTextStyle.caption, textAlign: TextAlign.center),
                    ],
                  ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InviteInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InviteInfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: CricTextStyle.body.copyWith(color: CricColor.textDim)),
        Text(value, style: CricTextStyle.headingMd),
      ],
    );
  }
}
