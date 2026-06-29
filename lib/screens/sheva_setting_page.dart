import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShevaSettingPage extends StatefulWidget {
  const ShevaSettingPage({super.key});

  @override
  State<ShevaSettingPage> createState() => _ShevaSettingPageState();
}

class _ShevaSettingPageState extends State<ShevaSettingPage> {
  // Pengaturan
  String _themeMode = 'sistem'; // 'terang', 'gelap', 'sistem'
  String _fontSize = 'sedang'; // 'kecil', 'sedang', 'besar'
  bool _biometricEnabled = false;

  // Informasi aplikasi
  final String _appVersion = 'v1.0.0';
  final String _releaseDate = '17 Juni 2026';
  final String _platform = 'Web';
  final String _mode = 'Offline';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _themeMode = prefs.getString('themeMode') ?? 'sistem';
      _fontSize = prefs.getString('fontSize') ?? 'sedang';
      _biometricEnabled = prefs.getBool('biometricEnabled') ?? false;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', _themeMode);
    await prefs.setString('fontSize', _fontSize);
    await prefs.setBool('biometricEnabled', _biometricEnabled);
  }

  // Fungsi untuk mengubah tema
  void _changeTheme(String mode) {
    setState(() {
      _themeMode = mode;
    });
    _saveSettings();
    // Tampilkan notifikasi bahwa perubahan akan berlaku setelah restart
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tema akan berubah setelah aplikasi di-restart'),
        backgroundColor: const Color(0xFF493370),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Fungsi untuk mengubah ukuran teks
  void _changeFontSize(String size) {
    setState(() {
      _fontSize = size;
    });
    _saveSettings();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ukuran teks akan berubah setelah aplikasi di-restart'),
        backgroundColor: const Color(0xFF493370),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Fungsi toggle biometrik
  void _toggleBiometric(bool value) {
    setState(() {
      _biometricEnabled = value;
    });
    _saveSettings();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_biometricEnabled
            ? 'Kunci Biometrik Diaktifkan'
            : 'Kunci Biometrik Dinonaktifkan'),
        backgroundColor: const Color(0xFF493370),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Fungsi hapus semua data
  Future<void> _clearAllData() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Hapus Semua Data?',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Tindakan ini akan menghapus semua data Anda dari perangkat ini. '
          'Data yang dihapus tidak dapat dikembalikan. Apakah Anda yakin?',
          style: TextStyle(color: Color(0xFFDAC4EB)),
        ),
        backgroundColor: const Color(0xFF290D36),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: Color(0xFF2A283E)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Batal',
              style: TextStyle(color: Color(0xFF919191)),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Hapus Semua'),
          ),
        ],
      ),
    );

    if (result == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/');
      }
    }
  }

  // Navigasi ke Kebijakan Privasi
