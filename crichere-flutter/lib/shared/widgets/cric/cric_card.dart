import 'package:flutter/material.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';

class CricCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? color;
  final Color? borderColor;

  const CricCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.color,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      padding: padding ?? const EdgeInsets.all(CricSpacing.base),
      decoration: (color != null || borderColor != null)
          ? CricDecoration.card.copyWith(
              color: color,
              border: borderColor != null ? Border.all(color: borderColor!) : null,
            )
          : CricDecoration.card,
      child: child,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: CricRadius.cardAll,
        child: content,
      );
    }

    return content;
  }
}
