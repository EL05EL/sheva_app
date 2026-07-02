import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

class ShevaLearnPage extends StatefulWidget {
  const ShevaLearnPage({super.key});

  @override
  State<ShevaLearnPage> createState() => _ShevaLearnPageState();
}

class _ShevaLearnPageState extends State<ShevaLearnPage> {
  int _selectedTab = 0;
  List<Module> _modules = [];
  List<int> _savedModuleIds = [];

  @override
  void initState() {
    super.initState();
    _modules = _getModuleList();
    _loadSavedModules();
  }

  List<Module> _getModuleList() {
    return [
      Module(
        id: 1,
        title: 'MODUL 1',
        subtitle: 'Pengantar Kesetaraan Gender',
        duration: '10 min',
        content: '''
# Pengantar Kesetaraan Gender

Kesetaraan gender adalah kondisi di mana laki-laki dan perempuan memiliki hak, tanggung jawab, dan peluang yang sama tanpa memandang jenis kelamin.

## Mengapa Kesetaraan Gender Penting?

1. **Hak Asasi Manusia** – Kesetaraan gender adalah bagian fundamental dari hak asasi manusia.

2. **Pembangunan Berkelanjutan** – SDGs Goal 5 menekankan kesetaraan gender sebagai kunci pembangunan.

3. **Pertumbuhan Ekonomi** – Perempuan yang bekerja menginvestasikan 90% pendapatan untuk keluarga.

4. **Keadilan Sosial** – Masyarakat adil memberikan kesempatan sama bagi semua.

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

KBG adalah setiap tindakan kekerasan berdasarkan identitas gender, mencakup fisik, seksual, psikologis, dan ekonomi.

## Jenis-Jenis KBG

1. **KBG Fisik** – Memukul, menendang, menyiksa.
2. **KBG Psikologis** – Penghinaan, ancaman, intimidasi.
3. **KBG Seksual** – Pemerkosaan, pelecehan seksual.
4. **KBG Ekonomi** – Pembatasan akses ekonomi.
5. **KBG Online (KBGO)** – Kekerasan di ruang digital.

## Data KBG di Indonesia

- **376.529** kasus KBG (2025), naik 14,07%.
- **8.543** pengaduan KBGO, naik 35%.
- Korban terbanyak usia 15-19 tahun.

*Sumber: Komnas Perempuan CATAHU 2025*
''',
      ),
      Module(
        id: 3,
        title: 'MODUL 3',
        subtitle: 'KBG Online (KBGO)',
        duration: '10 min',
        content: '''
# Kekerasan Berbasis Gender Online (KBGO)

KBGO adalah kekerasan di ruang digital yang merugikan psikologis, sosial, dan ekonomi.

## Bentuk-Bentuk KBGO

1. Cyberstalking
2. Doxing
3. Pelecehan Online
4. Penyebaran Konten Intim Tanpa Izin
5. Body Shaming

## Data KBGO di Indonesia

- 8.543 pengaduan kasus KBGO (2025)
- Meningkat 35% dari tahun sebelumnya
- Korban terbanyak usia 15-19 tahun

*Sumber: Komnas Perempuan*
''',
      ),
      Module(
        id: 4,
        title: 'MODUL 4',
        subtitle: 'Gender dan Pembangunan',
        duration: '10 min',
        content: '''
# Gender dan Pembangunan

Kesetaraan gender adalah prasyarat untuk pembangunan yang inklusif dan berkelanjutan.

## Mengapa Gender Penting?

1. Pengentasan kemiskinan
2. Kesehatan masyarakat
3. Pendidikan
4. Pertumbuhan ekonomi

## SDGs dan Kesetaraan Gender

Goal 5 secara khusus membahas kesetaraan gender. 16 tujuan dan 91 target berkaitan dengan kesetaraan gender.

*Sumber: Bappenas, UNDP*
''',
      ),
      Module(
        id: 5,
        title: 'MODUL 5',
        subtitle: 'Gender dan Kesehatan',
        duration: '10 min',
        content: '''
# Gender dan Kesehatan

Perbedaan gender memengaruhi akses, kualitas, dan hasil layanan kesehatan.

## Perbedaan Kebutuhan Kesehatan

1. Kesehatan Reproduksi
2. Kesehatan Mental
3. Penyakit Menular
4. Penyakit Tidak Menular

*Sumber: WHO, Kementerian Kesehatan*
''',
      ),
      Module(
        id: 6,
        title: 'MODUL 6',
        subtitle: 'Gender dan Pendidikan',
        duration: '10 min',
        content: '''
# Gender dan Pendidikan

Pendidikan adalah kunci mencapai kesetaraan gender.

## Manfaat Pendidikan bagi Perempuan

1. Pemberdayaan ekonomi
2. Kesehatan lebih baik
3. Penurunan pernikahan anak
4. Partisipasi politik

## Tantangan di Indonesia

- Angka putus sekolah anak perempuan
- Stereotip gender dalam kurikulum
- Keterbatasan fasilitas sanitasi

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

Kesetaraan gender dalam ketenagakerjaan berarti kesempatan sama untuk pekerjaan layak dan upah adil.

## Realitas di Indonesia

- TPAK perempuan 53%, laki-laki 83%
- Kesenjangan upah 30-40%
- 60% pekerja informal adalah perempuan

## Diskriminasi di Tempat Kerja

- Rekrutmen bias gender
- Pelecehan seksual
- Kesulitan promosi

*Sumber: BPS, ILO*
''',
      ),
    ];
  }

