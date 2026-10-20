import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../models/soal.dart';
import '../../shared/widgets/surface_card.dart';
import 'hasil_quiz_page.dart';

/// Halaman 4.1.11 — Quiz pilihan ganda.
///
/// Dipakai untuk quiz tiap materi maupun Quiz Final. Urutan soal dan urutan
/// pilihan diacak setiap kali quiz dimulai.
class QuizPage extends StatefulWidget {
  final String judul;
  final List<Soal> soal;
  final int nilaiLulus;

  /// Dipanggil sekali setiap quiz selesai dikerjakan, dengan skor 0 sampai 100.
  final Future<void> Function(int skor)? onSelesai;

  const QuizPage({
    super.key,
    required this.judul,
    required this.soal,
    required this.nilaiLulus,
    this.onSelesai,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final _acak = Random();
  late List<Soal> _soal = _siapkan();
  int _nomor = 0;
  int? _pilihan;
  final List<int> _jawaban = [];

  /// Acak urutan soal, lalu acak urutan pilihan di tiap soal.
  List<Soal> _siapkan() {
    final daftar = List.of(widget.soal)..shuffle(_acak);
    return [for (final s in daftar) _acakPilihan(s)];
  }

  Soal _acakPilihan(Soal s) {
    final urutan = List.generate(s.pilihan.length, (i) => i)..shuffle(_acak);
    return Soal(
      s.pertanyaan,
      [for (final i in urutan) s.pilihan[i]],
      urutan.indexOf(s.jawaban),
      pembahasan: s.pembahasan,
    );
  }

  bool get _soalTerakhir => _nomor == _soal.length - 1;

  Future<void> _lanjut() async {
    _jawaban.add(_pilihan!);

    if (!_soalTerakhir) {
      setState(() {
        _nomor++;
        _pilihan = null;
      });
      return;
    }

    final benar = [
      for (var i = 0; i < _soal.length; i++)
        if (_jawaban[i] == _soal[i].jawaban) i,
    ].length;
    final skor = (benar / _soal.length * 100).round();

    await widget.onSelesai?.call(skor);
    if (!mounted) return;

    final ulangi = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => HasilQuizPage(
          judul: widget.judul,
          soal: _soal,
          jawaban: List.of(_jawaban),
          nilaiLulus: widget.nilaiLulus,
        ),
      ),
    );
    if (!mounted) return;

    if (ulangi == true) {
      setState(() {
        _soal = _siapkan();
        _nomor = 0;
        _pilihan = null;
        _jawaban.clear();
      });
    } else {
      Navigator.pop(context, skor);
    }
  }

  @override
  Widget build(BuildContext context) {
    final soal = _soal[_nomor];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.paper,
        title: Text(widget.judul),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Text(
            'Soal ${_nomor + 1} dari ${_soal.length}',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.muted,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (_nomor + 1) / _soal.length,
              minHeight: 8,
              backgroundColor: AppColors.line,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            soal.pertanyaan,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
              height: 1.45,
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