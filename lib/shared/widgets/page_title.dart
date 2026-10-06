import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

/// Judul besar di puncak setiap halaman (mengikuti gaya judul "Dashboard").
class PageTitle extends StatelessWidget {
  final String text;

  const PageTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.ink,
      ),
    );
  }
}
