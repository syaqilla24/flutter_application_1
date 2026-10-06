import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/materi.dart';
import '../../../shared/widgets/surface_card.dart';

class LanjutMateriCard extends StatelessWidget {
  final Materi materi;
  final VoidCallback onTap;

  const LanjutMateriCard({super.key, required this.materi, required this.onTap});

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
                  const Text('Lanjutkan materi',
                      style: TextStyle(color: AppColors.muted)),
                  const SizedBox(height: 4),
                  Text(
                    materi.judul,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    materi.selesai ? 'Selesai' : 'Belum selesai',
                    style: const TextStyle(color: AppColors.muted),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.muted),
          ],
        ),
      ),
    );
  }
}
