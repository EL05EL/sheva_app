import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class ShevaSettingPage extends StatelessWidget {
  const ShevaSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

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
              child: Text(
                'TAMPILAN',
                style: TextStyle(
                    color: Color(0xFFE3DBED),
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
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
                  const Text(
                    'Tema Warna',
                    style: TextStyle(
                        color: Color(0xFFF0EBF4),
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    'Pilih tampilan yang nyaman di mata',
                    style: TextStyle(color: Color(0xFFD4C5E7), fontSize: 13),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildThemeOption(context, 'Terang', 'terang'),
                      const SizedBox(width: 12),
                      _buildThemeOption(context, 'Gelap', 'gelap'),
                      const SizedBox(width: 12),
                      _buildThemeOption(context, 'Sistem', 'sistem'),
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
                  const Text(
                    'Ukuran Text',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),
                  const Text(
                    'Berlaku setelah menutup dan membuka ulang aplikasi',
                    style: TextStyle(color: Color(0xFFD5C6E8), fontSize: 15),
                  ),
                  const SizedBox(height: 16),
                  _buildFontSizeOption(
                      context, 'Kecil', 'kecil', 'Lebih banyak konten'),
                  const Divider(color: Color(0xFFDAC4EB)),
                  _buildFontSizeOption(context, 'Sedang', 'sedang',
                      'Ukuran bawaan (direkomendasikan)'),
                  const Divider(color: Colors.white),
                  _buildFontSizeOption(
                      context, 'Besar', 'besar', 'Lebih mudah di baca'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // KEAMANAN & PRIVASI
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'KEAMANAN & PRIVASI',
                style: TextStyle(
                    color: Color(0xFFDAC4EB),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
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
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Icon(Icons.fingerprint,
                            color: Colors.white, size: 32),
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
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              settingsProvider.biometricEnabled
                                  ? 'Aktif'
                                  : 'Nonaktif',
                              style: const TextStyle(
                                  color: Color(0xFFD4C5E7), fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: settingsProvider.biometricEnabled,
                        onChanged: (value) {
                          settingsProvider.setBiometricEnabled(value);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(value
                                  ? 'Kunci Biometrik Diaktifkan'
                                  : 'Kunci Biometrik Dinonaktifkan'),
                              backgroundColor: const Color(0xFF493370),
                            ),
                          );
                        },
                        activeColor: const Color(0xFF9B89EC),
                        activeTrackColor: const Color(0xFF4E2B7B),
                      ),
                    ],
                  ),
                  const Divider(color: Color(0xFFDAC4EB)),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/privacy'),
                    child: Row(
                      children: [
                        Container(
                          width: 55,
                          height: 55,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF251E4A),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Icon(Icons.privacy_tip,
                              color: Colors.white, size: 32),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Kebijakan Privasi',
                                style: TextStyle(
                                    color: Color(0xFFF0EBF4),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              const Text(
                                'Lihat cara kami melindungi anda',
                                style: TextStyle(
                                    color: Color(0xFFD4C5E7), fontSize: 13),
                              ),
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
              child: Text(
                'TENTANG SHEVA',
                style: TextStyle(
                    color: Color(0xFFDAC4EB),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
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
                  _buildInfoRow('Versi Aplikasi', 'v1.0.0'),
                  const Divider(color: Color(0xFF6B7280)),
                  _buildInfoRow('Tanggal Rilis', '17 Juni 2026'),
                  const Divider(color: Color(0xFF6B7280)),
                  _buildInfoRow('Platform', 'Web'),
                  const Divider(color: Color(0xFF6B7280)),
                  _buildInfoRow('Mode', 'Offline - Didukung penuh ✓'),
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
                          fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text:
                          'Solidarity Hub for Equality, Voice, and Action - SDGs Goal 5: Gender Equality\n',
                      style: TextStyle(
                          color: Color(0xFFDFD2E9),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: '"For She, For He, For All."',
                      style: TextStyle(color: Color(0xFF6B7280), fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // ZONA BAHAYA
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'ZONA BAHAYA',
                style: TextStyle(
                    color: Color(0xFFDAC4EB),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _clearAllData(context, settingsProvider),
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
                child: Row(
                  children: [
                    const Icon(Icons.delete_forever,
                        color: Colors.red, size: 32),
                    const SizedBox(width: 16),
                    const Text(
                      'Hapus Semua Data Saya',
                      style: TextStyle(
                          color: Color(0xFFDAC4EB),
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    const Icon(Icons.chevron_right, color: Colors.red),
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

  Widget _buildThemeOption(BuildContext context, String label, String value) {
    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    final isSelected = settingsProvider.themeMode == value;

    return GestureDetector(
      onTap: () {
        settingsProvider.setThemeMode(value);
        // Tema langsung berubah tanpa restart karena Consumer di main.dart
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tema berubah menjadi $label'),
            backgroundColor: const Color(0xFF493370),
            duration: const Duration(seconds: 1),
          ),
        );
      },
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

  Widget _buildFontSizeOption(
      BuildContext context, String label, String value, String subtitle) {
    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    final isSelected = settingsProvider.fontSize == value;

    return GestureDetector(
      onTap: () {
        settingsProvider.setFontSize(value);
        // Ukuran teks langsung berubah tanpa restart karena MediaQuery override
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ukuran teks: $label'),
            backgroundColor: const Color(0xFF493370),
            duration: const Duration(seconds: 1),
          ),
        );
      },
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
                    style:
                        const TextStyle(color: Color(0xFFD5C6E8), fontSize: 15),
                  ),
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
          Text(
            label,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Text(
            value,
            style: const TextStyle(
                color: Color(0xFF837F98),
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  void _clearAllData(BuildContext context, SettingsProvider settingsProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Semua Data?',
            style: TextStyle(color: Colors.white)),
        content: const Text(
          'Tindakan ini akan menghapus semua data Anda dari perangkat ini. Data yang dihapus tidak dapat dikembalikan. Apakah Anda yakin?',
          style: TextStyle(color: Color(0xFFDAC4EB)),
        ),
        backgroundColor: const Color(0xFF290D36),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: Color(0xFF2A283E)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                const Text('Batal', style: TextStyle(color: Color(0xFF919191))),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await settingsProvider.clearAllData();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Hapus Semua'),
          ),
        ],
      ),
    );
  }
}
