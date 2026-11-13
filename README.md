# myportofolio_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

MyPortfolio Mobile

Nama : Rebeccaniaga Napitupulu NPM : 2506598394 Kelas : PBP E Dosen : Pak Daya

# Tentang Proyek

Proyek ini adalah aplikasi mobile MyPortfolio yang dibuat pakai Flutter untuk mata kuliah Pemrograman Berbasis Platform (PBP). Aplikasinya jadi client mobile buat portofolio pribadi yang sebelumnya dibuat pakai Django (myportofolio).Isi halamannya:
- Kartu informasi (InfoCard): tiga kartu di bagian atas yang nampilin NPM, nama, dan kelas PBP aku.
- Menu aksi (ItemCard): tiga tombol berbentuk kartu (Lihat Proyek, Tambah Proyek, Logout), masing-masing punya ikon dan warna sendiri (biru, hijau, merah).
- SnackBar: tiap tombol ditekan, muncul notifikasi "Kamu telah menekan tombol [Nama Tombol]!" di bawah layar.

# Tech Stack
- Flutter (framework UI) dan Dart (bahasa pemrograman)
- Material 3 (useMaterial3: true, tema warna dari ColorScheme.fromSeed)
- Visual Studio Code sebagai editor, Android Studio untuk Android SDK
- Google Chrome untuk ngejalanin aplikasi pas development
- Git & GitHub buat version control

# Cara Menjalankan Proyek Secara Lokal
1. Pastikan Flutter SDK sudah terpasang dan flutter doctor tidak ada masalah di bagian Android toolchain dan Chrome.
2. Clone repository
   git clone https://github.com/<username>/myportofolio_mobile.git
   cd myportofolio_mobile
3. Ambil dependensi
   flutter pub get
4. Jalankan di Chrome
   flutter run -d chrome
5. (Opsional) Cek kualitas kode
   flutter analyze

# Progress Mingguan
a. Tutorial 08: Basic Flutter
- Install Flutter SDK di Windows, ekstrak ke C:\src\flutter, lalu daftarin folder bin-nya ke PATH.
- Install Android Studio dan Android SDK (SDK Command-line Tools, Build-Tools, Platform-Tools, Emulator). Karena storage C: penuh, lokasi Android SDK aku pindah ke D:\Android\Sdk dan Flutter diarahkan ke situ pakai flutter config --android-sdk.
- Verifikasi pakai flutter doctor. Tanda silang di Visual Studio aku abaikan karena cuma buat aplikasi desktop Windows.
- Bikin proyek myportofolio_mobile dengan flutter create dan jalanin aplikasi counter bawaan di Chrome.
- Merapikan struktur proyek: pindahin MyHomePage dari main.dart ke lib/menu.dart dan import-nya di main.dart.
- Ubah tema warna pakai ColorScheme.fromSeed (seed indigo, secondary amber).
- Ubah MyHomePage dari StatefulWidget jadi StatelessWidget karena halamannya statis.
- Bikin widget reusable InfoCard dan ItemCard, plus model ItemHomepage.
- Rakit semuanya di build() pakai Scaffold, AppBar, Padding, Column, Row, dan GridView.count.
- Munculin SnackBar saat kartu tombol ditekan.
- Jalanin flutter analyze lalu push ke repository GitHub baru yang terpisah dari repo Django.

b. Individual Assignment 7
- Ganti data contoh Burhan di InfoCard dengan identitas asliku (NPM, nama, kelas PBP E).
- Nambah atribut Color color di model ItemHomepage, terus ItemCard sekarang pakai item.color sebagai warna latar, jadi nggak perlu percabangan if-else.
- Isi daftar items dengan tombol Lihat Proyek (biru), Tambah Proyek (hijau), dan Logout (merah).
- Pastikan SnackBar nampilin nama tombol yang bener.
- Jalanin flutter analyze sampai tidak ada isu.
- Commit dan push bertahap ke GitHub.

### Tugas 7
1. # Apa itu widget tree dan gimana hubungan parent-child antar widget?

Di Flutter, semua yang ada di layar itu widget: teks, tombol, padding, bahkan layoutnya juga widget. Widget-widget ini disusun bertingkat kayak pohon, makanya namanya widget tree. Satu widget bisa punya satu anak (child) atau banyak anak (children), dan anaknya juga bisa punya anak lagi, terus begitu sampai ke widget paling ujung.

Di proyekku, kira-kira pohonnya begini:

MaterialApp
└── MyHomePage (Scaffold)
    ├── AppBar → Text
    └── Padding
        └── Column
            ├── Row → 3 × InfoCard
            ├── SizedBox
            └── Center → Column
                ├── Text (sambutan)
                └── GridView → 3 × ItemCard

