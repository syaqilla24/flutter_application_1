/// Urutan tahap pengerjaan satu project.
const tahapProject = [
  'Analisis Brief',
  'Concept Planner',
  'Design Reasoning',
  'Checklist',
];

class Project {
  final String judul;
  final int tahap; // indeks pada [tahapProject]
  final bool selesai;

  const Project(this.judul, {this.tahap = 0, this.selesai = false});
}
