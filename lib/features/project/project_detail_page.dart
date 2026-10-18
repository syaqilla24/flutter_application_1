import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../models/project.dart';
import '../../shared/widgets/section_title.dart';
import '../../shared/widgets/surface_card.dart';
import '../dashboard/widgets/tahap_bar.dart';

/// Bagian ringkasan: judul -> daftar (label, kunci penyimpanan).
const _bagian = <(String, List<(String, String)>)>[
  (
    'Analisis Brief',
    [
      ('Tujuan desain', 'analisis_tujuan'),
      ('Target audiens', 'analisis_audiens'),
      ('Pesan utama', 'analisis_pesan'),
      ('Media', 'analisis_media'),
      ('Kebutuhan', 'analisis_kebutuhan'),
      ('Batasan', 'analisis_batasan'),
      ('Output', 'analisis_output'),
    ],
  ),
  (
    'Concept Planner',
    [
      ('Keyword', 'konsep_keyword'),
      ('Mood', 'konsep_mood'),
      ('Style', 'konsep_style'),
      ('Warna', 'konsep_warna'),
      ('Tipografi', 'konsep_tipografi'),
      ('Layout', 'konsep_layout'),
      ('Ide visual', 'konsep_ide'),
    ],
  ),
  (
    'Design Reasoning',
    [
      ('Alasan warna', 'reasoning_warna'),
      ('Alasan tipografi', 'reasoning_tipografi'),
      ('Alasan layout', 'reasoning_layout'),
    ],
  ),
];

const _totalChecklist = 6;

/// Halaman 4.1.15 — Detail Project.
class ProjectDetailPage extends StatelessWidget {
  final Project project;

  /// Jawaban project (analisis, konsep, reasoning, checklist). Boleh kosong.
  final Map<String, String> data;

  const ProjectDetailPage({
    super.key,
    required this.project,
    this.data = const {},
  });

  String _isi(String kunci) {
    final v = data[kunci];
    return (v == null || v.isEmpty) ? '-' : v;
  }

  Widget _kartuBagian(String judul, List<(String, String)> baris) {
    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            judul,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 10),
          for (final (label, kunci) in baris) ...[
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.muted,
              ),
            ),
            const SizedBox(height: 2),
            Text(_isi(kunci)),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final jumlahCentang = [
      for (var i = 0; i < _totalChecklist; i++)
        if (data['checklist_$i'] == '1') i,
    ].length;
    final persen = (jumlahCentang / _totalChecklist * 100).round();
    final lengkap = persen == 100;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.paper,
        title: const Text('Detail Project'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Text(
            project.judul,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            project.selesai
                ? 'Selesai, tersimpan di riwayat'
                : 'Tahap ${project.tahap + 1} dari ${tahapProject.length}: '
                    '${tahapProject[project.tahap]}',
            style: TextStyle(
              color: project.selesai ? AppColors.success : AppColors.muted,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          TahapBar(
            tahap: project.selesai ? tahapProject.length - 1 : project.tahap,
          ),
          const SectionTitle('Ringkasan project'),
          if (data.isEmpty)
            const SurfaceCard(
              child: Text(
                'Isi project ini tidak tersedia.',
                style: TextStyle(color: AppColors.muted),
              ),
            )
          else ...[
            for (final (judul, baris) in _bagian) ...[
              _kartuBagian(judul, baris),
              const SizedBox(height: 12),
            ],
            SurfaceCard(
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Checklist',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                      ),
                    ),
                  ),
                  Text(
                    lengkap
                        ? 'Lengkap (100%) – siap dievaluasi guru'
                        : 'Belum Lengkap ($persen%)',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: lengkap ? AppColors.success : AppColors.muted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}