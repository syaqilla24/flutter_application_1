const statusBelum = 0;   // Belum Dipelajari
const statusSedang = 1;  // Sedang Dipelajari
const statusSelesai = 2; // Selesai

class Materi {
  final int id;
  final String judul;
  final String penjelasan;
  final String contoh;
  final String latihan;
  final int status;

  const Materi(
    this.judul, {
    this.id = 0,
    this.penjelasan = '',
    this.contoh = '',
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
        latihan: latihan,
        status: status ?? this.status,
      );
}