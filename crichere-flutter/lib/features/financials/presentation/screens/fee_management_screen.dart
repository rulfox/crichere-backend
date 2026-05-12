import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'package:crichere_flutter/shared/widgets/cric/cric_widgets.dart';
import '../../../league/presentation/providers/league_repository_provider.dart';
import '../providers/fee_providers.dart';
import '../../domain/entities/fee_entities.dart';

@RoutePage()
class FeeManagementScreen extends ConsumerWidget {
  final String leagueId;

  const FeeManagementScreen({super.key, required this.leagueId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final obligationsAsync = ref.watch(feeObligationsProvider(leagueId));
    final leagueRepo = ref.watch(leagueRepositoryProvider);

    void showRecordPaymentDialog(FeeObligation obligation) {
      final amountController = TextEditingController(text: (obligation.totalAmount - obligation.paidAmount).toString());
      final notesController = TextEditingController();
      final mode = ValueNotifier('CASH');

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: CricColor.slate2,
          title: Text('Record Payment', style: CricTextStyle.headingMd),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(obligation.entityName, style: CricTextStyle.body.copyWith(color: CricColor.gold)),
              const SizedBox(height: 16),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                style: CricTextStyle.body,
                decoration: CricDecoration.textField(hint: 'Amount (₹)'),
              ),
              const SizedBox(height: 12),
              ValueListenableBuilder(
                valueListenable: mode,
                builder: (context, value, _) => DropdownButtonFormField<String>(
                  value: value,
                  dropdownColor: CricColor.slate2,
                  decoration: CricDecoration.textField(hint: 'Mode'),
                  items: const [
                    DropdownMenuItem(value: 'CASH', child: Text('Cash', style: TextStyle(color: Colors.white))),
                    DropdownMenuItem(value: 'ONLINE', child: Text('Online', style: TextStyle(color: Colors.white))),
                  ],
                  onChanged: (v) => mode.value = v!,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: notesController,
                style: CricTextStyle.body,
                decoration: CricDecoration.textField(hint: 'Notes (Optional)'),
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
                final amount = int.tryParse(amountController.text);
                if (amount != null && amount > 0) {
                  await leagueRepo.recordPayment(leagueId, obligation.id, amount, mode.value, notesController.text);
                  ref.invalidate(feeObligationsProvider(leagueId));
                  if (context.mounted) Navigator.pop(context);
                }
              },
              child: const Text('RECORD'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: CricColor.appBg,
      appBar: CricAppBar(
        showLogo: false,
        title: 'FEE MANAGEMENT',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: CricColor.textPrimary),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: obligationsAsync.when(
        data: (obligations) {
          final collected = obligations.fold(0, (sum, e) => sum + e.paidAmount);
          final pending = obligations.fold(0, (sum, e) => sum + (e.totalAmount - e.paidAmount));

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(CricSpacing.page),
                child: CricCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatItem(label: 'COLLECTED', value: '₹${collected}', color: CricColor.green),
                      Container(width: 1, height: 40, color: CricColor.borderLight),
                      _StatItem(label: 'PENDING', value: '₹${pending}', color: CricColor.red),
                    ],
                  ),
                ),
              ),
              const SectionHeader(title: ' OBLIGATIONS'),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: CricSpacing.page),
                  itemCount: obligations.length,
                  itemBuilder: (context, index) {
                    final o = obligations[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: CricSpacing.sm),
                      child: CricCard(
                        child: InkWell(
                          onTap: o.status != 'PAID' && o.status != 'WAIVED' ? () => showRecordPaymentDialog(o) : null,
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
                                      Text(o.entityName, style: CricTextStyle.headingMd),
                                      Text('${o.feeType} · ₹${o.paidAmount}/₹${o.totalAmount}', style: CricTextStyle.caption),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CricBadge(
                                      label: o.status,
                                      type: o.status == 'PAID' ? CricBadgeType.green : 
                                            (o.status == 'UNPAID' ? CricBadgeType.red : CricBadgeType.gold),
                                    ),
                                    if (o.auctionEligible)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text('Auction Ready ✓', style: CricTextStyle.caption.copyWith(color: CricColor.green, fontSize: 10)),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatItem({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: CricTextStyle.overline),
        const SizedBox(height: 4),
        Text(value, style: CricTextStyle.displayLg.copyWith(fontSize: 20, color: color)),
      ],
    );
  }
}
