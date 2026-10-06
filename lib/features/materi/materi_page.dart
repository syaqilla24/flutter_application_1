import 'package:flutter/material.dart';

import '../../data/dummy_data.dart';
import '../../shared/widgets/page_title.dart';
import 'widgets/materi_list_item.dart';

/// Halaman 4.1.3 — Daftar Materi.
class MateriPage extends StatelessWidget {
  const MateriPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      children: [
        const PageTitle('Materi Pembelajaran'),
        const SizedBox(height: 20),
        for (final materi in daftarMateri) ...[
          MateriListItem(
            materi: materi,
            onTap: () {
              // TODO: buka halaman detail materi (4.1.4)
            },
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}
