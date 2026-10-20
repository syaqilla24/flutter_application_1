const statusBelum = 0;   // Belum Dipelajari
const statusSedang = 1;  // Sedang Dipelajari
const statusSelesai = 2; // Selesai

/// Satu bagian isi materi. [sorot] = kotak berwarna (untuk contoh kasus).
class BagianMateri {
  final String judul;
  final String isi;
  final bool sorot;

  const BagianMateri(this.judul, this.isi, {this.sorot = false});
}

class Materi {
  final int id;
  final String judul;

  // Struktur lama (masih dipakai materi yang belum diisi ulang)
  final String penjelasan;
  final String contoh;

  // Struktur baru
  final List<String> tujuan;
  final List<BagianMateri> bagian;
  final List<String> ringkasan;

  final String latihan;
  final int status;

  const Materi(
    this.judul, {
    this.id = 0,
    this.penjelasan = '',
    this.contoh = '',
    this.tujuan = const [],
    this.bagian = const [],
    this.ringkasan = const [],
    this.latihan = '',
    this.status = statusBelum,
  });

  bool get selesai => status == statusSelesai;

  String get statusLabel {
    switch (status) {
      case statusSelesai:
        return 'Selesai';
      case statusSedang:
        return 'Sedang Dipelajari';
      default:
        return 'Belum Dipelajari';
    }
  }

  // Salinan materi dengan status baru
  Materi copyWith({int? status}) => Materi(
        judul,
        id: id,
        penjelasan: penjelasan,
        contoh: contoh,
        tujuan: tujuan,
        bagian: bagian,
        ringkasan: ringkasan,
        latihan: latihan,
        status: status ?? this.status,
      );
}