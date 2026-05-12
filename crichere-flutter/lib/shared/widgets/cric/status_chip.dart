import 'package:flutter/material.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'live_dot.dart';

enum StatusType { live, upcoming, t20, t10 }

class StatusChip extends StatelessWidget {
  final StatusType type;
  final String? customLabel;

  const StatusChip({
    super.key,
    required this.type,
    this.customLabel,
  });

  @override
  Widget build(BuildContext context) {
    String label = customLabel ?? type.name.toUpperCase();
    Color color = CricColor.textDim;
    Widget? prefix;

    switch (type) {
      case StatusType.live:
        color = CricColor.red;
        prefix = const Padding(
          padding: EdgeInsets.only(right: CricSpacing.xs),
          child: LiveDot(),
        );
        break;
      case StatusType.upcoming:
        color = CricColor.blue;
        break;
      case StatusType.t20:
      case StatusType.t10:
        color = CricColor.gold;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: CricSpacing.sm,
        vertical: CricSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: CricColor.badgeBg(color),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ?prefix,
          Text(
            label,
            style: CricTextStyle.badge.copyWith(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
