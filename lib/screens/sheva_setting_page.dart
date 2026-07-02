import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShevaSettingPage extends StatefulWidget {
  const ShevaSettingPage({super.key});

  @override
  State<ShevaSettingPage> createState() => _ShevaSettingPageState();
}

class _ShevaSettingPageState extends State<ShevaSettingPage> {
  String _themeMode = 'sistem';
  String _fontSize = 'sedang';
  bool _biometricEnabled = false;

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

  void _changeTheme(String mode) {
    setState(() => _themeMode = mode);
    _saveSettings();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Tema akan berubah setelah aplikasi di-restart'),
          backgroundColor: Color(0xFF493370)),
    );
  }

  void _changeFontSize(String size) {
    setState(() => _fontSize = size);
    _saveSettings();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Ukuran teks akan berubah setelah aplikasi di-restart'),
          backgroundColor: Color(0xFF493370)),
    );
  }

  void _toggleBiometric(bool value) {
    setState(() => _biometricEnabled = value);
    _saveSettings();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(_biometricEnabled
              ? 'Kunci Biometrik Diaktifkan'
              : 'Kunci Biometrik Dinonaktifkan'),
          backgroundColor: const Color(0xFF493370)),
    );
  }

  Future<void> _clearAllData() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Semua Data?',
            style: TextStyle(color: Colors.white)),
        content: const Text(
            'Tindakan ini akan menghapus semua data Anda dari perangkat ini. Data yang dihapus tidak dapat dikembalikan. Apakah Anda yakin?',
            style: TextStyle(color: Color(0xFFDAC4EB))),
        backgroundColor: const Color(0xFF290D36),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: Color(0xFF2A283E)),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Batal',
                  style: TextStyle(color: Color(0xFF919191)))),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text('Hapus Semua'),
          ),
        ],
      ),
    );
    if (result == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      if (mounted) Navigator.pushReplacementNamed(context, '/');
    }
  }

  void _navigateToPrivacy() => Navigator.pushNamed(context, '/privacy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF17071F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF493370),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Pengaturan',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: const Icon(Icons.sos, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, '/shield'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // TAMPILAN
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('TAMPILAN',
                  style: TextStyle(
                      color: Color(0xFFE3DBED),
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
            ),
            const SizedBox(height: 8),
            // Tema
            Container(
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                color: const Color(0xFF1A1732),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 2, color: Color(0xFF3F2A60)),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tema Warna',
                      style: TextStyle(
                          color: Color(0xFFF0EBF4),
                          fontSize: 20,
                          fontWeight: FontWeight.w600)),
                  const Text('Pilih tampilan yang nyaman di mata',
                      style: TextStyle(color: Color(0xFFD4C5E7), fontSize: 13)),
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
            // Ukuran Teks
            Container(
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                color: const Color(0xFF1A1732),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0x7F744AC1)),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Ukuran Text',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700)),
                  const Text(
                      'Berlaku setelah menutup dan membuka ulang aplikasi',
                      style: TextStyle(color: Color(0xFFD5C6E8), fontSize: 15)),
                  const SizedBox(height: 16),
                  _buildFontSizeOption('Kecil', 'kecil', 'Lebih banyak konten'),
                  const Divider(color: Color(0xFFDAC4EB)),
                  _buildFontSizeOption(
                      'Sedang', 'sedang', 'Ukuran bawaan (direkomendasikan)'),
                  const Divider(color: Colors.white),
                  _buildFontSizeOption('Besar', 'besar', 'Lebih mudah di baca'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // KEAMANAN & PRIVASI
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('KEAMANAN & PRIVASI',
                  style: TextStyle(
                      color: Color(0xFFDAC4EB),
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                color: const Color(0xFF1A1732),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 2, color: Color(0xFF3F2A60)),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 55,
                        height: 55,
                        decoration: ShapeDecoration(
                            color: const Color(0xFF0C2230),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Icon(Icons.fingerprint,
                            color: Colors.white, size: 32),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Kunci Biometrik',
                                style: TextStyle(
                                    color: Color(0xFFF0EBF4),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600)),
                            Text(_biometricEnabled ? 'Aktif' : 'Nonaktif',
                                style: const TextStyle(
                                    color: Color(0xFFD4C5E7), fontSize: 13)),
                          ],
                        ),
                      ),
                      Switch(
                        value: _biometricEnabled,
                        onChanged: _toggleBiometric,
                        activeThumbColor: const Color(0xFF9B89EC),
                        activeTrackColor: const Color(0xFF4E2B7B),
                      ),
                    ],
                  ),
                  const Divider(color: Color(0xFFDAC4EB)),
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
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Icon(Icons.privacy_tip,
                              color: Colors.white, size: 32),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Kebijakan Privasi',
                                  style: TextStyle(
                                      color: Color(0xFFF0EBF4),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                              Text('Lihat cara kami melindungi anda',
                                  style: TextStyle(
                                      color: Color(0xFFD4C5E7), fontSize: 13)),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // TENTANG SHEVA
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('TENTANG SHEVA',
                  style: TextStyle(
                      color: Color(0xFFDAC4EB),
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                color: const Color(0xFF1A1732),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0x7F744AC1)),
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
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                color: const Color(0xFF1A1732),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0x7F744AC1)),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: 'SHEVA\n',
                        style: TextStyle(
                            color: Color(0xFF9B8BE4),
                            fontSize: 20,
                            fontWeight: FontWeight.w600)),
                    TextSpan(
                        text:
                            'Solidarity Hub for Equality, Voice, and Action - SDGs Goal 5: Gender Equality\n',
                        style: TextStyle(
                            color: Color(0xFFDFD2E9),
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                    TextSpan(
                        text: '"For She, For He, For All."',
                        style:
                            TextStyle(color: Color(0xFF6B7280), fontSize: 14)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // ZONA BAHAYA
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('ZONA BAHAYA',
                  style: TextStyle(
                      color: Color(0xFFDAC4EB),
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _clearAllData,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: ShapeDecoration(
                  color: const Color(0xFF1A1732),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 2, color: Colors.red),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.delete_forever,
                        color: Colors.red, size: 32),
                    SizedBox(width: 16),
                    Text('Hapus Semua Data Saya',
                        style: TextStyle(
                            color: Color(0xFFDAC4EB),
                            fontSize: 20,
                            fontWeight: FontWeight.w600)),
                    Spacer(),
                    Icon(Icons.chevron_right, color: Colors.red),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
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
        child: Text(label,
            style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFFF8F4FB),
                fontSize: 16,
                fontWeight: FontWeight.w700)),
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
                  Text(label,
                      style: TextStyle(
                          color: isSelected
                              ? const Color(0xFF9B8BE4)
                              : Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700)),
                  Text(subtitle,
                      style: const TextStyle(
                          color: Color(0xFFD5C6E8), fontSize: 15)),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle,
                  color: Color(0xFF9B8BE4), size: 28),
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
          Text(label,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
          Text(value,
              style: const TextStyle(
                  color: Color(0xFF837F98),
                  fontSize: 20,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
