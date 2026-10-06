import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

/// Halaman sementara untuk fitur yang belum dibuat.
class PlaceholderPage extends StatelessWidget {
  final String judul;

  const PlaceholderPage(this.judul, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Halaman $judul belum dibuat',
        style: const TextStyle(color: AppColors.muted),
      ),
    );
  }
}
