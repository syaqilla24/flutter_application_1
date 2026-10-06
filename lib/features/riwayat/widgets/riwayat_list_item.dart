import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/project.dart';
import '../../../shared/widgets/list_item_card.dart';

class RiwayatListItem extends StatelessWidget {
  final Project project;
  final VoidCallback onTap;

  const RiwayatListItem({super.key, required this.project, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final subtitle = project.selesai
        ? 'Selesai / Tersimpan'
        : 'Tahap: ${tahapProject[project.tahap]}';

    return ListItemCard(
      title: project.judul,
      subtitle: subtitle,
      trailing: Icon(
        project.selesai ? Icons.check_circle : Icons.timelapse,
        color: project.selesai ? AppColors.success : AppColors.muted,
      ),
      onTap: onTap,
    );
  }
}
