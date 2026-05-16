import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'package:crichere_flutter/shared/widgets/cric/cric_widgets.dart';
import '../../../league/presentation/providers/league_repository_provider.dart';
import '../providers/forfeit_providers.dart';
import '../../domain/entities/forfeit_entities.dart';

@RoutePage()
class ForfeitManagementScreen extends ConsumerWidget {
  final String leagueId;

  const ForfeitManagementScreen({super.key, required this.leagueId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestsAsync = ref.watch(forfeitRequestsProvider(leagueId));
    final leagueRepo = ref.watch(leagueRepositoryProvider);

    void showApproveDialog(ForfeitRequest request) {
      final refundController = TextEditingController(text: '0');
      final promoteNext = ValueNotifier(true);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: CricColor.slate2,
          title: Text('Approve Forfeit', style: CricTextStyle.headingMd),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(request.entityName, style: CricTextStyle.body.copyWith(color: CricColor.gold)),
              const SizedBox(height: 8),
              Text('Reason: ${request.reason}', style: CricTextStyle.caption),
              const SizedBox(height: 16),
              TextField(
                controller: refundController,
                keyboardType: TextInputType.number,
                style: CricTextStyle.body,
                decoration: CricDecoration.textField(hint: 'Refund Amount (₹)'),
              ),
              const SizedBox(height: 12),
              ValueListenableBuilder(
                valueListenable: promoteNext,
                builder: (context, value, _) => CheckboxListTile(
                  title: Text('Promote from waitlist', style: CricTextStyle.body),
                  value: value,
                  activeColor: CricColor.gold,
                  onChanged: (v) => promoteNext.value = v!,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('CANCEL', style: CricTextStyle.badge.copyWith(color: CricColor.textDim)),
            ),
            ElevatedButton(
              style: CricButtonStyle.primary,
              onPressed: () async {
                final refund = int.tryParse(refundController.text) ?? 0;
                await leagueRepo.approveForfeit(leagueId, request.id, refund, promoteNext.value);
                ref.invalidate(forfeitRequestsProvider(leagueId));
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text('APPROVE'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: CricColor.appBg,
      appBar: CricAppBar(
        showLogo: false,
        title: 'FORFEIT REQUESTS',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: CricColor.textPrimary),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: Column(
        children: [
          const SectionHeader(title: ' PENDING REQUESTS'),
          Expanded(
            child: requestsAsync.when(
              data: (requests) {
                final pending = requests.where((r) => r.status == 'PENDING').toList();
                if (pending.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle_outline, size: 48, color: CricColor.textFaint),
                        const SizedBox(height: 16),
                        Text('No pending forfeit requests', style: CricTextStyle.body),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: CricSpacing.page),
                  itemCount: pending.length,
                  itemBuilder: (context, index) {
                    final r = pending[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: CricSpacing.sm),
                      child: CricCard(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              const AvatarCircle(name: '', radius: 16),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(r.entityName, style: CricTextStyle.headingMd),
                                    Text('Reason: ${r.reason}', style: CricTextStyle.caption),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => showApproveDialog(r),
                                style: CricButtonStyle.ghost,
                                child: const Text('REVIEW'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => CricErrorView(error: e),
            ),
          ),
        ],
      ),
    );
  }
}
