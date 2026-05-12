import 'package:flutter/material.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: CricSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toUpperCase(),
            style: CricTextStyle.overline.copyWith(
              fontSize: 12,
              color: CricColor.textDim,
            ),
          ),
          if (actionLabel != null)
            GestureDetector(
              onTap: onAction,
              child: Row(
                children: [
                  Text(
                    actionLabel!,
                    style: CricTextStyle.caption.copyWith(
                      color: CricColor.gold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: CricSpacing.xs),
                  const Icon(
                    Icons.arrow_forward,
                    size: 14,
                    color: CricColor.gold,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
