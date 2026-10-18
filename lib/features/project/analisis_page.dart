import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../data/project_storage.dart';

/// Tujuh kolom Analisis Design Brief (kunci penyimpanan -> label).
const _kolomAnalisis = <String, String>{
  'analisis_tujuan': 'Tujuan desain',
  'analisis_audiens': 'Target audiens',
  'analisis_pesan': 'Pesan utama',
  'analisis_media': 'Media',
  'analisis_kebutuhan': 'Kebutuhan',
  'analisis_batasan': 'Batasan',
  'analisis_output': 'Output',
};

/// Halaman 4.1.7 — Form Analisis Design Brief.
class AnalisisPage extends StatefulWidget {
  final String judulBrief;

  const AnalisisPage({super.key, required this.judulBrief});

  @override
  State<AnalisisPage> createState() => _AnalisisPageState();
}

class _AnalisisPageState extends State<AnalisisPage> {
  final _controllers = {
    for (final kunci in _kolomAnalisis.keys) kunci: TextEditingController(),
  };
  bool _memuat = true;

  @override
  void initState() {
    super.initState();
    _muat();
  }

  Future<void> _muat() async {
    final data = await ProjectStorage.getData();
    for (final kunci in _kolomAnalisis.keys) {
      _controllers[kunci]!.text = data[kunci] ?? '';
    }
    if (!mounted) return;
    setState(() => _memuat = false);
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _simpan() async {
    final jawaban = {
      for (final e in _controllers.entries) e.key: e.value.text.trim(),
    };

    if (jawaban.values.any((v) => v.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lengkapi semua kolom dulu')),
      );
      return;
    }

    await ProjectStorage.simpanData(jawaban);

    // Naik ke tahap Concept Planner, tapi jangan mundur kalau sudah lebih jauh.
    final project = await ProjectStorage.getBerjalan();
    if (project != null && project.tahap < 1) {
      await ProjectStorage.setTahap(1);
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Analisis tersimpan')),
    );
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.paper,
        title: const Text('Analisis Brief'),
      ),
      body: _memuat
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              children: [
                Text(
                  widget.judulBrief,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Isi analisis berdasarkan brief ini.',
                  style: TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 20),
                for (final e in _kolomAnalisis.entries) ...[
                  TextField(
                    controller: _controllers[e.key],
                    minLines: 2,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: e.value,
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                ],
                const SizedBox(height: 10),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.ink,
                  ),
                  onPressed: _simpan,
                  child: const Text('Simpan & Lanjut'),
                ),
              ],
            ),
    );
  }
}