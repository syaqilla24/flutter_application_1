import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../data/project_storage.dart';
import '../../shared/widgets/surface_card.dart';

/// Tiga elemen Design Reasoning:
/// kunci alasan -> (label, kunci pilihan di Concept Planner).
const _elemen = <String, (String, String)>{
  'reasoning_warna': ('Warna', 'konsep_warna'),
  'reasoning_tipografi': ('Tipografi', 'konsep_tipografi'),
  'reasoning_layout': ('Layout', 'konsep_layout'),
};

/// Halaman 4.1.9 — Design Reasoning.
class DesignReasoningPage extends StatefulWidget {
  final String judulBrief;

  const DesignReasoningPage({super.key, required this.judulBrief});

  @override
  State<DesignReasoningPage> createState() => _DesignReasoningPageState();
}

class _DesignReasoningPageState extends State<DesignReasoningPage> {
  final _controllers = {
    for (final kunci in _elemen.keys) kunci: TextEditingController(),
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
    for (final kunci in _elemen.keys) {
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

    // Naik ke tahap Checklist, tapi jangan mundur kalau sudah lebih jauh.
    final project = await ProjectStorage.getBerjalan();
    if (project != null && project.tahap < 3) {
      await ProjectStorage.setTahap(3);
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Design Reasoning tersimpan')),
    );
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.paper,
        title: const Text('Design Reasoning'),
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
                  'Jelaskan alasan di balik tiap pilihan konsepmu.',
                  style: TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 20),
                for (final e in _elemen.entries) ...[
                  SurfaceCard(
                    color: AppColors.tint,
                    borderColor: AppColors.tintBorder,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.value.$1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.ink,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Pilihanmu: ${(_data[e.value.$2] ?? '').isEmpty ? '-' : _data[e.value.$2]}',
                          style: const TextStyle(color: AppColors.muted),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _controllers[e.key],
                    minLines: 2,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Alasan memilih ${e.value.$1.toLowerCase()}',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
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