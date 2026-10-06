import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/brief.dart';
import '../../../shared/widgets/list_item_card.dart';

class BriefListItem extends StatelessWidget {
  final Brief brief;
  final VoidCallback onTap;

  const BriefListItem({super.key, required this.brief, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListItemCard(
      title: brief.judul,
      subtitle: 'Kategori: ${brief.kategori}',
      trailing: const Icon(Icons.chevron_right, color: AppColors.muted),
      onTap: onTap,
    );
  }
}
