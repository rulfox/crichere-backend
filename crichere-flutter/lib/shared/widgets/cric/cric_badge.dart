import 'package:flutter/material.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';

enum CricBadgeType { gold, green, red, blue, gray }

class CricBadge extends StatelessWidget {
  final String label;
  final CricBadgeType type;
  final IconData? icon;

  const CricBadge({
    super.key,
    required this.label,
    this.type = CricBadgeType.gray,
    this.icon,
  });

  Color get _color {
    switch (type) {
      case CricBadgeType.gold:
        return CricColor.gold;
      case CricBadgeType.green:
        return CricColor.green;
      case CricBadgeType.red:
        return CricColor.red;
      case CricBadgeType.blue:
        return CricColor.blue;
      case CricBadgeType.gray:
        return CricColor.textDim;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: CricSpacing.sm,
        vertical: CricSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: CricColor.badgeBg(_color),
        borderRadius: CricRadius.chipAll,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: _color),
            const SizedBox(width: CricSpacing.xs),
          ],
          Text(
            label,
            style: CricTextStyle.badge.copyWith(color: _color),
          ),
        ],
      ),
    );
  }
}
