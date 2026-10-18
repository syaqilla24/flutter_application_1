import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/project.dart';
import '../../../shared/widgets/surface_card.dart';

class ProjectTerakhirCard extends StatelessWidget {
  final Project project;
  final VoidCallback onTap;

  const ProjectTerakhirCard({
    super.key,
    required this.project,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: SurfaceCard(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.judul,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    project.selesai
                        ? 'Selesai, tersimpan di riwayat'
                        : 'Belum selesai',
                    style: const TextStyle(color: AppColors.muted),
                  ),
                ],
              ),
            ),
            Icon(
              project.selesai ? Icons.check_circle : Icons.timelapse,
              color: project.selesai ? AppColors.success : AppColors.muted,
            ),
          ],
        ),
      ),
    );
  }
}