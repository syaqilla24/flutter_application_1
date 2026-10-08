import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class AsyncBody<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(T data) builder;

  const AsyncBody({super.key, required this.future, required this.builder});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Gagal memuat data.\n${snapshot.error}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.muted),
            ),
          );
        }
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        return builder(snapshot.data as T);
      },
    );
  }
}