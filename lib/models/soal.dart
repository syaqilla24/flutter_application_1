/// Satu soal pilihan ganda.
class Soal {
  final String pertanyaan;
  final List<String> pilihan;

  /// Indeks pilihan yang benar (mulai dari 0).
  final int jawaban;

  const Soal(this.pertanyaan, this.pilihan, this.jawaban);
}