import '../models/materi.dart';

const seedMateri = [
    Materi(
    'Pengertian & Fungsi Design Brief',
    id: 1,
    tujuan: [
      'Menjelaskan pengertian design brief dengan kata-katamu sendiri.',
      'Menyebutkan fungsi design brief bagi desainer dan pemberi kerja.',
      'Mengenali komponen utama sebuah design brief.',
      'Membedakan brief yang jelas dengan brief yang kabur.',
      'Menjelaskan dampak bekerja tanpa brief.',
    ],
    bagian: [
      BagianMateri(
        'Apa itu design brief?',
        'Design brief adalah dokumen tertulis yang menjelaskan apa yang akan dirancang, untuk siapa, dan untuk tujuan apa. Dokumen ini dibuat bersama oleh pemberi kerja (klien) dan desainer sebelum proses mendesain dimulai.\n\nPanjangnya tidak harus berlembar-lembar. Brief yang baik bisa hanya satu halaman, asalkan jelas dan bisa dipakai sebagai pegangan. Intinya, brief mengubah kebutuhan yang masih samar di kepala klien menjadi informasi tertulis yang bisa dipahami desainer.',
      ),
      BagianMateri(
        'Mengapa design brief diperlukan?',
        'Tanpa brief, desainer cenderung bekerja berdasarkan asumsi. Hasilnya bisa bagus secara tampilan, tetapi tidak menjawab kebutuhan klien. Brief berfungsi untuk:\n\n• Menyamakan pemahaman. Klien dan desainer memegang gambaran yang sama tentang apa yang akan dibuat.\n• Membatasi ruang lingkup. Jelas apa yang termasuk pekerjaan dan apa yang tidak, sehingga permintaan tambahan di tengah jalan berkurang.\n• Mengarahkan keputusan desain. Saat bingung memilih warna atau gaya, desainer kembali ke brief.\n• Menjadi tolok ukur evaluasi. Hasil desain dinilai dari kesesuaiannya dengan brief, bukan dari selera pribadi.\n• Menghemat waktu dan biaya. Revisi besar karena salah paham bisa dihindari.',
      ),
      BagianMateri(
        'Siapa saja yang terlibat?',
        '• Pemberi kerja (klien): pihak yang membutuhkan desain dan paling mengetahui produk, tujuan bisnis, serta batasan anggarannya.\n• Desainer: pihak yang menerjemahkan kebutuhan itu menjadi solusi visual.\n• Audiens: pihak yang akan melihat dan menggunakan hasil desain. Audiens tidak ikut menulis brief, tetapi kebutuhannya harus dipikirkan di dalamnya.\n\nDalam latihan di aplikasi ini, kamu berperan sebagai desainer yang membaca brief dari klien.',
      ),
      BagianMateri(
        'Komponen utama design brief',
        'Bentuk brief bisa berbeda-beda, tetapi komponen berikut hampir selalu ada:\n\n1. Latar belakang: siapa kliennya dan masalah apa yang ingin diselesaikan.\n2. Tujuan desain: hasil yang ingin dicapai, misalnya menginformasikan, mengajak, atau memperkenalkan.\n3. Target audiens: siapa yang dituju, termasuk usia dan kebiasaan mereka.\n4. Pesan utama: satu gagasan inti yang harus diingat audiens.\n5. Media dan output: bentuk akhir desain, misalnya poster A3, unggahan Instagram, atau kemasan.\n6. Batasan: anggaran, waktu pengerjaan, ukuran, serta hal yang wajib atau dilarang dicantumkan.\n7. Informasi pendukung: nama, logo, harga, kontak, jadwal, atau referensi visual.\n\nKomponen-komponen inilah yang nanti kamu telaah pada tahap Analisis Brief di aplikasi ini.',
      ),
      BagianMateri(
        'Perbandingan: brief kabur dan brief jelas',
        'Brief kabur:\n"Tolong buatkan poster untuk kedai saya, yang bagus dan menarik ya."\n\nBrief jelas:\n"Kedai Bakso Pak Darto akan membuka cabang baru di dekat SMP Negeri 3. Buatkan poster A3 untuk dipasang di sekitar sekolah agar pelajar datang ke acara pembukaan pada 12 Maret. Pesan utamanya: diskon 50% untuk pelajar di hari pembukaan. Anggaran cetak terbatas sehingga maksimal dua warna. Poster wajib memuat alamat dan jam buka."\n\nBrief kabur tidak menjawab siapa audiensnya, apa tujuannya, atau seperti apa ukurannya. Kata "bagus dan menarik" juga tidak bisa dijadikan ukuran, karena setiap orang punya selera berbeda. Brief jelas memberi arah yang bisa langsung diikuti dan diuji.',
        sorot: true,
      ),
      BagianMateri(
        'Contoh kasus: tanpa brief dan dengan brief',
        'Sebuah kedai bakso meminta poster promosi, tetapi tidak membuat brief. Desainer berasumsi kedai itu ingin tampil mewah, lalu membuat poster bergaya restoran dengan warna emas dan huruf tipis. Padahal pelanggan utama kedai itu adalah pelajar yang mencari makanan murah. Poster ditolak dan harus dibuat ulang, sehingga waktu dan biaya terbuang.\n\nPada kasus yang sama dengan brief, tujuan (menarik pelajar), pesan utama (enak dan murah), batasan (hemat biaya cetak), dan output (poster A3) sudah jelas sejak awal. Desainer langsung tahu arah yang tepat: warna cerah, huruf tebal, dan harga yang terlihat jelas.',
        sorot: true,
      ),
      BagianMateri(
        'Kesalahan yang sering terjadi',
        '• Menganggap brief hanya formalitas lalu langsung mendesain.\n• Menerima brief yang terlalu singkat tanpa bertanya lebih lanjut kepada klien.\n• Memakai kata yang tidak terukur, seperti "bagus", "modern", atau "menarik", tanpa penjelasan.\n• Mencampur banyak tujuan dalam satu desain sehingga pesannya tidak fokus.\n• Tidak menuliskan batasan seperti anggaran dan tenggat waktu.\n• Tidak kembali membaca brief saat mengevaluasi hasil desain.',
      ),
      BagianMateri(
        'Brief dalam alur BriefUp',
        'Di aplikasi ini, brief menjadi titik awal setiap project. Setelah memilih sebuah contoh brief, kamu melewati empat tahap: Analisis Brief untuk memahami isinya, Concept Planner untuk menyusun arah konsep, Design Reasoning untuk menjelaskan alasan pilihanmu, dan Checklist untuk memeriksa kesesuaian. Kemampuan membaca brief dengan teliti menentukan kualitas keempat tahap tersebut.',
      ),
    ],
    ringkasan: [
      'Design brief adalah dokumen tertulis tentang apa yang dirancang, untuk siapa, dan untuk tujuan apa.',
      'Fungsinya: menyamakan pemahaman, membatasi ruang lingkup, mengarahkan keputusan, menjadi tolok ukur evaluasi, serta menghemat waktu dan biaya.',
      'Komponen utama: latar belakang, tujuan, target audiens, pesan utama, media dan output, batasan, serta informasi pendukung.',
      'Brief yang baik jelas, terukur, dan bisa diuji. Brief yang kabur memicu asumsi dan revisi.',
      'Jika brief belum jelas, desainer perlu bertanya kepada klien sebelum mulai mendesain.',
    ],
    latihan:
        '1. Sebutkan dua hal yang bisa salah jika desainer langsung mendesain tanpa membaca brief.\n2. Perbaiki brief kabur ini: "Buatkan banner untuk acara sekolah kami." Tambahkan minimal tiga komponen yang belum ada.\n3. Mengapa kata "menarik" kurang baik dipakai sebagai ukuran di dalam sebuah brief?',
  ),
  Materi(
    'Target Audiens',
    id: 2,
    penjelasan:
        'Target audiens adalah kelompok orang yang menjadi sasaran desain. Mengenalnya berarti memahami usia, kebiasaan, kebutuhan, dan media yang sering mereka gunakan.\n\nSemakin jelas audiensnya, semakin mudah memilih bahasa, gaya visual, dan media yang tepat.',
    contoh:
        'Event sekolah untuk siswa SMP: audiens berusia 12-15 tahun, aktif di media sosial, menyukai warna cerah dan bahasa santai. Desain untuk orang tua siswa akan memakai gaya dan bahasa yang berbeda.',
    latihan:
        'Tuliskan target audiens untuk promosi makanan ringan: usia, kebiasaan, dan media yang mereka gunakan.',
  ),
  Materi(
    'Tujuan Desain & Pesan Utama',
    id: 3,
    penjelasan:
        'Tujuan desain adalah hasil yang ingin dicapai, misalnya menginformasikan, mengajak, atau memperkenalkan. Pesan utama adalah satu gagasan inti yang harus diingat audiens.\n\nPesan yang terlalu banyak membuat desain membingungkan, sehingga informasi lain sebaiknya menjadi pendukung.',
    contoh:
        'Tujuan: mengajak siswa mendaftar lomba. Pesan utama: "Daftar sekarang, hadiah menarik menantimu". Syarat dan jadwal menjadi informasi pendukung.',
    latihan:
        'Rumuskan satu tujuan dan satu pesan utama untuk poster event sekolah.',
  ),
  Materi(
    'Brainstorming & Keyword Desain',
    id: 4,
    penjelasan:
        'Brainstorming adalah menggali ide sebanyak-banyaknya sebelum menentukan konsep. Salah satu caranya dengan menulis kata kunci (keyword) yang berkaitan dengan brief.\n\nSetelah itu, pilih beberapa keyword yang paling mewakili suasana dan pesan desain sebagai arah konsep.',
    contoh:
        'Untuk UMKM kopi lokal, keyword awal: hangat, tradisional, aroma, kebersamaan, hasil bumi. Dipilih tiga: hangat, tradisional, dan kebersamaan.',
    latihan:
        'Tulis lima keyword untuk brief promosi makanan, lalu pilih tiga yang paling cocok.',
  ),
  Materi(
    'Warna, Tipografi, Layout',
    id: 5,
    penjelasan:
        'Warna membentuk suasana dan kesan, misalnya hangat atau tenang. Tipografi adalah pemilihan jenis huruf yang mudah dibaca dan sesuai karakter. Layout adalah penataan elemen agar mata audiens mengikuti urutan yang jelas, dari yang terpenting.',
    contoh:
        'Poster makanan pedas memakai warna merah dan oranye untuk kesan panas dan menggugah selera, huruf tebal pada judul agar terbaca dari jauh, dan foto makanan di tengah dengan harga di bagian bawah.',
    latihan:
        'Pilih satu keyword dari materi sebelumnya, lalu tentukan warna, jenis huruf, dan penataan yang sesuai.',
  ),
  Materi(
    'Alasan Pemilihan Elemen Visual',
    id: 6,
    penjelasan:
        'Setiap elemen visual perlu bisa dijelaskan alasannya. Alasan yang baik mengaitkan pilihan dengan tujuan, target audiens, atau keyword, bukan sekadar "karena bagus".',
    contoh:
        'Alasan yang baik: "Warna hijau dipilih karena berkaitan dengan produk alami dan menarik bagi audiens yang peduli kesehatan." Alasan yang kurang baik: "Saya suka warna hijau."',
    latihan:
        'Tuliskan alasan satu pilihan warna dengan mengaitkannya pada tujuan atau audiens.',
  ),
];