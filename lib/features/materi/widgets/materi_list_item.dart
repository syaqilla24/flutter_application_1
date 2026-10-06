import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/materi.dart';
import '../../../shared/widgets/list_item_card.dart';

class MateriListItem extends StatelessWidget {
  final Materi materi;
  final VoidCallback onTap;

  const MateriListItem({super.key, required this.materi, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListItemCard(
      title: materi.judul,
      subtitle: materi.selesai ? 'Selesai' : 'Belum selesai',
      trailing: Icon(
        materi.selesai ? Icons.check_circle : Icons.chevron_right,
        color: materi.selesai ? AppColors.success : AppColors.muted,
      ),
      onTap: onTap,
    );
  }
}
