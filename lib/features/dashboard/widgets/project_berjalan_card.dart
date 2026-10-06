import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/project.dart';
import '../../../shared/widgets/surface_card.dart';
import 'tahap_bar.dart';

class ProjectBerjalanCard extends StatelessWidget {
  final Project project;
  final VoidCallback onLanjutkan;

  const ProjectBerjalanCard({
    super.key,
    required this.project,
    required this.onLanjutkan,
  });

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      color: AppColors.tint,
      borderColor: AppColors.tintBorder,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project.judul,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Tahap ${project.tahap + 1} dari ${tahapProject.length}: '
            '${tahapProject[project.tahap]}',
            style: const TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 14),
          TahapBar(tahap: project.tahap),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
              style: FilledButton.styleFrom(backgroundColor: AppColors.ink),
              onPressed: onLanjutkan,
              child: const Text('Lanjutkan'),
            ),
          ),
        ],
      ),
    );
  }
}
