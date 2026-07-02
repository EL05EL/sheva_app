import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_theme.dart';
import '../providers/settings_provider.dart';
import '../widgets/sos_button.dart';
import '../utils/device_utils.dart';

class ShevaSettingPage extends StatefulWidget {
  const ShevaSettingPage({super.key});

  @override
  State<ShevaSettingPage> createState() => _ShevaSettingPageState();
}

class _ShevaSettingPageState extends State<ShevaSettingPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      floatingActionButton: const SosButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Pengaturan', style: AppTheme.h2Medium),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingLg),
        child: Column(
          children: [
            // TAMPILAN
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'TAMPILAN',
                style: TextStyle(
                    color: AppTheme.textPurpleLight,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: AppTheme.spacingXs),
            // Ukuran Teks
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              decoration: ShapeDecoration(
                color: AppTheme.surfaceCard,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 2, color: Color(0xFF3F2A60)),
                  borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ukuran Text',
                    style: TextStyle(
                        color: Color(0xFFF0EBF4),
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    'Berlaku langsung tanpa perlu restart aplikasi',
                    style: TextStyle(color: Color(0xFFD4C5E7), fontSize: 13),
                  ),
                  const SizedBox(height: AppTheme.spacingSm),
                  _buildFontSizeOption(
                      context, 'Kecil', 'kecil', 'Lebih banyak konten'),
                  const Divider(color: AppTheme.textSecondary),
                  _buildFontSizeOption(context, 'Sedang', 'sedang',
                      'Ukuran bawaan (direkomendasikan)'),
                  const Divider(color: Colors.white),
                  _buildFontSizeOption(
                      context, 'Besar', 'besar', 'Lebih mudah di baca'),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingXl),
            // TENTANG SHEVA
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'TENTANG SHEVA',
                style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: AppTheme.spacingXs),
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              decoration: ShapeDecoration(
                color: AppTheme.surfaceCard,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: AppTheme.borderLight),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
              ),
              child: Column(
                children: [
                  _buildInfoRow('Versi Aplikasi', 'v1.0.0'),
                  const Divider(color: Color(0xFF6B7280)),
                  _buildInfoRow('Tanggal Rilis', '17 Juni 2026'),
                  const Divider(color: Color(0xFF6B7280)),
                  _buildInfoRow(
                      'Perangkat', DeviceUtils.getFullDeviceInfo(context)),
                  const Divider(color: Color(0xFF6B7280)),
                  _buildInfoRow('Mode', 'Offline - Didukung penuh ✓'),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingMd),
            // Deskripsi SHEVA
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              decoration: ShapeDecoration(
                color: AppTheme.surfaceCard,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: AppTheme.borderLight),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
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
            const SizedBox(height: AppTheme.spacingXl),
            // ZONA BAHAYA
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'ZONA BAHAYA',
                style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: AppTheme.spacingXs),
            InkWell(
              onTap: () => _clearAllData(context, settingsProvider),
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              splashColor: Colors.red.withOpacity(0.2),
              highlightColor: Colors.red.withOpacity(0.1),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingMd,
                  vertical: AppTheme.spacingSm,
                ),
                decoration: ShapeDecoration(
                  color: AppTheme.surfaceCard,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 2, color: Colors.red),
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  ),
                ),
                child: Row(
                  children: [
                    if (_isLoading)
                      const SizedBox(
                        width: AppTheme.iconLarge,
                        height: AppTheme.iconLarge,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.red,
                        ),
                      )
                    else
                      const Icon(Icons.delete_forever,
                          color: Colors.red, size: AppTheme.iconLarge),
                    const SizedBox(width: AppTheme.spacingMd),
                    const Text(
                      'Hapus Semua Data Saya',
                      style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    if (!_isLoading)
                      const Icon(Icons.chevron_right, color: Colors.red),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingXl),
          ],
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ukuran teks berubah secara instan! ✨'),
            backgroundColor: AppTheme.primary,
            duration: Duration(seconds: 1),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingXs),
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
                  color: Color(0xFF9B8BE4), size: AppTheme.iconLarge),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingXs),
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
                color: AppTheme.textPurpleMuted,
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
          style: TextStyle(color: AppTheme.textSecondary),
        ),
        backgroundColor: AppTheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          side: const BorderSide(color: AppTheme.borderDefault),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal',
                style: TextStyle(color: AppTheme.textMuted)),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              if (_isLoading) return;
              setState(() => _isLoading = true);
              await settingsProvider.clearAllData();
              if (mounted) {
                setState(() => _isLoading = false);
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
