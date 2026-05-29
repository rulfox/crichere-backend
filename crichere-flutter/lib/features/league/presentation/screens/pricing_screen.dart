import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'package:crichere_flutter/shared/widgets/cric/cric_widgets.dart';
import '../providers/league_repository_provider.dart';
import '../providers/pricing_providers.dart';

/// Base-price editor for player categories and tags
/// (`/leagues/{id}/category-prices` and `/tag-prices`).
@RoutePage()
class PricingScreen extends ConsumerWidget {
  final String leagueId;
  const PricingScreen({super.key, required this.leagueId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryPricesProvider(leagueId));
    final tags = ref.watch(tagPricesProvider(leagueId));
    final repo = ref.watch(leagueRepositoryProvider);

    Future<void> editPrice({
      required String title,
      required String labelHint,
      String? initialLabel,
      int? initialPrice,
      required Future<void> Function(String label, int price) onSave,
      required void Function() onDone,
    }) async {
      final labelController = TextEditingController(text: initialLabel ?? '');
      final priceController = TextEditingController(text: initialPrice?.toString() ?? '');
      final lockLabel = initialLabel != null;

      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          backgroundColor: CricColor.slate2,
          title: Text(title, style: CricTextStyle.headingMd),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: labelController,
                enabled: !lockLabel,
                style: CricTextStyle.body,
                decoration: CricDecoration.textField(hint: labelHint),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                style: CricTextStyle.body,
                decoration: CricDecoration.textField(hint: 'Base price (₹)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text('CANCEL', style: CricTextStyle.badge.copyWith(color: CricColor.textDim)),
            ),
            ElevatedButton(
              style: CricButtonStyle.primary,
              onPressed: () async {
                final label = labelController.text.trim();
                final price = int.tryParse(priceController.text.trim());
                if (label.isEmpty || price == null) return;
                try {
                  await onSave(label, price);
                  if (dialogContext.mounted) Navigator.pop(dialogContext);
                  onDone();
                } catch (e) {
                  if (dialogContext.mounted) {
                    ScaffoldMessenger.of(dialogContext)
                        .showSnackBar(SnackBar(content: Text('Save failed: $e')));
                  }
                }
              },
              child: const Text('SAVE'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: CricColor.appBg,
      appBar: CricAppBar(
        showLogo: false,
        title: 'BASE PRICING',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: CricColor.textPrimary),
          onPressed: () => context.router.maybePop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(CricSpacing.page),
        children: [
          _PriceSection(
            title: 'CATEGORY PRICES',
            async: categories,
            labelOf: (e) => e.category,
            priceOf: (e) => e.price,
            onAdd: () => editPrice(
              title: 'Add category price',
              labelHint: 'Category (e.g. ICON)',
              onSave: (label, price) => repo.updateCategoryPrice(leagueId, label, price),
              onDone: () => ref.invalidate(categoryPricesProvider(leagueId)),
            ),
            onEdit: (label, price) => editPrice(
              title: 'Edit $label',
              labelHint: 'Category',
              initialLabel: label,
              initialPrice: price,
              onSave: (l, p) => repo.updateCategoryPrice(leagueId, l, p),
              onDone: () => ref.invalidate(categoryPricesProvider(leagueId)),
            ),
          ),
          const SizedBox(height: CricSpacing.xl),
          _PriceSection(
            title: 'TAG PRICES',
            async: tags,
            labelOf: (e) => e.tag,
            priceOf: (e) => e.price,
            onAdd: () => editPrice(
              title: 'Add tag price',
              labelHint: 'Tag (e.g. MARQUEE)',
              onSave: (label, price) => repo.updateTagPrice(leagueId, label, price),
              onDone: () => ref.invalidate(tagPricesProvider(leagueId)),
            ),
            onEdit: (label, price) => editPrice(
              title: 'Edit $label',
              labelHint: 'Tag',
              initialLabel: label,
              initialPrice: price,
              onSave: (l, p) => repo.updateTagPrice(leagueId, l, p),
              onDone: () => ref.invalidate(tagPricesProvider(leagueId)),
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceSection<T> extends StatelessWidget {
  final String title;
  final AsyncValue<List<T>> async;
  final String Function(T) labelOf;
  final int Function(T) priceOf;
  final VoidCallback onAdd;
  final void Function(String label, int price) onEdit;

  const _PriceSection({
    required this.title,
    required this.async,
    required this.labelOf,
    required this.priceOf,
    required this.onAdd,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SectionHeader(title: title),
            TextButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add, size: 16, color: CricColor.gold),
              label: Text('ADD', style: CricTextStyle.badge.copyWith(color: CricColor.gold)),
            ),
          ],
        ),
        async.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: CircularProgressIndicator(color: CricColor.gold)),
          ),
          error: (e, _) => CricErrorView(error: e),
          data: (items) {
            if (items.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text('None set yet', style: CricTextStyle.caption),
              );
            }
            return Column(
              children: items.map((e) {
                final label = labelOf(e);
                final price = priceOf(e);
                return Padding(
                  padding: const EdgeInsets.only(bottom: CricSpacing.sm),
                  child: CricCard(
                    onTap: () => onEdit(label, price),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(label, style: CricTextStyle.headingMd),
                        Text('₹$price', style: CricTextStyle.headingMd.copyWith(color: CricColor.gold)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
