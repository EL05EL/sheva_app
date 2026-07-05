import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../theme/theme_extension.dart';
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
    final colors = context.shevaColors;
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      backgroundColor: colors.bgDeep,
      floatingActionButton: const SosButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: colors.header,
        foregroundColor: colors.text1,
        elevation: 0,
        title: const Text('Pengaturan',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingLg),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'TAMPILAN',
                style: TextStyle(
                  color: Colors.purpleAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingXs),
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              decoration: BoxDecoration(
                color: colors.card,
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                border: Border.all(color: colors.borderStrong),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ukuran Text',
                    style: TextStyle(
                      color: colors.text1,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Berlaku langsung tanpa perlu restart aplikasi',
                    style: TextStyle(
                      color: colors.text2,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingSm),
                  _buildFontSizeOption(
                      context, 'Kecil', 'kecil', 'Lebih banyak konten'),
                  const Divider(color: Colors.grey),
                  _buildFontSizeOption(context, 'Sedang', 'sedang',
                      'Ukuran bawaan (direkomendasikan)'),
                  const Divider(color: Colors.grey),
                  _buildFontSizeOption(
                      context, 'Besar', 'besar', 'Lebih mudah di baca'),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingXl),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'TENTANG SHEVA',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingXs),
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              decoration: BoxDecoration(
                color: colors.card,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                border: Border.all(color: colors.border),
              ),
              child: Column(
                children: [
                  _buildInfoRow('Versi Aplikasi', 'v1.0.0'),
                  const Divider(color: Colors.grey),
                  _buildInfoRow('Tanggal Rilis', '17 Juni 2026'),
                  const Divider(color: Colors.grey),
                  _buildInfoRow(
                      'Perangkat', DeviceUtils.getFullDeviceInfo(context)),
                  const Divider(color: Colors.grey),
                  _buildInfoRow('Mode', 'Offline - Didukung penuh ✓'),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingMd),
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              decoration: BoxDecoration(
                color: colors.card,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                border: Border.all(color: colors.border),
              ),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'SHEVA\n',
                      style: TextStyle(
                        color: colors.accent,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text:
                          'Solidarity Hub for Equality, Voice, and Action - SDGs Goal 5: Gender Equality\n',
                      style: TextStyle(
                        color: colors.text2,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: '"For She, For He, For All."',
                      style: TextStyle(
                        color: colors.text3,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingXl),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'ZONA BAHAYA',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
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
                decoration: BoxDecoration(
                  color: colors.card,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  border: Border.all(color: Colors.red, width: 2),
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
                    Text(
                      'Hapus Semua Data Saya',
                      style: TextStyle(
                        color: colors.text2,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
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
    final colors = context.shevaColors;
    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    final isSelected = settingsProvider.fontSize == value;

    return GestureDetector(
      onTap: () {
        settingsProvider.setFontSize(value);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ukuran teks berubah secara instan! ✨'),
            backgroundColor: Colors.purple,
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
                      color: isSelected ? colors.accent : colors.text1,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: colors.text2,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle,
                  color: colors.accent, size: AppTheme.iconLarge),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    final colors = context.shevaColors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: colors.text1,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: colors.text4,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _clearAllData(BuildContext context, SettingsProvider settingsProvider) {
    final colors = context.shevaColors;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hapus Semua Data?', style: TextStyle(color: colors.text1)),
        content: Text(
          'Tindakan ini akan menghapus semua data Anda dari perangkat ini. Data yang dihapus tidak dapat dikembalikan. Apakah Anda yakin?',
          style: TextStyle(color: colors.text2),
        ),
        backgroundColor: colors.bgDeep,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          side: BorderSide(color: colors.border),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal', style: TextStyle(color: colors.text4)),
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
