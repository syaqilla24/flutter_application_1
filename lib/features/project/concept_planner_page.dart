import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../data/project_storage.dart';
import '../../shared/widgets/surface_card.dart';

/// Tujuh kolom Concept Planner (kunci penyimpanan -> label).
const _kolomKonsep = <String, String>{
  'konsep_keyword': 'Keyword',
  'konsep_mood': 'Mood',
  'konsep_style': 'Style',
  'konsep_warna': 'Warna',
  'konsep_tipografi': 'Tipografi',
  'konsep_layout': 'Layout',
  'konsep_ide': 'Ide visual',
};

/// Halaman 4.1.8 — Concept Planner.
class ConceptPlannerPage extends StatefulWidget {
  final String judulBrief;

  const ConceptPlannerPage({super.key, required this.judulBrief});

  @override
  State<ConceptPlannerPage> createState() => _ConceptPlannerPageState();
}

class _ConceptPlannerPageState extends State<ConceptPlannerPage> {
  final _controllers = {
    for (final kunci in _kolomKonsep.keys) kunci: TextEditingController(),
  };
  Map<String, String> _data = {};
  bool _memuat = true;

  @override
  void initState() {
    super.initState();
    _muat();
  }

  Future<void> _muat() async {
    final data = await ProjectStorage.getData();
    for (final kunci in _kolomKonsep.keys) {
      _controllers[kunci]!.text = data[kunci] ?? '';
    }
    if (!mounted) return;
    setState(() {
      _data = data;
      _memuat = false;
    });
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

    // Naik ke tahap Design Reasoning, tapi jangan mundur kalau sudah lebih jauh.
    final project = await ProjectStorage.getBerjalan();
    if (project != null && project.tahap < 2) {
      await ProjectStorage.setTahap(2);
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Concept Planner tersimpan')),
    );
    Navigator.pop(context, true);
  }

  Widget _referensi() {
    String isi(String kunci) {
      final v = _data[kunci];
      return (v == null || v.isEmpty) ? '-' : v;
    }

    return SurfaceCard(
      color: AppColors.tint,
      borderColor: AppColors.tintBorder,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Referensi hasil analisis',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 8),
          Text('Tujuan: ${isi('analisis_tujuan')}'),
          const SizedBox(height: 4),
          Text('Target audiens: ${isi('analisis_audiens')}'),
          const SizedBox(height: 4),
          Text('Pesan utama: ${isi('analisis_pesan')}'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.paper,
        title: const Text('Concept Planner'),
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
                const SizedBox(height: 16),
                _referensi(),
                const SizedBox(height: 20),
                for (final e in _kolomKonsep.entries) ...[
                  TextField(
                    controller: _controllers[e.key],
                    minLines: 1,
                    maxLines: 3,
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