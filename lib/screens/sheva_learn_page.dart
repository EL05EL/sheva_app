import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import '../theme/app_theme.dart';
import '../theme/theme_extension.dart';
import '../widgets/sos_button.dart';

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
      'savedModules',
      _savedModuleIds.map((id) => id.toString()).toList(),
    );
  }

  Future<void> _shareModule(Module module) async {
    final shareText = '''
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
    final colors = context.shevaColors;
    final savedModules =
        _modules.where((m) => _savedModuleIds.contains(m.id)).toList();
    final displayModules = _selectedTab == 0 ? _modules : savedModules;

    return Scaffold(
      backgroundColor: colors.bgDeep,
      floatingActionButton: const SosButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: colors.header,
        foregroundColor: colors.text1,
        elevation: 0,
        title: const Text(
          'SHEVA Learn',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingMd,
              vertical: AppTheme.spacingSm,
            ),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: colors.card,
                borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                border: Border.all(color: colors.border),
              ),
              child: Row(
                children: [
                  const SizedBox(width: AppTheme.spacingSm),
                  Icon(Icons.search,
                      color: colors.text4, size: AppTheme.spacingLg),
                  const SizedBox(width: AppTheme.spacingXs),
                  Text(
                    'Cari modul...',
                    style: TextStyle(
                      color: colors.text4,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMd),
            child: Row(
              children: [
                _buildTabButton('Modul', 0),
                const SizedBox(width: AppTheme.spacingSm),
                _buildTabButton('Disimpan', 1),
              ],
            ),
          ),
          Expanded(
            child: displayModules.isEmpty
                ? Center(
                    child: Text(
                      'Belum ada modul disimpan',
                      style: TextStyle(color: colors.text3, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(AppTheme.spacingMd),
                    itemCount: displayModules.length,
                    itemBuilder: (context, index) {
                      return _buildModuleCard(displayModules[index]);
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingSm),
            child: Text(
              'Jika dalam bahaya sekarang, hubungi SAPA 129 atau polisi 110',
              style: TextStyle(
                color: colors.text3,
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
    final colors = context.shevaColors;
    final isSelected = _selectedTab == index;
    return InkWell(
      onTap: () => setState(() => _selectedTab = index),
      borderRadius: BorderRadius.circular(AppTheme.spacingLg),
      splashColor: colors.text1.withOpacity(0.1),
      highlightColor: colors.text1.withOpacity(0.05),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingLg,
          vertical: AppTheme.spacingXs,
        ),
        decoration: ShapeDecoration(
          color: isSelected ? colors.accentMid : colors.card,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: colors.border),
            borderRadius: BorderRadius.circular(AppTheme.spacingLg),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: colors.text1,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildModuleCard(Module module) {
    final colors = context.shevaColors;
    final isSaved = _savedModuleIds.contains(module.id);
    return InkWell(
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
      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      splashColor: colors.text1.withOpacity(0.1),
      highlightColor: colors.text1.withOpacity(0.05),
      child: Container(
        margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        decoration: BoxDecoration(
          color: colors.cardWarm,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          border: Border.all(color: colors.borderStrong),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  module.title,
                  style: TextStyle(
                    color: colors.text1,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.access_time,
                        color: colors.text2, size: AppTheme.iconSmall),
                    const SizedBox(width: AppTheme.spacingXxs),
                    Text(
                      module.duration,
                      style: TextStyle(color: colors.text2, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingXxs),
            Text(
              module.subtitle,
              style: TextStyle(
                color: colors.text2,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: AppTheme.spacingSm),
            Row(
              children: [
                InkWell(
                  onTap: () => _toggleSaveModule(module.id),
                  borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                  splashColor: colors.text1.withOpacity(0.1),
                  highlightColor: colors.text1.withOpacity(0.05),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingSm,
                      vertical: AppTheme.spacingXxs,
                    ),
                    decoration: BoxDecoration(
                      color: colors.card,
                      borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                      border: Border.all(color: colors.border),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_border,
                          color: colors.text4,
                          size: AppTheme.iconSmall,
                        ),
                        const SizedBox(width: AppTheme.spacingXxs),
                        Text(
                          isSaved ? 'Disimpan' : 'Simpan',
                          style: TextStyle(
                            color: colors.text4,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingSm),
                InkWell(
                  onTap: () => _shareModule(module),
                  borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                  splashColor: colors.text1.withOpacity(0.1),
                  highlightColor: colors.text1.withOpacity(0.05),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingSm,
                      vertical: AppTheme.spacingXxs,
                    ),
                    decoration: BoxDecoration(
                      color: colors.card,
                      borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                      border: Border.all(color: colors.border),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.share,
                            color: colors.text4, size: AppTheme.iconSmall),
                        const SizedBox(width: AppTheme.spacingXxs),
                        Text(
                          'Bagikan',
                          style: TextStyle(
                            color: colors.text4,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Icon(Icons.chevron_right, color: colors.text1),
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
    final colors = context.shevaColors;
    return Scaffold(
      backgroundColor: colors.bgDeep,
      appBar: AppBar(
        backgroundColor: colors.header,
        foregroundColor: colors.text1,
        elevation: 0,
        title: Text(
          module.title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_border,
              size: AppTheme.iconMain,
              color: colors.text1,
            ),
            onPressed: onToggleSave,
            padding: const EdgeInsets.all(AppTheme.spacingXs),
            constraints: const BoxConstraints(
              minWidth: AppTheme.touchTarget,
              minHeight: AppTheme.touchTarget,
            ),
          ),
          IconButton(
            icon:
                Icon(Icons.share, size: AppTheme.iconMain, color: colors.text1),
            onPressed: onShare,
            padding: const EdgeInsets.all(AppTheme.spacingXs),
            constraints: const BoxConstraints(
              minWidth: AppTheme.touchTarget,
              minHeight: AppTheme.touchTarget,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              module.subtitle,
              style: TextStyle(
                color: colors.text2,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppTheme.spacingXs),
            Row(
              children: [
                Icon(Icons.access_time,
                    color: colors.text2, size: AppTheme.iconSmall),
                const SizedBox(width: AppTheme.spacingXxs),
                Text(
                  module.duration,
                  style: TextStyle(color: colors.text2, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingLg),
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              decoration: BoxDecoration(
                color: colors.card,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                border: Border.all(color: colors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildContentParagraphs(context, module.content),
              ),
            ),
            const SizedBox(height: AppTheme.spacingLg),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: onToggleSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.accentMid,
                    foregroundColor: colors.text1,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingXl,
                      vertical: AppTheme.spacingSm,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                      side: BorderSide(color: colors.border),
                    ),
                  ),
                  icon: Icon(
                    isSaved ? Icons.bookmark : Icons.bookmark_border,
                    size: AppTheme.iconMain,
                  ),
                  label: Text(isSaved ? 'Hapus dari Simpanan' : 'Simpan Modul'),
                ),
                const SizedBox(width: AppTheme.spacingMd),
                ElevatedButton.icon(
                  onPressed: onShare,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.accentMid,
                    foregroundColor: colors.text1,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingXl,
                      vertical: AppTheme.spacingSm,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                      side: BorderSide(color: colors.border),
                    ),
                  ),
                  icon: Icon(Icons.share, size: AppTheme.iconMain),
                  label: const Text('Bagikan'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🔥 PERBAIKAN: tambahkan parameter BuildContext
  List<Widget> _buildContentParagraphs(BuildContext context, String content) {
    final colors = context.shevaColors;
    final lines = content.split('\n');
    final List<Widget> widgets = [];
    for (var line in lines) {
      if (line.trim().isEmpty) {
        widgets.add(const SizedBox(height: AppTheme.spacingXs));
      } else if (line.startsWith('#')) {
        final level = line.split(' ').first.length;
        final text = line.substring(level).trim();
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingXs),
            child: Text(
              text,
              style: TextStyle(
                color: colors.text1,
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
            padding: const EdgeInsets.only(
                left: AppTheme.spacingSm, bottom: AppTheme.spacingXxs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• ',
                    style: TextStyle(color: colors.accent, fontSize: 14)),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(color: colors.text2, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingXxs),
            child: Text(
              line,
              style: TextStyle(
                color: colors.text2,
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
