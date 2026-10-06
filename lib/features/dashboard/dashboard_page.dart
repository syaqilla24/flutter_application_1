import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../data/dummy_data.dart';
import '../../shared/widgets/section_title.dart';
import 'widgets/lanjut_materi_card.dart';
import 'widgets/progress_card.dart';
import 'widgets/project_berjalan_card.dart';
import 'widgets/project_terakhir_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Materi yang disarankan: materi pertama yang belum selesai.
    final materiLanjut = daftarMateri.firstWhere(
      (m) => !m.selesai,
      orElse: () => daftarMateri.last,
    );

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      children: [
        const Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.ink,
          ),
        ),
        const SizedBox(height: 20),
        const ProgressCard(materi: daftarMateri),
        const SectionTitle('Project berjalan'),
        ProjectBerjalanCard(
          project: projectBerjalan,
          onLanjutkan: () {
            // TODO: buka halaman sesuai tahap project (Concept Planner, dst.)
          },
        ),
        const SectionTitle('Project terakhir'),
        const ProjectTerakhirCard(project: projectTerakhir),
        const SizedBox(height: 16),
        LanjutMateriCard(
          materi: materiLanjut,
          onTap: () {
            // TODO: buka halaman detail materi
          },
        ),
      ],
    );
  }
}
