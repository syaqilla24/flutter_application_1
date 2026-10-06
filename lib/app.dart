import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/shell/main_shell.dart';

class BriefUpApp extends StatelessWidget {
  const BriefUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BriefUp',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const MainShell(),
    );
  }
}
