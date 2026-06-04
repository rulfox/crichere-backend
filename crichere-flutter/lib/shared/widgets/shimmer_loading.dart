import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';

class ShimmerLoading extends StatelessWidget {
  final double height;
  final double width;
  final ShapeBorder shapeBorder;

  const ShimmerLoading.rectangular({
    super.key,
    this.width = double.infinity,
    required this.height,
  }) : shapeBorder = const RoundedRectangleBorder(borderRadius: CricRadius.cardAll);

  const ShimmerLoading.circular({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: CricColor.slate2,
      highlightColor: CricColor.slate3,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: CricColor.slate2,
          shape: shapeBorder,
        ),
      ),
    );
  }
}

class LeagueCardShimmer extends StatelessWidget {
  const LeagueCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: CricSpacing.sm),
      child: Container(
        padding: const EdgeInsets.all(CricSpacing.base),
        decoration: BoxDecoration(
          color: CricColor.slate2,
          borderRadius: CricRadius.cardAll,
          border: Border.all(color: CricColor.borderLight),
        ),
        child: Row(
          children: [
            const ShimmerLoading.circular(height: 40, width: 40),
            const SizedBox(width: CricSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ShimmerLoading.rectangular(height: 16, width: 120),
                  SizedBox(height: 8),
                  ShimmerLoading.rectangular(height: 12, width: 80),
                ],
              ),
            ),
            const ShimmerLoading.rectangular(height: 24, width: 24),
          ],
        ),
      ),
    );
  }
}

class LiveLeagueCardShimmer extends StatelessWidget {
  const LiveLeagueCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(CricSpacing.base),
      decoration: BoxDecoration(
        color: CricColor.slate2,
        borderRadius: CricRadius.cardAll,
        border: Border.all(color: CricColor.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          ShimmerLoading.rectangular(height: 24, width: 80),
          SizedBox(height: CricSpacing.md),
          ShimmerLoading.rectangular(height: 24, width: 200),
          SizedBox(height: CricSpacing.xs),
          ShimmerLoading.rectangular(height: 16, width: 160),
        ],
      ),
    );
  }
}

class LeagueDiscoveryCardShimmer extends StatelessWidget {
  const LeagueDiscoveryCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: CricSpacing.md),
      child: Container(
        padding: const EdgeInsets.all(CricSpacing.base),
        decoration: BoxDecoration(
          color: CricColor.slate2,
          borderRadius: CricRadius.cardAll,
          border: Border.all(color: CricColor.borderLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const ShimmerLoading.circular(height: 36, width: 36),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      ShimmerLoading.rectangular(height: 16, width: 140),
                      SizedBox(height: 8),
                      ShimmerLoading.rectangular(height: 12, width: 100),
                    ],
                  ),
                ),
                const ShimmerLoading.rectangular(height: 24, width: 60),
              ],
            ),
            const SizedBox(height: 12),
            const ShimmerLoading.rectangular(height: 16, width: 120),
          ],
        ),
      ),
    );
  }
}