  Future<void> _loadSavedModules() async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList('savedModules') ?? [];
    setState(() {
      _savedModuleIds = savedList.map((id) => int.parse(id)).toList();
    });
  }

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

  Widget _buildSOSButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, '/shield'),
      backgroundColor: const Color(0xFFFF0C0C),
      foregroundColor: Colors.white,
      child: const Icon(Icons.sos, size: 32),
      shape: const CircleBorder(
        side: BorderSide(color: Colors.white, width: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final savedModules =
        _modules.where((m) => _savedModuleIds.contains(m.id)).toList();
    final displayModules = _selectedTab == 0 ? _modules : savedModules;

    return Scaffold(
      backgroundColor: const Color(0xFF17071F),
      floatingActionButton: _buildSOSButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: const Color(0xFF493370),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'SHEVA Learn',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Container(
              height: 40,
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
          // Tab
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildTabButton('Modul', 0),
                const SizedBox(width: 12),
                _buildTabButton('Disimpan', 1),
              ],
            ),
          ),
          // List
          Expanded(
            child: displayModules.isEmpty
                ? const Center(
                    child: Text(
                      'Belum ada modul disimpan',
                      style: TextStyle(color: Color(0xFF919191), fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: displayModules.length,
                    itemBuilder: (context, index) {
                      return _buildModuleCard(displayModules[index]);
                    },
                  ),
          ),
          // Footer
          Padding(
            padding: const EdgeInsets.all(12),
            child: const Text(
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
    );
  }

  Widget _buildTabButton(String label, int index) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ModuleDetailPage(
              module: module,
              isSaved: isSaved,
              onToggleSave: () => _toggleSaveModule(module.id),
              onShare: () => _shareModule(module),
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
                    const Icon(Icons.access_time,
                        color: Color(0xFFDAC4EB), size: 14),
                    const SizedBox(width: 4),
                    Text(
                      module.duration,
                      style: const TextStyle(
                          color: Color(0xFFDAC4EB), fontSize: 10),
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
                    child: const Row(
                      children: [
                        Icon(Icons.share, color: Color(0xFF919191), size: 16),
                        SizedBox(width: 4),
                        Text(
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
                const Icon(Icons.chevron_right, color: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                const Icon(Icons.access_time,
                    color: Color(0xFFDAC4EB), size: 16),
                const SizedBox(width: 4),
                Text(
                  module.duration,
                  style:
                      const TextStyle(color: Color(0xFFDAC4EB), fontSize: 12),
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
        final text = line.trim().substring(1).trim();
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ',
                    style: TextStyle(color: Color(0xFF9B89EC), fontSize: 14)),
                Expanded(
                  child: Text(
                    text,
                    style:
                        const TextStyle(color: Color(0xFFDAC4EB), fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
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
