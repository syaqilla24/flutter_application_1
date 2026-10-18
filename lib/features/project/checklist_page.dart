import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../data/project_storage.dart';
import '../../shared/widgets/surface_card.dart';

/// Enam item evaluasi kesesuaian konsep terhadap brief.
const _itemChecklist = <String>[
  'Tujuan desain sudah sesuai dengan brief',
  'Target audiens sudah jelas dan sesuai dengan brief',
  'Pesan utama sudah tersampaikan lewat konsep',
  'Keyword, mood, dan style konsisten satu sama lain',
  'Warna, tipografi, dan layout mendukung pesan utama',
  'Setiap pilihan konsep sudah punya alasan (design reasoning)',
];

/// Halaman 4.1.10 — Checklist / Evaluasi.
class ChecklistPage extends StatefulWidget {
  final String judulBrief;

  const ChecklistPage({super.key, required this.judulBrief});

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  final List<bool> _centang = List.filled(_itemChecklist.length, false);
  bool _memuat = true;

  @override
  void initState() {
    super.initState();
    _muat();
  }

  Future<void> _muat() async {
    final data = await ProjectStorage.getData();
    for (var i = 0; i < _centang.length; i++) {
      _centang[i] = data['checklist_$i'] == '1';
    }
    if (!mounted) return;
    setState(() => _memuat = false);
  }

  int get _jumlah => _centang.where((c) => c).length;
  int get _persen => (_jumlah / _centang.length * 100).round();
  bool get _lengkap => _jumlah == _centang.length;

  Future<void> _ubah(int i, bool nilai) async {
    setState(() => _centang[i] = nilai);
    await ProjectStorage.simpanData({'checklist_$i': nilai ? '1' : '0'});
  }

  Future<void> _selesaikan() async {
    await ProjectStorage.selesaikan();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Project selesai dan tersimpan di Riwayat')),
    );
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final status = _lengkap
        ? 'Lengkap (100%) – siap dievaluasi guru'
        : 'Belum Lengkap ($_persen%)';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.paper,
        title: const Text('Checklist'),
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
                Text(
                  status,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: _lengkap ? AppColors.success : AppColors.muted,
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: _jumlah / _centang.length,
                    minHeight: 10,
                    backgroundColor: AppColors.line,
                    color: _lengkap ? AppColors.success : AppColors.ink,
                  ),
                ),
                const SizedBox(height: 20),
                for (var i = 0; i < _itemChecklist.length; i++) ...[
                  SurfaceCard(
                    child: CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      value: _centang[i],
                      onChanged: (v) => _ubah(i, v ?? false),
                      title: Text(_itemChecklist[i]),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                const SizedBox(height: 12),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.ink,
                  ),
                  onPressed: _lengkap ? _selesaikan : null,
                  child: const Text('Selesaikan Project'),
                ),
              ],
            ),
    );
  }
}