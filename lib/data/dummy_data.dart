import '../models/brief.dart';
import '../models/materi.dart';
import '../models/project.dart';

/// Data contoh. Nanti diganti dengan data dari Cloud Firestore.
const daftarMateri = [
  Materi('Pengertian & Fungsi Design Brief', selesai: true),
  Materi('Target Audiens', selesai: true),
  Materi('Tujuan Desain & Pesan Utama'),
  Materi('Brainstorming & Keyword Desain'),
  Materi('Warna, Tipografi, Layout'),
  Materi('Alasan Pemilihan Elemen Visual'),
];

const projectBerjalan = Project('Poster Promosi Makanan', tahap: 1);
const projectTerakhir = Project('Branding UMKM Lokal', tahap: 3, selesai: true);

/// Contoh Design Brief yang bisa dipilih siswa (Subbab 4.1.5).
const daftarBrief = [
  Brief('Poster Promosi Makanan', 'Poster'),
  Brief('Promosi Event Sekolah', 'Event'),
  Brief('Branding UMKM Lokal', 'UMKM'),
  Brief('Konten Media Sosial', 'Sosmed'),
];

/// Riwayat project yang pernah dikerjakan siswa (Subbab 4.1.14).
const daftarRiwayat = [
  Project('Branding UMKM Lokal', tahap: 3, selesai: true),
  Project('Poster Promosi Makanan', tahap: 1),
  Project('Konten Media Sosial', tahap: 3, selesai: true),
];
