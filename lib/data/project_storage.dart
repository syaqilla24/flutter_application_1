import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/project.dart';

/// Penyimpanan project: satu project berjalan + daftar riwayat.
class ProjectStorage {
  ProjectStorage._();

  static const _keyBerjalan = 'project_berjalan';
  static const _keyData = 'project_data';
  static const _keyRiwayat = 'project_riwayat';

  /// Project yang sedang berjalan, atau null kalau belum ada.
  static Future<Project?> getBerjalan() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyBerjalan);
    if (raw == null) return null;
    final map = jsonDecode(raw) as Map<String, dynamic>;
    return Project(map['judul'] as String, tahap: map['tahap'] as int);
  }

  /// Mulai project baru dari sebuah brief (data lama project berjalan dihapus).
  static Future<void> mulaiProject(String judul) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _keyBerjalan,
      jsonEncode({'judul': judul, 'tahap': 0}),
    );
    await prefs.remove(_keyData);
  }

  /// Pindah ke tahap berikutnya (0 sampai 3).
  static Future<void> setTahap(int tahap) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyBerjalan);
    if (raw == null) return;
    final map = jsonDecode(raw) as Map<String, dynamic>;
    map['tahap'] = tahap;
    await prefs.setString(_keyBerjalan, jsonEncode(map));
  }

  /// Jawaban form project berjalan (analisis, konsep, reasoning, checklist).
  static Future<Map<String, String>> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyData);
    if (raw == null) return {};
    final map = jsonDecode(raw) as Map<String, dynamic>;
    return map.map((k, v) => MapEntry(k, v as String));
  }

  /// Simpan jawaban baru; kunci lama yang tidak disebut tetap dipertahankan.
  static Future<void> simpanData(Map<String, String> baru) async {
    final prefs = await SharedPreferences.getInstance();
    final data = await getData();
    data.addAll(baru);
    await prefs.setString(_keyData, jsonEncode(data));
  }

  /// Riwayat project yang sudah selesai (yang terbaru di atas).
  static Future<List<Project>> getRiwayat() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyRiwayat);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return [
      for (final item in list)
        Project(
          (item as Map<String, dynamic>)['judul'] as String,
          tahap: item['tahap'] as int,
          selesai: item['selesai'] as bool,
        ),
    ];
  }

  /// Selesaikan project berjalan: pindah ke riwayat beserta datanya.
  static Future<void> selesaikan() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyBerjalan);
    if (raw == null) return;
    final map = jsonDecode(raw) as Map<String, dynamic>;

    final riwayatRaw = prefs.getString(_keyRiwayat);
    final riwayat = riwayatRaw == null
        ? <dynamic>[]
        : jsonDecode(riwayatRaw) as List<dynamic>;

    riwayat.insert(0, {
      'judul': map['judul'],
      'tahap': tahapProject.length - 1,
      'selesai': true,
      'data': await getData(),
    });

    await prefs.setString(_keyRiwayat, jsonEncode(riwayat));
    await prefs.remove(_keyBerjalan);
    await prefs.remove(_keyData);
  }
}