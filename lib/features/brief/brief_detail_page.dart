import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../data/project_storage.dart';
import '../../models/brief.dart';
import '../../shared/widgets/surface_card.dart';
import '../project/analisis_page.dart';

/// Halaman 4.1.6 — Detail Design Brief.
class BriefDetailPage extends StatelessWidget {
  final Brief brief;

  const BriefDetailPage({super.key, required this.brief});

  Future<void> _mulai(BuildContext context) async {
    final berjalan = await ProjectStorage.getBerjalan();
    if (!context.mounted) return;

    if (berjalan != null) {
      final ganti = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Ganti project berjalan?'),
          content: Text(
            'Kamu masih mengerjakan "${berjalan.judul}". '
            'Memulai project baru akan menghapus pengerjaan tersebut.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Ganti'),
            ),
          ],
        ),
      );
      if (ganti != true || !context.mounted) return;
    }

    await ProjectStorage.mulaiProject(brief.judul);
    if (!context.mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AnalisisPage(judulBrief: brief.judul),
      ),
    );
  }

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
            onPressed: () => _mulai(context),
            child: const Text('Mulai Analisis Brief'),
          ),
        ],
      ),
    );
  }
}