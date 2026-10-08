import 'package:flutter/material.dart';

import '../../data/materi_storage.dart';
import '../../models/materi.dart';
import '../../shared/widgets/async_body.dart';
import '../../shared/widgets/page_title.dart';
import 'materi_detail_page.dart';
import 'widgets/materi_list_item.dart';

/// Halaman 4.1.2: Daftar Materi.
class MateriPage extends StatefulWidget {
  const MateriPage({super.key});

  @override
  State<MateriPage> createState() => _MateriPageState();
}

class _MateriPageState extends State<MateriPage> {
  late Future<List<Materi>> _future = MateriStorage.getMateri();

  Future<void> _buka(Materi materi) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MateriDetailPage(materi: materi)),
    );
    if (!mounted) return;
    // Muat ulang agar status yang berubah ikut tampil
    setState(() {
      _future = MateriStorage.getMateri();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AsyncBody<List<Materi>>(
      future: _future,
      builder: (daftarMateri) => ListView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
        children: [
          const PageTitle('Materi Pembelajaran'),
          const SizedBox(height: 20),
          for (final materi in daftarMateri) ...[
            MateriListItem(materi: materi, onTap: () => _buka(materi)),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}