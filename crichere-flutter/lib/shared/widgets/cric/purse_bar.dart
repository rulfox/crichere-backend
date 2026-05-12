import 'package:flutter/material.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';

class PurseBar extends StatelessWidget {
  final int spent;
  final int total;
  final double height;

  const PurseBar({
    super.key,
    required this.spent,
    required this.total,
    this.height = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    double progress = total > 0 ? spent / total : 0.0;
    progress = progress.clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(height / 2),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: CricColor.slate4,
            valueColor: AlwaysStoppedAnimation<Color>(
              progress > 0.9 ? CricColor.red : CricColor.green,
            ),
            minHeight: height,
          ),
        ),
        const SizedBox(height: CricSpacing.xs),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '₹${(spent / 1000).toStringAsFixed(1)}k spent',
              style: CricTextStyle.caption.copyWith(fontSize: 10),
            ),
            Text(
              '₹${(total / 1000).toStringAsFixed(1)}k total',
              style: CricTextStyle.caption.copyWith(fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }
}
