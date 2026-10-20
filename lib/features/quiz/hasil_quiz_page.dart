import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../models/soal.dart';
import '../../shared/widgets/section_title.dart';
import '../../shared/widgets/surface_card.dart';

/// Halaman 4.1.12 — Hasil Quiz.
///
/// Menutup halaman dengan nilai `true` kalau siswa memilih Ulangi Quiz.
class HasilQuizPage extends StatelessWidget {
  final String judul;
  final List<Soal> soal;

  /// Indeks pilihan yang dijawab siswa untuk tiap soal.
  final List<int> jawaban;
  final int nilaiLulus;

  const HasilQuizPage({
    super.key,
    required this.judul,
    required this.soal,
    required this.jawaban,
    required this.nilaiLulus,
  });

  @override
  Widget build(BuildContext context) {
    final benar = [
      for (var i = 0; i < soal.length; i++)
        if (jawaban[i] == soal[i].jawaban) i,
    ].length;
    final skor = (benar / soal.length * 100).round();
    final lulus = skor >= nilaiLulus;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.paper,
        title: const Text('Hasil Quiz'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Text(
            judul,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 12),
          SurfaceCard(
            child: Column(
              children: [
                const Text(
                  'Skor akhir',
                  style: TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 6),
                Text(
                  '$skor',
                  style: const TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$benar dari ${soal.length} soal benar',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.muted,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  lulus ? 'Lulus' : 'Belum lulus',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: lulus ? AppColors.success : Colors.redAccent,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  lulus
                      ? 'Nilai minimal $nilaiLulus tercapai.'
                      : 'Nilai minimal $nilaiLulus. Pelajari lagi materinya, '
                          'lalu coba kembali.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.muted),
                ),
              ],
            ),
          ),
          const SectionTitle('Ringkasan jawaban'),
          for (var i = 0; i < soal.length; i++) ...[
            _RingkasanSoal(
              nomor: i + 1,
              soal: soal[i],
              dipilih: jawaban[i],
            ),
            const SizedBox(height: 12),
          ],
          const SizedBox(height: 12),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.ink),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Ulangi Quiz'),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Selesai'),
          ),
        ],
      ),
    );
  }
}

class _RingkasanSoal extends StatelessWidget {
  final int nomor;
  final Soal soal;
  final int dipilih;

  const _RingkasanSoal({
    required this.nomor,
    required this.soal,
    required this.dipilih,
  });

  @override
  Widget build(BuildContext context) {
    final benar = dipilih == soal.jawaban;

    return SurfaceCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            benar ? Icons.check_circle : Icons.cancel,
            color: benar ? AppColors.success : Colors.redAccent,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$nomor. ${soal.pertanyaan}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Jawabanmu: ${soal.pilihan[dipilih]}',
                  style: const TextStyle(color: AppColors.muted),
                ),
                if (!benar) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Jawaban benar: ${soal.pilihan[soal.jawaban]}',
                    style: const TextStyle(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                if (soal.pembahasan.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Pembahasan: ${soal.pembahasan}',
                    style: const TextStyle(height: 1.4),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}