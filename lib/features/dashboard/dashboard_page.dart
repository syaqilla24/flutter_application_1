import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../data/dummy_data.dart';
import '../../data/materi_storage.dart';
import '../../models/materi.dart';
import '../../shared/widgets/async_body.dart';
import '../../shared/widgets/section_title.dart';
import '../materi/materi_detail_page.dart';
import 'widgets/lanjut_materi_card.dart';
import 'widgets/progress_card.dart';
import 'widgets/project_berjalan_card.dart';
import 'widgets/project_terakhir_card.dart';

/// Halaman 4.1.1: Dashboard Siswa.
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<List<Materi>> _future = MateriStorage.getMateri();

  Future<void> _bukaMateri(Materi materi) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MateriDetailPage(materi: materi)),
    );
    if (!mounted) return;
    setState(() {
      _future = MateriStorage.getMateri();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AsyncBody<List<Materi>>(
      future: _future,
      builder: (daftarMateri) {
        // Materi yang disarankan: materi pertama yang belum selesai
        final materiLanjut = daftarMateri.firstWhere(
          (m) => !m.selesai,
          orElse: () => daftarMateri.last,
        );

        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
          children: [
            const Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 20),
            ProgressCard(materi: daftarMateri),
            const SectionTitle('Project berjalan'),
            ProjectBerjalanCard(
              project: projectBerjalan,
              onLanjutkan: () {
                // TODO: buka halaman sesuai tahap project
              },
            ),
            const SectionTitle('Project terakhir'),
            const ProjectTerakhirCard(project: projectTerakhir),
            const SizedBox(height: 16),
            LanjutMateriCard(
              materi: materiLanjut,
              onTap: () => _bukaMateri(materiLanjut),
            ),
          ],
        );
      },
    );
  }
}