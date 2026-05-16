import 'package:flutter/material.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';

class CricErrorView extends StatelessWidget {
  final Object error;
  final VoidCallback? onRetry;
  final String? message;

  const CricErrorView({
    super.key,
    required this.error,
    this.onRetry,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(CricSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: CricColor.red, size: 48),
            const SizedBox(height: CricSpacing.md),
            Text(
              message ?? 'Something went wrong',
              style: CricTextStyle.headingMd,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: CricSpacing.sm),
            Text(
              error.toString(),
              style: CricTextStyle.caption.copyWith(color: CricColor.textDim),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: CricSpacing.lg),
              OutlinedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh, size: 16),
                label: const Text('RETRY'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: CricColor.gold,
                  side: const BorderSide(color: CricColor.gold),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
