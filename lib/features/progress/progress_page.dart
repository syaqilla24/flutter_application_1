import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../data/dummy_data.dart';
import '../../shared/widgets/page_title.dart';
import '../../shared/widgets/section_title.dart';
import 'widgets/materi_progress_item.dart';
import 'widgets/progress_overall_card.dart';

/// Halaman 4.1.13 — Progress.
class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      children: [
        const PageTitle('Progress Belajar'),
        const SizedBox(height: 20),
        ProgressOverallCard(materi: daftarMateri),
        const SectionTitle('Progress per Materi'),
        for (var i = 0; i < daftarMateri.length; i++) ...[
          MateriProgressItem(
            materi: daftarMateri[i],
            dotColor: materiColors[i % materiColors.length],
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}
