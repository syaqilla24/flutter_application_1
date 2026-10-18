import 'package:flutter/material.dart';

import '../../data/dummy_data.dart';
import '../../shared/widgets/page_title.dart';
import '../../shared/widgets/placeholder_page.dart';
import 'widgets/riwayat_list_item.dart';

/// Halaman 4.1.14 — Riwayat Project.
class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      children: [
        const PageTitle('Riwayat Project'),
        const SizedBox(height: 20),
        for (final project in daftarRiwayat) ...[
          RiwayatListItem(
            project: project,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(title: Text(project.judul)),
                    body: PlaceholderPage(project.judul),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}
