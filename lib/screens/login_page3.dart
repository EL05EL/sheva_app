import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/theme_extension.dart';

class LoginPage3 extends StatelessWidget {
  const LoginPage3({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.shevaColors;
    return Scaffold(
      backgroundColor: colors.bgDeep,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingXl,
              vertical: AppTheme.spacingXxl,
            ),
            child: Column(
              children: [
                // LOGO
                Container(
                  width: 148,
                  height: 148,
                  decoration: ShapeDecoration(
                    image: const DecorationImage(
                      image: NetworkImage('https://placehold.co/148x148'),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.spacingXxl),
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingMd),
                Text(
                  'SHEVA hadir dengan',
                  style: TextStyle(
                    color: colors.accent,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXs),
                Text(
                  'Informasi ini hanya tersimpan di perangkat Anda dan tidak dikirim ke mana pun',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.text3,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXl),

                // 🔥 Fitur Perlindungan (Pure Icon, tanpa background bundar)
                _buildFeatureItem(
                  colors,
                  'Perlindungan',
                  'SHEVA hadir sebagai pelindung - memberikan akses cepat ke bantuan darurat dan pelaporan',
                  Icons.shield,
                  colors.iconProtection, // #F0637E
                ),
                const SizedBox(height: AppTheme.spacingMd),

                // 🔥 Fitur Edukasi (Pure Icon, tanpa background bundar)
                _buildFeatureItem(
                  colors,
                  'Edukasi',
                  'Pengetahuan adalah kekuatan. Pelajari hak-hak Anda dan bantu wujudkan kesetaraan',
                  Icons.book,
                  colors.iconEdukasi, // #7C97F5
                ),
                const SizedBox(height: AppTheme.spacingMd),

                // 🔥 Fitur Komunitas (Pure Icon, tanpa background bundar)
                _buildFeatureItem(
                  colors,
                  'Komunitas',
                  'Bersama kita lebih kuat. Bergabunglah dengan gerakan For She, For He, For All.',
                  Icons.people,
                  colors.iconKomunitas, // #6BDB93
                ),
                const SizedBox(height: AppTheme.spacingXl),

                // Tagline
                Text(
                  '"For She, For He, For All"',
                  style: TextStyle(
                    color: colors.accent2,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXs),
                Text(
                  'Bergabunglah bersama ribuan individu yang memperjuangkan kesetaraan gender di Indonesia!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.text3,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXxl),

                // Tombol Mulai Perjalanan
                SizedBox(
                  width: double.infinity,
                  height: 53,
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/home'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF270F32),
                      foregroundColor: const Color(0xFFF5F6FB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                        side: BorderSide(color: colors.border),
                      ),
                      elevation: 4,
                    ),
                    child: const Text(
                      'Mulai Perjalanan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingMd),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    'Kembali',
                    style: TextStyle(
                      color: colors.text3,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔥 FUNGSI DIPERBAIKI: Hanya ikon tanpa background bundar
  Widget _buildFeatureItem(
    ShevaColors colors,
    String title,
    String description,
    IconData icon,
    Color iconColor,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        children: [
          // 🔥 PERUBAHAN: Hanya Icon, tanpa Container lingkaran
          Icon(
            icon,
            color: iconColor, // warna solid sesuai PDF
            size: AppTheme.iconLarge, // 32px
          ),
          const SizedBox(width: AppTheme.spacingSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: colors.text1,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: colors.text3,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