Hubungan parent-child itu kayak satu arah: parent yang ngatur batas ukuran (constraints) buat anaknya, anaknya nentuin ukurannya sendiri di dalam batas itu, terus parent yang nentuin posisinya. Parent juga bisa ngewariskan sesuatu ke bawah, contohnya tema dari MaterialApp yang bisa dipakai semua widget di bawahnya lewat Theme.of(context). Karena strukturnya begini, kalau satu bagian berubah, Flutter cuma perlu ngebangun ulang bagian itu aja.

2. # Widget apa aja yang dipakai di proyek ini dan fungsinya?

Widget bawaan Flutter:
Widget	            Fungsi
MaterialApp	        Root aplikasi, nyediain tema, judul, dan halaman awal (home)
Scaffold	        Kerangka dasar halaman (AppBar, body, tempat SnackBar muncul)
AppBar	            Bar di bagian atas yang berisi judul "MyPortfolio"
Text	            Menampilkan teks (judul, isi kartu, sambutan, nama tombol)
Padding	            Memberi jarak di sekeliling widget
Column	            Menyusun widget secara vertikal (atas ke bawah)
Row	                Menyusun widget secara horizontal, dipakai buat ngejajarin tiga InfoCard
Center	            Ngeletakin anaknya di tengah
SizedBox	        Memberi jarak kosong dengan tinggi/lebar tertentu
GridView.count	    Menampilkan kartu tombol dalam grid dengan jumlah kolom tetap (3 kolom)
Card	            Kartu dengan bayangan (elevation), dipakai di InfoCard
Container	        Wadah buat ngatur ukuran dan padding
Material	        Memberi warna latar dan sudut membulat buat kartu tombol
InkWell	            Memberi efek ripple saat disentuh dan nangkep aksi onTap
Icon	            Menampilkan ikon (folder, add_circle, logout)
SnackBar	        Notifikasi singkat di bawah layar waktu tombol ditekan
ScaffoldMessenger	Yang ngatur dan nampilin SnackBar

Widget buatan sendiri (custom):
Widget	    Fungsi
MyApp	    Widget root yang bungkus MaterialApp (di main.dart)
MyHomePage	Halaman utama, nyimpan data profil dan daftar tombol
InfoCard	Kartu reusable buat nampilin judul dan isi (NPM, Name, Class)
ItemCard	Kartu tombol reusable yang punya warna, ikon, teks, dan SnackBar

Selain itu ada kelas ItemHomepage, tapi itu bukan widget, cuma model data buat menyimpan nama, ikon, dan warna tiap tombol.

3. # Apa fungsi MaterialApp dan kenapa dipakai sebagai root widget?

MaterialApp itu widget yang nyiapin perlengkapan dasar aplikasi bergaya Material Design. Fungsinya antara lain:
- Mengatur tema aplikasi lewat theme (warna, font, dan lain-lain), contohnya ColorScheme.fromSeed yang aku pakai.
- Menentukan halaman awal lewat home, dan ngatur navigasi/routing antar halaman.
- Menyediakan title aplikasi.
- Menyediakan hal-hal yang dibutuhin widget Material di bawahnya, misalnya Navigator, MediaQuery, dan - - - ScaffoldMessenger (yang dibutuhin buat nampilin SnackBar).

Makanya biasanya dia ditaruh paling atas (root). Widget kayak Scaffold, AppBar, dan InkWell itu butuh ancestor yang nyediain tema dan komponen Material tadi. Kalau MaterialApp nggak ada di atasnya, widget-widget itu bisa error atau tampilannya nggak karuan. Jadi dengan ditaruh di root, semua widget di bawahnya otomatis dapat tema dan fitur yang sama.

4. # Apa bedanya StatelessWidget dan StatefulWidget? Kapan pakai yang mana?

- StatelessWidget itu widget yang tampilannya tetap. Setelah dibuat, dia nggak nyimpan data yang bisa berubah-ubah, jadi tampilannya cuma bergantung pada data yang dikasih dari luar (parameter). Kalau mau berubah, harus dibuat ulang dari parent.
- StatefulWidget itu widget yang punya state (data yang bisa berubah selama aplikasi jalan). Dia punya kelas State terpisah, dan setiap kali state berubah lewat setState(), Flutter ngebangun ulang tampilannya.

