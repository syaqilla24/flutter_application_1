import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../models/brief.dart';
import '../../shared/widgets/surface_card.dart';

/// Halaman 4.1.6 — Detail Design Brief.
class BriefDetailPage extends StatelessWidget {
  final Brief brief;

  const BriefDetailPage({super.key, required this.brief});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.paper,
        title: const Text('Design Brief'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Text(
            brief.judul,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Kategori: ${brief.kategori}',
            style: const TextStyle(
              color: AppColors.muted,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          const SurfaceCard(
            child: Text(
              'Isi detail brief akan ditampilkan di sini.',
              style: TextStyle(color: AppColors.muted),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.ink),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fitur ini belum tersedia')),
              );
            },
            child: const Text('Gunakan Brief Ini'),
          ),
        ],
      ),
    );
  }
}