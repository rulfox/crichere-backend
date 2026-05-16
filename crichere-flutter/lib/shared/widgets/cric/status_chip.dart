import 'package:flutter/material.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'live_dot.dart';

enum StatusType { live, upcoming, t20, t10, draft, open, completed, paused }

class StatusChip extends StatelessWidget {
  final StatusType type;
  final String? customLabel;

  const StatusChip({
    super.key,
    required this.type,
    this.customLabel,
  });

  // Maps backend LeagueStatus string to StatusType
  static StatusType fromLeagueStatus(String status) {
    switch (status.toUpperCase()) {
      case 'DRAFT':
        return StatusType.draft;
      case 'OPEN':
        return StatusType.open;
      case 'AUCTION_INITIALIZED':
      case 'AUCTION_IN_PROGRESS':
        return StatusType.live;
      case 'AUCTION_COMPLETED':
      case 'COMPLETED':
        return StatusType.completed;
      default:
        return StatusType.draft;
    }
  }

  @override
  Widget build(BuildContext context) {
    String label = customLabel ?? _labelFor(type);
    Color color = _colorFor(type);
    Widget? prefix = type == StatusType.live
        ? const Padding(
            padding: EdgeInsets.only(right: CricSpacing.xs),
            child: LiveDot(),
          )
        : null;

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
          if (prefix != null) prefix,
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

  static String _labelFor(StatusType type) {
    switch (type) {
      case StatusType.live:       return 'LIVE';
      case StatusType.upcoming:   return 'UPCOMING';
      case StatusType.t20:        return 'T20';
      case StatusType.t10:        return 'T10';
      case StatusType.draft:      return 'DRAFT';
      case StatusType.open:       return 'OPEN';
      case StatusType.completed:  return 'COMPLETED';
      case StatusType.paused:     return 'PAUSED';
    }
  }

  static Color _colorFor(StatusType type) {
    switch (type) {
      case StatusType.live:       return CricColor.red;
      case StatusType.upcoming:   return CricColor.blue;
      case StatusType.t20:
      case StatusType.t10:        return CricColor.gold;
      case StatusType.draft:      return CricColor.textDim;
      case StatusType.open:       return CricColor.green;
      case StatusType.completed:  return CricColor.textFaint;
      case StatusType.paused:     return CricColor.gold;
    }
  }
}