Kapan pakai yang mana:
- Pakai Stateless kalau tampilannya statis. Contohnya di proyekku: MyHomePage, InfoCard, dan ItemCard, karena isinya cuma nampilin data tetap. Lebih simpel dan ringan karena nggak perlu ngelola state.
- Pakai Stateful kalau ada data yang berubah gara-gara interaksi user atau waktu. Contohnya: counter yang nambah tiap tombol ditekan (kayak app bawaan Flutter), input form, checkbox, atau data yang di-fetch dari API.
Makanya di Tutorial 08 MyHomePage yang awalnya stateful (karena bawaan counter) diubah jadi stateless, soalnya halaman menu kita nggak perlu nyimpan state apa-apa.

5. # Apa itu BuildContext dan kenapa penting?

BuildContext itu semacam penanda posisi sebuah widget di dalam widget tree. Lewat context ini, widget bisa tau dia ada di mana dan nanya ke atas"ke ancestornya (parent, kakek, dan seterusnya) buat ambil informasi yang dia butuhin.
Dia dikasih Flutter sebagai parameter di method build(BuildContext context). Di proyekku penggunaannya antara lain:
- Theme.of(context).colorScheme.primary buat ngambil warna dari tema MaterialApp.
- MediaQuery.of(context).size.width buat ngambil lebar layar, dipakai buat nentuin lebar InfoCard (dibagi 3,5).
- ScaffoldMessenger.of(context) buat nampilin SnackBar di Scaffold terdekat.

Hal ini penting karena tanpa BuildContext widget nggak bisa ngakses tema, ukuran layar, navigator, dan sebagainya. Dan karena context itu nunjuk ke posisi tertentu, hasil .of(context) bisa beda tergantung di mana widgetnya berada di tree.

6. # Apa itu hot reload, bedanya dengan hot restart, dan kapan harus restart?

Hot reload itu fitur buat nyuntikin kode yang baru diubah ke aplikasi yang lagi jalan, tanpa ngulang dari awal. Hasilnya muncul dalam hitungan detik dan state aplikasi tetap dipertahankan (misalnya angka counter nggak balik ke 0). Di terminal dipicu pakai r.
Hot restart itu ngulang aplikasi dari fungsi main() dengan kode terbaru, jadi statenya hilang dan balik ke awal. Tapi tetap lebih cepat daripada stop terus run ulang. Di terminal dipicu pakai R (huruf besar).

Kapan nggak bisa cuma hot reload:
- Mengubah isi main() atau inisialisasi awal aplikasi, atau variabel global/static.
- Mengubah kelas dari StatelessWidget ke StatefulWidget atau sebaliknya.
- Mengubah struktur yang besar (nambah/hapus kelas atau ngubah tipe data, misalnya enum), atau kalau hot reload gagal dan muncul pesan suruh restart.

Kapan harus full restart (stop, lalu flutter run lagi):
- Menambah atau mengubah dependensi di pubspec.yaml.
- Mengubah kode native (folder android/, ios/, dan sebagainya) atau aset tertentu.
- Kalau koneksi ke Chrome putus (muncul No client connected atau Inspected target navigated or closed), jalanin ulang dari awal.

AI Disclosure : Dalam pengerjaan Individual Assignment 7, aku pakai AI  sebagai bantuan buat memahami isi tugas, setup lingkungan Flutter di Windows, dan ngejelasin potongan kode seperti InfoCard, ItemCard, dan GridView. AI juga memberi pnejelasan konsep dan langkah-langkahnya. Setelah itu aku nyocokin kodenya dengan struktur proyekku sendiri, ngetes langsung di Chrome, dan ngecek hasilnya pakai flutter analyze.Beberapa hal yang harus aku bereskan dan cek sendiri:Instalasi Android Studio sempat gagal (Installation Aborted) dan build di Chrome sempat error impellerc failure: Could not write file karena penyimpananku penuh,Instalasi Android Emulator hypervisor driver nggak mau selesai (tombol Finish nggak aktif). Aku memutuskan buat nge-skip karena aku jalanin aplikasi lewat Chrome, bukan emulator, dan semua komponen wajib dari tutorial udah terpasang.Kelas MyHomePage dobel dan kurung kurawal hilang. Waktu mindahin kode dari main.dart, kelas lama masih ketinggalan di menu.dart dan kelas baru ketempel di dalamnya, lalu setelah ngedit build ada } penutup kelas yang ikut kehapus. Hasilnya muncul puluhan error di terminal. Aku nemuin penyebabnya dari pesan error paling atas, lalu nyocokin ulang struktur menu.dart sampai tiap kelas berdiri sendiri.Aku melakukan penyesuain data dengan identitasku sendiri dan penyesuaian warna tombol.

Sumber : 
https://docs.flutter.dev/ui/widgets-intro
https://docs.flutter.dev/ui/interactivity
