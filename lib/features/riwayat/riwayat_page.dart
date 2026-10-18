import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../data/project_storage.dart';
import '../../models/project.dart';
import '../../shared/widgets/async_body.dart';
import '../../shared/widgets/page_title.dart';
import '../../shared/widgets/surface_card.dart';
import '../project/project_detail_page.dart';
import 'widgets/riwayat_list_item.dart';

/// Halaman 4.1.14 — Riwayat Project.
class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  late final Future<List<(Project, Map<String, String>)>> _future =
      ProjectStorage.getRiwayatLengkap();

  @override
  Widget build(BuildContext context) {
    return AsyncBody<List<(Project, Map<String, String>)>>(
      future: _future,
      builder: (daftarRiwayat) => ListView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
        children: [
          const PageTitle('Riwayat Project'),
          const SizedBox(height: 20),
          if (daftarRiwayat.isEmpty)
            const SurfaceCard(
              child: Text(
                'Belum ada project yang selesai. '
                'Selesaikan checklist untuk menyimpannya di sini.',
                style: TextStyle(color: AppColors.muted),
              ),
            ),
          for (final (project, data) in daftarRiwayat) ...[
            RiwayatListItem(
              project: project,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProjectDetailPage(
                      project: project,
                      data: data,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}