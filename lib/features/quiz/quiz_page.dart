import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../data/quiz_data.dart';
import '../../shared/widgets/surface_card.dart';
import 'hasil_quiz_page.dart';

/// Halaman 4.1.11 — Quiz pilihan ganda.
class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _nomor = 0;
  int? _pilihan;
  final List<int> _jawaban = [];

  bool get _soalTerakhir => _nomor == bankSoal.length - 1;

  Future<void> _lanjut() async {
    _jawaban.add(_pilihan!);

    if (!_soalTerakhir) {
      setState(() {
        _nomor++;
        _pilihan = null;
      });
      return;
    }

    final ulangi = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => HasilQuizPage(
          soal: bankSoal,
          jawaban: List.of(_jawaban),
        ),
      ),
    );
    if (!mounted) return;

    if (ulangi == true) {
      setState(() {
        _nomor = 0;
        _pilihan = null;
        _jawaban.clear();
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final soal = bankSoal[_nomor];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.paper,
        title: const Text('Quiz'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Text(
            'Soal ${_nomor + 1} dari ${bankSoal.length}',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.muted,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (_nomor + 1) / bankSoal.length,
              minHeight: 8,
              backgroundColor: AppColors.line,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            soal.pertanyaan,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          for (var i = 0; i < soal.pilihan.length; i++) ...[
            InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => setState(() => _pilihan = i),
              child: SurfaceCard(
                color: _pilihan == i ? AppColors.tint : Colors.white,
                borderColor: _pilihan == i ? AppColors.ink : AppColors.line,
                child: Row(
                  children: [
                    Icon(
                      _pilihan == i
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: _pilihan == i ? AppColors.ink : AppColors.muted,
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Text(soal.pilihan[i])),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
          const SizedBox(height: 12),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.ink),
            onPressed: _pilihan == null ? null : _lanjut,
            child: Text(
              _soalTerakhir ? 'Jawab & Lihat Hasil' : 'Jawab & Lanjut',
            ),
          ),
        ],
      ),
    );
  }
}