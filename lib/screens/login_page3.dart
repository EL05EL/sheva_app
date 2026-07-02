import 'package:flutter/material.dart';
import '../app_theme.dart';

class LoginPage3 extends StatelessWidget {
  const LoginPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
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
                const Text(
                  'SHEVA hadir dengan',
                  style: AppTheme.h2Secondary,
                ),
                const SizedBox(height: AppTheme.spacingXs),
                const Text(
                  'Informasi ini hanya tersimpan di perangkat Anda dan tidak dikirim ke mana pun',
                  textAlign: TextAlign.center,
                  style: AppTheme.captionMuted,
                ),
                const SizedBox(height: AppTheme.spacingXl),
                // Fitur 1
                _buildFeatureItem(
                  'Perlindungan',
                  'SHEVA hadir sebagai pelindung - memberikan akses cepat ke bantuan darurat dan pelaporan',
                ),
                const SizedBox(height: AppTheme.spacingMd),
                // Fitur 2
                _buildFeatureItem(
                  'Edukasi',
                  'Pengetahuan adalah kekuatan. Pelajari hak-hak Anda dan bantu wujudkan kesetaraan',
                ),
                const SizedBox(height: AppTheme.spacingMd),
                // Fitur 3
                _buildFeatureItem(
                  'Komunitas',
                  'Bersama kita lebih kuat. Bergabunglah dengan gerakan For She, For He, For All.',
                ),
                const SizedBox(height: AppTheme.spacingXl),
                // Tagline
                const Text(
                  '"For She, For He, For All"',
                  style: TextStyle(
                    color: Color(0xFF744AC1),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXs),
                const Text(
                  'Bergabunglah bersama ribuan individu yang memperjuangkan kesetaraan gender di Indonesia!',
                  textAlign: TextAlign.center,
                  style: AppTheme.captionMuted,
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
                        side: const BorderSide(color: AppTheme.borderDefault),
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
                  child: const Text(
                    'Kembali',
                    style: AppTheme.captionMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      decoration: AppTheme.cardDecoration(),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFF4E2B7B),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.star,
              color: Colors.white,
              size: AppTheme.iconMain,
            ),
          ),
          const SizedBox(width: AppTheme.spacingSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.bodyBold,
                ),
                Text(
                  description,
                  style: AppTheme.captionMuted,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
