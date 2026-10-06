import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/project.dart';

/// Batang tahap project: Analisis, Concept Planner, Design Reasoning, Checklist.
class TahapBar extends StatelessWidget {
  final int tahap;

  const TahapBar({super.key, required this.tahap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < tahapProject.length; i++) ...[
          Expanded(
            child: Container(
              height: 6,
              decoration: BoxDecoration(
                color: i <= tahap ? AppColors.ink : AppColors.line,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          if (i != tahapProject.length - 1) const SizedBox(width: 4),
        ],
      ],
    );
  }
}
