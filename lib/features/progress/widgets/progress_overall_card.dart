import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/materi.dart';
import '../../../shared/widgets/surface_card.dart';

/// Kartu "Progress Keseluruhan": satu bar penuh yang terisi sesuai persentase.
class ProgressOverallCard extends StatelessWidget {
  final List<Materi> materi;

  const ProgressOverallCard({super.key, required this.materi});

  @override
  Widget build(BuildContext context) {
    final selesai = materi.where((m) => m.selesai).length;
    final persen = (selesai / materi.length * 100).round();

    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Progress Keseluruhan', style: TextStyle(color: AppColors.muted)),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('$selesai dari ${materi.length} materi selesai',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  )),
              const Spacer(),
              Text('$persen%', style: const TextStyle(color: AppColors.muted)),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: selesai / materi.length,
              minHeight: 12,
              backgroundColor: AppColors.line,
              valueColor: const AlwaysStoppedAnimation(AppColors.ink),
            ),
          ),
        ],
      ),
    );
  }
}