void _navigateToPrivacy() {
    Navigator.pushNamed(context, '/privacy');
  }

  @override
  Widget build(BuildContext context) {
    // Dapatkan skala font berdasarkan pilihan
    switch (_fontSize) {
      case 'kecil':
        break;
      case 'besar':
        break;
      default:
        break;
    }

    return Scaffold(
      backgroundColor: const Color(0xFF17071F),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                height: 89,
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
                      left: 56,
                      top: 24,
                      child: Text(
                        'Pengaturan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // ===== TAMPILAN =====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TAMPILAN',
                      style: TextStyle(
                        color: Color(0xFFE3DBED),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Card Tema Warna
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF1A1732),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 2,
                            color: Color(0xFF3F2A60),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tema Warna',
                            style: TextStyle(
                              color: Color(0xFFF0EBF4),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Text(
                            'Pilih tampilan yang nyaman di mata',
                            style: TextStyle(
                              color: Color(0xFFD4C5E7),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              _buildThemeOption('Terang', 'terang'),
                              const SizedBox(width: 12),
                              _buildThemeOption('Gelap', 'gelap'),
                              const SizedBox(width: 12),
                              _buildThemeOption('Sistem', 'sistem'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Card Ukuran Teks
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF1A1732),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color(0x7F744AC1),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ukuran Text',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Text(
                            'Berlaku setelah menutup dan membuka ulang aplikasi',
                            style: TextStyle(
                              color: Color(0xFFD5C6E8),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Pilihan ukuran teks
                          Column(
                            children: [
                              _buildFontSizeOption(
                                  'Kecil', 'kecil', 'Lebih banyak konten'),
                              const Divider(color: Color(0xFFDAC4EB)),
                              _buildFontSizeOption('Sedang', 'sedang',
                                  'Ukuran bawaan (direkomendasikan)'),
                              const Divider(color: Colors.white),
                              _buildFontSizeOption(
                                  'Besar', 'besar', 'Lebih mudah di baca'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              // ===== KEAMANAN & PRIVASI =====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'KEAMANAN & PRIVASI',
                      style: TextStyle(
                        color: Color(0xFFDAC4EB),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF1A1732),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 2,
                            color: Color(0xFF3F2A60),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          // Kunci Biometrik
                          Row(
                            children: [
                              Container(
                                width: 55,
                                height: 55,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF0C2230),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.fingerprint,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Kunci Biometrik',
                                      style: TextStyle(
                                        color: Color(0xFFF0EBF4),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      _biometricEnabled ? 'Aktif' : 'Nonaktif',
                                      style: const TextStyle(
                                        color: Color(0xFFD4C5E7),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                value: _biometricEnabled,
                                onChanged: _toggleBiometric,
                                activeColor: const Color(0xFF9B89EC),
                                activeTrackColor: const Color(0xFF4E2B7B),
                              ),
                            ],
                          ),
                          const Divider(color: Color(0xFFDAC4EB)),
                          // Kebijakan Privasi
                          GestureDetector(
                            onTap: _navigateToPrivacy,
                            child: Row(
                              children: [
                                Container(
                                  width: 55,
                                  height: 55,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF251E4A),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.privacy_tip,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Kebijakan Privasi',
                                        style: TextStyle(
                                          color: Color(0xFFF0EBF4),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const Text(
                                        'Lihat cara kami melindungi anda',
                                        style: TextStyle(
                                          color: Color(0xFFD4C5E7),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              // ===== TENTANG SHEVA =====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TENTANG SHEVA',
                      style: TextStyle(
                        color: Color(0xFFDAC4EB),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF1A1732),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color(0x7F744AC1),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Column(
                        children: [
                          _buildInfoRow('Versi Aplikasi', _appVersion),
                          const Divider(color: Color(0xFF6B7280)),
                          _buildInfoRow('Tanggal Rilis', _releaseDate),
                          const Divider(color: Color(0xFF6B7280)),
                          _buildInfoRow('Platform', _platform),
                          const Divider(color: Color(0xFF6B7280)),
                          _buildInfoRow('Mode', '$_mode - Didukung penuh ✓'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Deskripsi SHEVA
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF1A1732),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color(0x7F744AC1),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'SHEVA\n',
                              style: TextStyle(
                                color: Color(0xFF9B8BE4),
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'Solidarity Hub for Equality, Voice, and Action - SDGs Goal 5: Gender Equality\n',
                              style: TextStyle(
                                color: Color(0xFFDFD2E9),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: '"For She, For He, For All."',
                              style: TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              // ===== ZONA BAHAYA =====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ZONA BAHAYA',
                      style: TextStyle(
                        color: Color(0xFFDAC4EB),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: _clearAllData,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF1A1732),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 2,
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                              size: 32,
                            ),
                            const SizedBox(width: 16),
                            const Text(
                              'Hapus Semua Data Saya',
                              style: TextStyle(
                                color: Color(0xFFDAC4EB),
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.chevron_right,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              // Footer + SOS
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Jika dalam bahaya sekarang, hubungi SAPA 129 atau polisi 110',
                      style: TextStyle(
                        color: Color(0xFF919191),
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/shield');
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const ShapeDecoration(
                          color: Color(0x7FFF0C0C),
                          shape: OvalBorder(
                            side: BorderSide(width: 1, color: Colors.white),
                          ),
                        ),
                        child: const Icon(
                          Icons.sos,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeOption(String label, String value) {
    final isSelected = _themeMode == value;
    return GestureDetector(
      onTap: () => _changeTheme(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: ShapeDecoration(
          color: isSelected ? const Color(0xFF9B8BE4) : const Color(0xFF1A1732),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0x7F744AC1)),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFFF8F4FB),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildFontSizeOption(String label, String value, String subtitle) {
    final isSelected = _fontSize == value;
    return GestureDetector(
      onTap: () => _changeFontSize(value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color:
                          isSelected ? const Color(0xFF9B8BE4) : Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFFD5C6E8),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFF9B8BE4),
                size: 28,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF837F98),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
