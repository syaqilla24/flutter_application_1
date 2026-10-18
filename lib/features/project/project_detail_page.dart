import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../models/project.dart';
import '../../shared/widgets/section_title.dart';
import '../../shared/widgets/surface_card.dart';
import '../dashboard/widgets/tahap_bar.dart';

/// Halaman 4.1.15 — Detail Project.
class ProjectDetailPage extends StatelessWidget {
  final Project project;

  const ProjectDetailPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.paper,
        title: const Text('Detail Project'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Text(
            project.judul,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            project.selesai
                ? 'Selesai, tersimpan di riwayat'
                : 'Tahap ${project.tahap + 1} dari ${tahapProject.length}: '
                    '${tahapProject[project.tahap]}',
            style: TextStyle(
              color: project.selesai ? AppColors.success : AppColors.muted,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          TahapBar(tahap: project.selesai ? tahapProject.length - 1 : project.tahap),
          const SectionTitle('Tahap pengerjaan'),
          for (var i = 0; i < tahapProject.length; i++) ...[
            _TahapItem(
              nama: tahapProject[i],
              selesai: project.selesai || i < project.tahap,
              aktif: !project.selesai && i == project.tahap,
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _TahapItem extends StatelessWidget {
  final String nama;
  final bool selesai;
  final bool aktif;

  const _TahapItem({
    required this.nama,
    required this.selesai,
    required this.aktif,
  });

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      color: aktif ? AppColors.tint : Colors.white,
      borderColor: aktif ? AppColors.tintBorder : AppColors.line,
      child: Row(
        children: [
          Expanded(
            child: Text(
              nama,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
          ),
          Icon(
            selesai
                ? Icons.check_circle
                : aktif
                    ? Icons.timelapse
                    : Icons.radio_button_unchecked,
            color: selesai ? AppColors.success : AppColors.muted,
          ),
        ],
      ),
    );
  }
}