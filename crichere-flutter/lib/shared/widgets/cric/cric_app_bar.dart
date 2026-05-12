import 'package:flutter/material.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';

class CricAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool showLogo;
  final Widget? leading;

  const CricAppBar({
    super.key,
    this.title,
    this.actions,
    this.showLogo = true,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: CricDecoration.stickyNavBar,
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: leading,
        title: Row(
          children: [
            if (showLogo) ...[
              Text('🏏 CRICHERE', style: CricTextStyle.logo),
              if (title != null) const SizedBox(width: CricSpacing.md),
            ],
            if (title != null)
              Text(
                title!,
                style: CricTextStyle.headingMd,
              ),
          ],
        ),
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
