import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../data/materi_storage.dart';
import '../../models/materi.dart';
import '../../shared/widgets/surface_card.dart';

/// Halaman 4.1.3: Detail Materi.
class MateriDetailPage extends StatefulWidget {
  final Materi materi;

  const MateriDetailPage({super.key, required this.materi});

  @override
  State<MateriDetailPage> createState() => _MateriDetailPageState();
}

class _MateriDetailPageState extends State<MateriDetailPage> {
  late int _status = widget.materi.status;

  @override
  void initState() {
    super.initState();
    // Materi dibuka pertama kali -> "Sedang Dipelajari"
    if (_status == statusBelum) {
      _status = statusSedang;
      MateriStorage.setStatusMateri(widget.materi.id, statusSedang);
    }
  }

  Future<void> _selesaikan() async {
    await MateriStorage.setStatusMateri(widget.materi.id, statusSelesai);
    if (!mounted) return;
    setState(() {
      _status = statusSelesai;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Materi ditandai selesai')),
    );
  }

  String _poin(List<String> daftar) => daftar.map((t) => '• $t').join('\n');

  List<Widget> _isiMateri(Materi materi) {
    // Materi yang belum diisi ulang: tampilan lama
    if (materi.bagian.isEmpty) {
      return [
        _Bagian(judul: 'Penjelasan', isi: materi.penjelasan),
        const SizedBox(height: 16),
        _Bagian(judul: 'Contoh Kasus', isi: materi.contoh, sorot: true),
        const SizedBox(height: 16),
        _Bagian(judul: 'Latihan Singkat', isi: materi.latihan),
      ];
    }

    return [
      if (materi.tujuan.isNotEmpty) ...[
        _Bagian(
          judul: 'Tujuan pembelajaran',
          isi: 'Setelah mempelajari materi ini, kamu mampu:\n'
              '${_poin(materi.tujuan)}',
          sorot: true,
        ),
        const SizedBox(height: 16),
      ],
      for (final b in materi.bagian) ...[
        _Bagian(judul: b.judul, isi: b.isi, sorot: b.sorot),
        const SizedBox(height: 16),
      ],
      if (materi.ringkasan.isNotEmpty) ...[
        _Bagian(judul: 'Ringkasan', isi: _poin(materi.ringkasan)),
        const SizedBox(height: 16),
      ],
      if (materi.latihan.isNotEmpty)
        _Bagian(judul: 'Latihan Singkat', isi: materi.latihan),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final materi = widget.materi;
    final selesai = _status == statusSelesai;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.paper,
        title: const Text('Materi'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Text(
            materi.judul,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            selesai ? 'Selesai' : 'Sedang Dipelajari',
            style: TextStyle(
              color: selesai ? AppColors.success : AppColors.muted,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          ..._isiMateri(materi),
          const SizedBox(height: 24),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.ink,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: selesai ? null : _selesaikan,
            child: Text(selesai ? 'Materi sudah selesai' : 'Tandai Selesai'),
          ),
        ],
      ),
    );
  }
}

// Satu kotak berjudul. [sorot] memberi warna latar khusus.
class _Bagian extends StatelessWidget {
  final String judul;
  final String isi;
  final bool sorot;

  const _Bagian({required this.judul, required this.isi, this.sorot = false});

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      color: sorot ? AppColors.tint : Colors.white,
      borderColor: sorot ? AppColors.tintBorder : AppColors.line,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            judul,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 8),
          Text(isi, style: const TextStyle(height: 1.5, color: AppColors.ink)),
        ],
      ),
    );
  }
}