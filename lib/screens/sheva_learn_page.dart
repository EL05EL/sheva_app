import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

class ShevaLearnPage extends StatefulWidget {
  const ShevaLearnPage({super.key});

  @override
  State<ShevaLearnPage> createState() => _ShevaLearnPageState();
}

class _ShevaLearnPageState extends State<ShevaLearnPage> {
  // Tab selection: 0 = Modul, 1 = Disimpan
  int _selectedTab = 0;
  List<Module> _modules = [];
  List<int> _savedModuleIds = [];

  @override
  void initState() {
    super.initState();
    _modules = _getModuleList();
    _loadSavedModules();
  }

  // Daftar modul dengan konten dari sumber yang diberikan
  List<Module> _getModuleList() {
    return [
      Module(
        id: 1,
        title: 'MODUL 1',
        subtitle: 'Pengantar Kesetaraan Gender',
        duration: '10 min',
        content: '''
# Pengantar Kesetaraan Gender

Kesetaraan gender adalah kondisi di mana laki-laki dan perempuan memiliki hak, tanggung jawab, dan peluang yang sama tanpa memandang jenis kelamin. Kesetaraan gender bukan berarti laki-laki dan perempuan harus menjadi sama, tetapi mereka harus diberikan kesempatan yang sama untuk mengembangkan potensi mereka sepenuhnya.

## Mengapa Kesetaraan Gender Penting?

1. **Hak Asasi Manusia** – Kesetaraan gender adalah bagian fundamental dari hak asasi manusia. Setiap individu berhak diperlakukan dengan adil dan setara.

2. **Pembangunan Berkelanjutan** – SDGs Goal 5 menekankan bahwa kesetaraan gender adalah kunci untuk mencapai pembangunan berkelanjutan. Tanpa kesetaraan gender, tujuan pembangunan lainnya sulit tercapai.

3. **Pertumbuhan Ekonomi** – Ketika perempuan memiliki akses yang sama terhadap pendidikan dan pekerjaan, ekonomi suatu negara dapat tumbuh lebih cepat. Perempuan yang bekerja cenderung menginvestasikan 90% pendapatannya untuk keluarga, dibandingkan laki-laki yang hanya 30-40%.

4. **Keadilan Sosial** – Masyarakat yang adil adalah masyarakat yang memberikan kesempatan yang sama bagi semua individu, tanpa diskriminasi berbasis gender.

## Realitas di Indonesia

- Berdasarkan Global Gender Gap Index 2025, Indonesia berada di peringkat ke-97 dari 148 negara dengan skor 0,692.
- Tingkat Partisipasi Angkatan Kerja (TPAK) perempuan hanya sekitar 53%, sementara laki-laki 83%.
- Kesenjangan upah antara pekerja laki-laki dan perempuan masih terjadi, dengan rata-rata upah perempuan lebih rendah 30-40%.

## Apa yang Bisa Kita Lakukan?

1. **Edukasi diri sendiri dan orang lain** tentang pentingnya kesetaraan gender.
2. **Menolak stereotip gender** dalam kehidupan sehari-hari.
3. **Mendukung kebijakan yang berpihak pada kesetaraan gender**.
4. **Menjadi sekutu (ally)** bagi mereka yang mengalami ketidakadilan gender.

*Sumber: BPS, Komnas Perempuan, World Economic Forum*
''',
      ),
      Module(
        id: 2,
        title: 'MODUL 2',
        subtitle: 'Kekerasan Berbasis Gender (KBG)',
        duration: '10 min',
        content: '''
# Kekerasan Berbasis Gender (KBG)

Kekerasan Berbasis Gender (KBG) adalah setiap tindakan kekerasan yang dilakukan berdasarkan identitas gender dan orientasi seksual. KBG mencakup kekerasan fisik, seksual, psikologis, dan ekonomi yang terjadi di ranah personal, publik, maupun digital.

## Jenis-Jenis KBG

1. **KBG Fisik** – Tindakan kekerasan yang menyebabkan luka fisik, seperti memukul, menendang, atau menyiksa.

2. **KBG Psikologis** – Kekerasan yang menyerang mental korban, seperti penghinaan, ancaman, intimidasi, atau isolasi sosial.

3. **KBG Seksual** – Setiap tindakan seksual yang dilakukan tanpa persetujuan korban, termasuk pemerkosaan, pelecehan seksual, dan eksploitasi seksual.

4. **KBG Ekonomi** – Pembatasan akses ekonomi, seperti tidak diberi uang, dilarang bekerja, atau dipaksa menyerahkan pendapatan.

5. **KBG Online (KBGO)** – Kekerasan berbasis gender yang terjadi di ruang digital, seperti cyberbullying, doxing, penyebaran konten intim tanpa izin, dan pelecehan online.

## Data KBG di Indonesia

- **376.529** kasus kekerasan berbasis gender terhadap perempuan sepanjang 2025, naik 14,07% (Komnas Perempuan CATAHU 2025).
- **8.543** pengaduan kasus KBGO sepanjang 2025, naik 35% dari tahun sebelumnya.
- Korban KBGO terbesar berusia **15-19 tahun**, dengan tren baru usia **25-29 tahun**.
- Perempuan dengan disabilitas memiliki risiko kekerasan **2-5 kali lebih tinggi**.

## Dampak KBG

- Trauma psikologis mendalam (depresi, kecemasan, PTSD)
- Isolasi sosial dan stigma
- Gangguan kesehatan fisik dan reproduksi
- Kerugian ekonomi akibat kehilangan pekerjaan atau produktivitas

## Cara Melindungi Diri

1. **Kenali tanda-tanda kekerasan** dalam hubungan.
2. **Catat dan simpan bukti** jika mengalami kekerasan.
3. **Hubungi layanan bantuan** seperti SAPA 129 atau Komnas Perempuan.
4. **Laporkan** ke pihak berwajib atau lembaga perlindungan.

*Sumber: Komnas Perempuan CATAHU 2025, SPHPN 2024*
''',
      ),
      Module(
        id: 3,
        title: 'MODUL 3',
        subtitle: 'Kekerasan Berbasis Gender Online (KBGO)',
        duration: '10 min',
        content: '''
# Kekerasan Berbasis Gender Online (KBGO)

KBGO adalah segala bentuk kekerasan yang terjadi di ruang digital dan ditargetkan kepada seseorang berdasarkan gender. KBGO mencakup berbagai tindakan yang merugikan secara psikologis, sosial, dan ekonomi.

## Bentuk-Bentuk KBGO

1. **Cyberstalking** – Penguntitan online yang terus-menerus dan mengganggu.
2. **Doxing** – Penyebaran informasi pribadi tanpa izin untuk tujuan merugikan.
3. **Pelecehan Online** – Komentar, pesan, atau unggahan yang bersifat ofensif dan merendahkan berdasarkan gender.
4. **Penyebaran Konten Intim Tanpa Izin** – Menyebarkan foto atau video intim tanpa persetujuan korban.
5. **Body Shaming** – Mengkritik atau mengejek penampilan fisik seseorang.
6. **Catcalling Digital** – Komentar vulgar atau tidak senonoh di platform digital.

## Data KBGO di Indonesia

- **8.543** pengaduan kasus KBGO sepanjang 2025 (Komnas Perempuan).
- Meningkat **35%** dari tahun sebelumnya.
- Korban terbanyak usia **15-19 tahun**.
- Tren baru: korban usia **25-29 tahun** mulai meningkat.

## Dampak KBGO

- Kecemasan dan depresi
- Penurunan kepercayaan diri
- Isolasi dari lingkungan sosial
- Kerugian finansial dan karir
- Risiko bunuh diri (dalam kasus ekstrem)

## Tips Aman di Ruang Digital

1. **Jaga privasi** – Batasi informasi pribadi yang dibagikan.
2. **Gunakan kata sandi yang kuat** dan aktifkan autentikasi dua faktor.
3. **Laporkan dan blokir** akun yang melakukan pelecehan.
4. **Simpan bukti** (screenshot) untuk melapor ke pihak berwenang.
5. **Gunakan platform yang aman** dan periksa pengaturan privasi secara berkala.

## Cara Melapor KBGO

- Laporkan ke **Komnas Perempuan** atau **Kementerian PPA**.
- Hubungi **SAPA 129** untuk konsultasi dan bantuan.
- Gunakan fitur **SHEVA Report** untuk melapor secara anonim dan aman.

*Sumber: Komnas Perempuan, Kementerian PPA*
''',
      ),
      Module(
        id: 4,
        title: 'MODUL 4',
        subtitle: 'Gender dan Pembangunan',
        duration: '10 min',
        content: '''
# Gender dan Pembangunan

Pembangunan yang berkelanjutan tidak dapat dicapai tanpa melibatkan perempuan secara setara. Kesetaraan gender adalah prasyarat untuk pembangunan yang inklusif, adil, dan berkelanjutan.

## Mengapa Gender Penting dalam Pembangunan?

1. **Pengentasan Kemiskinan** – Perempuan yang diberdayakan secara ekonomi dapat mengurangi tingkat kemiskinan keluarga.

2. **Kesehatan Masyarakat** – Perempuan yang memiliki akses ke layanan kesehatan reproduksi akan melahirkan generasi yang lebih sehat.

3. **Pendidikan** – Anak perempuan yang mendapat pendidikan akan memutus rantai kemiskinan antargenerasi.

4. **Pertumbuhan Ekonomi** – Partisipasi perempuan dalam angkatan kerja dapat meningkatkan PDB suatu negara.

## SDGs dan Kesetaraan Gender

- **Goal 5** secara khusus membahas kesetaraan gender.
- Dari 17 tujuan SDGs, **16 tujuan** dan **91 target** berkaitan dengan kesetaraan gender.
- Target utama Goal 5: Menghapus segala bentuk kekerasan terhadap perempuan, mengakui pekerjaan domestik yang tidak dibayar, dan meningkatkan partisipasi perempuan dalam pengambilan keputusan.

## Tantangan di Indonesia

- **Budaya patriarki** yang masih kuat membatasi peran perempuan.
- **Kesenjangan akses pendidikan** di daerah 3T (Tertinggal, Terdepan, Terluar).
- **Rendahnya partisipasi politik** perempuan (hanya sekitar 20% kursi DPR).
- **Kekerasan berbasis gender** yang masih marak terjadi.

## Solusi dan Rekomendasi

1. **Pengarusutamaan gender** dalam semua kebijakan pembangunan.
2. **Investasi** dalam pendidikan dan kesehatan perempuan.
3. **Penguatan kapasitas** perempuan di bidang ekonomi dan politik.
4. **Penegakan hukum** yang berpihak pada korban kekerasan gender.

*Sumber: Bappenas, UNDP, Komnas Perempuan*
''',
      ),
      Module(
        id: 5,
        title: 'MODUL 5',
        subtitle: 'Gender dan Kesehatan',
        duration: '10 min',
        content: '''
# Gender dan Kesehatan

Kesehatan adalah hak asasi manusia yang harus diakses oleh semua orang tanpa diskriminasi. Namun, perbedaan gender memengaruhi akses, kualitas, dan hasil layanan kesehatan.

## Perbedaan Kebutuhan Kesehatan Berdasarkan Gender

1. **Kesehatan Reproduksi** – Perempuan membutuhkan akses ke layanan kesehatan reproduksi, termasuk KB, persalinan aman, dan pencegahan kanker serviks.

2. **Kesehatan Mental** – Perempuan lebih rentan terhadap depresi dan kecemasan, terutama akibat kekerasan berbasis gender.

3. **Penyakit Menular** – Perempuan memiliki risiko lebih tinggi terkena HIV/AIDS karena faktor biologis dan sosial.

4. **Penyakit Tidak Menular** – Laki-laki lebih rentan terhadap penyakit jantung dan stroke, tetapi perempuan sering kali diabaikan dalam deteksi dini.

## Hambatan Akses Kesehatan bagi Perempuan

- **Keterbatasan ekonomi** – Biaya kesehatan yang mahal.
- **Stigma sosial** – Terutama terkait kesehatan reproduksi dan mental.
- **Keterbatasan mobilitas** – Perempuan di daerah terpencil sulit mengakses fasilitas kesehatan.
- **Kurangnya informasi** – Rendahnya literasi kesehatan.

## Data Kesehatan Gender di Indonesia

- Angka Kematian Ibu (AKI) masih tinggi, terutama di daerah 3T.
- Kasus kekerasan seksual yang tidak dilaporkan menyebabkan trauma kesehatan mental.
- Perempuan dengan disabilitas memiliki risiko kesehatan yang lebih buruk.

## Upaya Peningkatan Kesehatan Gender

1. **Meningkatkan akses** layanan kesehatan reproduksi.
2. **Memberikan pendidikan kesehatan** yang sensitif gender.
3. **Membangun infrastruktur** kesehatan di daerah terpencil.
4. **Menghapus stigma** terhadap kesehatan mental dan reproduksi.

*Sumber: WHO, Kementerian Kesehatan, Komnas Perempuan*
''',
      ),
      Module(
        id: 6,
        title: 'MODUL 6',
        subtitle: 'Gender dan Pendidikan',
        duration: '10 min',
        content: '''
# Gender dan Pendidikan

Pendidikan adalah kunci untuk mencapai kesetaraan gender. Anak perempuan yang bersekolah memiliki peluang lebih besar untuk mandiri secara ekonomi dan berkontribusi pada masyarakat.

## Manfaat Pendidikan bagi Perempuan

1. **Pemberdayaan Ekonomi** – Perempuan berpendidikan memiliki peluang kerja yang lebih baik.
2. **Kesehatan yang Lebih Baik** – Pendidikan meningkatkan kesadaran akan kesehatan reproduksi.
3. **Penurunan Pernikahan Anak** – Anak perempuan yang bersekolah cenderung menikah lebih tua.
4. **Partisipasi Politik** – Pendidikan membuka jalan bagi perempuan untuk terlibat dalam pengambilan keputusan.

## Tantangan Pendidikan Gender di Indonesia

- **Angka putus sekolah** anak perempuan, terutama di daerah 3T.
- **Stereotip gender** dalam kurikulum dan buku teks.
- **Keterbatasan fasilitas** sanitasi di sekolah yang menghambat anak perempuan saat menstruasi.
- **Pernikahan anak** yang memotong pendidikan perempuan.

## Data Pendidikan Gender

- Tingkat partisipasi sekolah perempuan masih di bawah laki-laki di beberapa daerah.
- Hanya 40% mahasiswa STEM adalah perempuan.
- Kesenjangan literasi digital antara perempuan dan laki-laki masih terjadi.

## Solusi

1. **Beasiswa** untuk anak perempuan di daerah 3T.
2. **Kurikulum bebas gender** yang menghapus stereotip.
3. **Fasilitas sanitasi** yang layak di sekolah.
4. **Program pencegahan** pernikahan anak.

*Sumber: Kemendikbud, BPS, UNESCO*
''',
      ),
      Module(
        id: 7,
        title: 'MODUL 7',
        subtitle: 'Gender dan Ketenagakerjaan',
        duration: '10 min',
        content: '''
# Gender dan Ketenagakerjaan

Kesetaraan gender dalam ketenagakerjaan berarti laki-laki dan perempuan memiliki kesempatan yang sama untuk mendapatkan pekerjaan yang layak, upah yang adil, dan kondisi kerja yang aman.

## Realitas Ketenagakerjaan Gender di Indonesia

- **TPAK perempuan** hanya sekitar 53%, jauh di bawah laki-laki (83%).
- **Kesenjangan upah** – Perempuan menerima upah 30-40% lebih rendah dari laki-laki untuk pekerjaan yang sama.
- **Segregasi pekerjaan** – Perempuan dominan di sektor informal dan pekerjaan bergaji rendah.
- **Beban ganda** – Perempuan bekerja di sektor publik dan domestik tanpa pengakuan.

## Diskriminasi di Tempat Kerja

- **Rekrutmen bias gender** – Perempuan sering dianggap tidak kompeten untuk posisi tertentu.
- **Tidak ada cuti melahirkan yang memadai**.
- **Pelecehan seksual** di tempat kerja masih sering terjadi.
- **Kesulitan promosi** – Perempuan sulit mencapai posisi manajerial.

## Data Ketenagakerjaan

- Hanya 30% posisi manajerial diisi oleh perempuan.
- 60% pekerja informal adalah perempuan.
- Kesenjangan upah gender di Indonesia mencapai 30%.

## Solusi

1. **Penegakan UU Ketenagakerjaan** yang melindungi hak perempuan.
2. **Program pelatihan** untuk meningkatkan keterampilan perempuan.
3. **Fasilitas ramah perempuan** di tempat kerja (ruang laktasi, cuti melahirkan).
4. **Kampanye kesadaran** tentang diskriminasi gender di tempat kerja.

*Sumber: BPS, ILO, Kementerian Ketenagakerjaan*
''',
      ),
    ];
  }

