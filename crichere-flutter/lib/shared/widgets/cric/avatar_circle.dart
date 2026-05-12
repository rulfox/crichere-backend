import 'package:flutter/material.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AvatarCircle extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final double radius;

  const AvatarCircle({
    super.key,
    this.imageUrl,
    required this.name,
    this.radius = 20.0,
  });

  String get _initials {
    if (name.isEmpty) return '?';
    final parts = name.split(' ');
    if (parts.length > 1) {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }
    return name[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: CricColor.slate3,
      backgroundImage: imageUrl != null ? CachedNetworkImageProvider(imageUrl!) : null,
      child: imageUrl == null
          ? Text(
              _initials,
              style: CricTextStyle.badge.copyWith(
                color: CricColor.textMid,
                fontSize: radius * 0.8,
              ),
            )
          : null,
    );
  }
}
