import 'package:flutter/material.dart';

import '../../data/dummy_data.dart';
import '../../shared/widgets/page_title.dart';
import 'brief_detail_page.dart';
import 'widgets/brief_list_item.dart';

/// Halaman 4.1.5 — Daftar Contoh Design Brief.
class BriefPage extends StatelessWidget {
  const BriefPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      children: [
        const PageTitle('Contoh Design Brief'),
        const SizedBox(height: 20),
        for (final brief in daftarBrief) ...[
          BriefListItem(
            brief: brief,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BriefDetailPage(brief: brief),
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
