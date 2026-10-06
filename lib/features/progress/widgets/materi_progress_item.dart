import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/materi.dart';
import '../../../shared/widgets/surface_card.dart';

/// Satu baris status materi pada Subbab "Progress per Materi".
class MateriProgressItem extends StatelessWidget {
  final Materi materi;
  final Color dotColor;

  const MateriProgressItem({super.key, required this.materi, required this.dotColor});

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: materi.selesai ? dotColor : AppColors.line,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              materi.judul,
              style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.ink),
            ),
          ),
          Text(
            materi.selesai ? 'Selesai' : 'Belum Dipelajari',
            style: const TextStyle(color: AppColors.muted, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
