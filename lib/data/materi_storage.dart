import 'package:shared_preferences/shared_preferences.dart';

import '../models/materi.dart';
import 'seed_data.dart';

class MateriStorage {
  MateriStorage._();

  static String _key(int id) => 'materi_status_$id';

  // Isi materi dari seed, status dari penyimpanan
  static Future<List<Materi>> getMateri() async {
    final prefs = await SharedPreferences.getInstance();
    return [
      for (final m in seedMateri)
        m.copyWith(status: prefs.getInt(_key(m.id)) ?? statusBelum),
    ];
  }

  static Future<void> setStatusMateri(int id, int status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key(id), status);
  }
}