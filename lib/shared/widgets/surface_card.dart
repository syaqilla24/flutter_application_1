import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

/// Card dasar yang dipakai berbagai fitur.
class SurfaceCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final Color borderColor;

  const SurfaceCard({
    super.key,
    required this.child,
    this.color = Colors.white,
    this.borderColor = AppColors.line,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: child,
    );
  }
}
