import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/materi.dart';
import '../../../shared/widgets/surface_card.dart';

/// Progress belajar: satu segmen warna untuk tiap materi.
class ProgressCard extends StatelessWidget {
  final List<Materi> materi;

  const ProgressCard({super.key, required this.materi});

  @override
  Widget build(BuildContext context) {
    final selesai = materi.where((m) => m.selesai).length;
    final persen = (selesai / materi.length * 100).round();

    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Progress belajar',
              style: TextStyle(color: AppColors.muted)),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '$selesai dari ${materi.length} materi selesai',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
              const Spacer(),
              Text('$persen%', style: const TextStyle(color: AppColors.muted)),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              for (var i = 0; i < materi.length; i++) ...[
                Expanded(
                  child: Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: materi[i].selesai
                          ? materiColors[i % materiColors.length]
                          : AppColors.line,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                if (i != materi.length - 1) const SizedBox(width: 4),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