  // Load modul yang disimpan dari SharedPreferences
  Future<void> _loadSavedModules() async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList('savedModules') ?? [];
    setState(() {
      _savedModuleIds = savedList.map((id) => int.parse(id)).toList();
    });
  }

  // Simpan atau hapus modul dari daftar simpanan
  Future<void> _toggleSaveModule(int moduleId) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_savedModuleIds.contains(moduleId)) {
        _savedModuleIds.remove(moduleId);
      } else {
        _savedModuleIds.add(moduleId);
      }
    });
    await prefs.setStringList(
        'savedModules', _savedModuleIds.map((id) => id.toString()).toList());
  }

  // Fungsi berbagi modul
  Future<void> _shareModule(Module module) async {
    final String shareText = '''
${module.title}
${module.subtitle}

${module.content}

---
Dibagikan dari SHEVA - Solidarity Hub for Equality, Voice, and Action
For She, For He, For All.
''';
    await Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    // Modul yang sudah disimpan
    final savedModules =
        _modules.where((m) => _savedModuleIds.contains(m.id)).toList();
    final displayModules = _selectedTab == 0 ? _modules : savedModules;

    return Scaffold(
      backgroundColor: const Color(0xFF17071F),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              height: 76,
              decoration: const BoxDecoration(
                color: Color(0xFF493370),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [
                  // Tombol kembali
                  Positioned(
                    left: 16,
                    top: 24,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  // Judul
                  const Positioned(
                    left: 54,
                    top: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SHEVA Learn',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Edukasi Kesetaraan Gender & Hak Asasi',
                          style: TextStyle(
                            color: Color(0xFFDAC4EB),
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Container(
                height: 29,
                decoration: ShapeDecoration(
                  color: const Color(0xFF240D2F),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color(0xFF2A283E)),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Row(
                  children: [
                    SizedBox(width: 12),
                    Icon(Icons.search, color: Color(0xFF919191), size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Cari modul...',
                      style: TextStyle(
                        color: Color(0xFF919191),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Tab Filter: Modul & Disimpan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _buildTabButton('Modul', 0),
                  const SizedBox(width: 16),
                  _buildTabButton('Disimpan', 1),
                ],
              ),
            ),
            // List Modul
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color(0xFF8A38F5)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: displayModules.isEmpty
                    ? const Center(
                        child: Text(
                          'Belum ada modul disimpan',
                          style: TextStyle(
                            color: Color(0xFF919191),
                            fontSize: 16,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        itemCount: displayModules.length,
                        itemBuilder: (context, index) {
                          final module = displayModules[index];
                          return _buildModuleCard(module);
                        },
                      ),
              ),
            ),
            // Footer
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Jika dalam bahaya sekarang, hubungi SAPA 129 atau polisi 110',
                style: TextStyle(
                  color: Color(0xFF919191),
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: ShapeDecoration(
          color: isSelected ? const Color(0xFF8A38F5) : const Color(0xFF4E2B7B),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFF2A283E)),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildModuleCard(Module module) {
    final isSaved = _savedModuleIds.contains(module.id);
    return GestureDetector(
      onTap: () {
        _navigateToModuleDetail(module);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          color: const Color(0xFF4E2B7B),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 2, color: Color(0xFF270F32)),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  module.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: const Color(0xFFDAC4EB),
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      module.duration,
                      style: const TextStyle(
                        color: Color(0xFFDAC4EB),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              module.subtitle,
              style: const TextStyle(
                color: Color(0xFFDAC4EB),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                // Tombol Simpan
                GestureDetector(
                  onTap: () => _toggleSaveModule(module.id),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF240D2F),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Color(0xFF2A283E)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_border,
                          color: const Color(0xFF919191),
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isSaved ? 'Disimpan' : 'Simpan',
                          style: const TextStyle(
                            color: Color(0xFF919191),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Tombol Bagikan
                GestureDetector(
                  onTap: () => _shareModule(module),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF240D2F),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Color(0xFF2A283E)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.share,
                          color: Color(0xFF919191),
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Bagikan',
                          style: TextStyle(
                            color: Color(0xFF919191),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToModuleDetail(Module module) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ModuleDetailPage(
          module: module,
          isSaved: _savedModuleIds.contains(module.id),
          onToggleSave: () {
            _toggleSaveModule(module.id);
          },
          onShare: () {
            _shareModule(module);
          },
        ),
      ),
    );
  }
}

// Model Modul
class Module {
  final int id;
  final String title;
  final String subtitle;
  final String duration;
  final String content;

  Module({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.content,
  });
}

// Halaman Detail Modul
class ModuleDetailPage extends StatelessWidget {
  final Module module;
  final bool isSaved;
  final VoidCallback onToggleSave;
  final VoidCallback onShare;

  const ModuleDetailPage({
    super.key,
    required this.module,
    required this.isSaved,
    required this.onToggleSave,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF17071F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF493370),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          module.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
            onPressed: onToggleSave,
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: onShare,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              module.subtitle,
              style: const TextStyle(
                color: Color(0xFFDAC4EB),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: Color(0xFFDAC4EB),
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  module.duration,
                  style: const TextStyle(
                    color: Color(0xFFDAC4EB),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                color: const Color(0xFF240D2F),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xFF2A283E)),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildContentParagraphs(module.content),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: onToggleSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4E2B7B),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Color(0xFF2A283E)),
                    ),
                  ),
                  icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
                  label: Text(isSaved ? 'Hapus dari Simpanan' : 'Simpan Modul'),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: onShare,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4E2B7B),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Color(0xFF2A283E)),
                    ),
                  ),
                  icon: const Icon(Icons.share),
                  label: const Text('Bagikan'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildContentParagraphs(String content) {
    final lines = content.split('\n');
    final List<Widget> widgets = [];
    for (var line in lines) {
      if (line.trim().isEmpty) {
        widgets.add(const SizedBox(height: 8));
      } else if (line.startsWith('#')) {
        // Header
        final level = line.split(' ').first.length;
        final text = line.substring(level).trim();
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: level == 1 ? 20 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      } else if (line.trim().startsWith('-')) {
        // Bullet point
        final text = line.trim().substring(1).trim();
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '• ',
                  style: TextStyle(
                    color: Color(0xFF9B89EC),
                    fontSize: 14,
                  ),
                ),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Color(0xFFDAC4EB),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (line.trim().startsWith('**') && line.trim().endsWith('**')) {
        // Bold text
        final text = line.trim().substring(2, line.trim().length - 2);
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      } else {
        // Regular text
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              line,
              style: const TextStyle(
                color: Color(0xFFDAC4EB),
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ),
        );
      }
    }
    return widgets;
  }
}
