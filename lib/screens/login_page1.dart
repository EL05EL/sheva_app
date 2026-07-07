import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/theme_extension.dart';
import '../widgets/login_progress_indicator.dart';

class LoginPage1 extends StatelessWidget {
  const LoginPage1({super.key});

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
                // 🔥 Indikator Progress (halaman 1 dari 3)
                const LoginProgressIndicator(currentPage: 0),
                const SizedBox(height: AppTheme.spacingLg),

                // 🔥 LOGO PNG ukuran 148x148
                Image.asset(
                  'assets/images/logosheva.png',
                  width: 148,
                  height: 148,
                ),
                const SizedBox(height: AppTheme.spacingLg),

                Text(
                  'Selamat Datang di',
                  style: TextStyle(
                    color: colors.text3,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'SHEVA',
                  style: TextStyle(
                    color: colors.accent,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Solidarity Hub For Equality, Voice, And Action',
                  style: TextStyle(
                    color: colors.text3,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTheme.spacingXxl),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem(colors, '378K+', 'Kasus KBG\nTercatat 2025'),
                    _buildStatItem(colors, '5', 'Fitur Perlindungan'),
                    _buildStatItem(colors, '100%', 'Data\nTerenkripsi'),
                  ],
                ),
                const SizedBox(height: AppTheme.spacingXl),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppTheme.spacingMd),
                  decoration: BoxDecoration(
                    color: colors.card,
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    border: Border.all(color: colors.border),
                  ),
                  child: Text(
                    '"SHEVA hadir untuk mewujudkan masyarakat Indonesia yang setara, adil, dan bebas dari kekerasan berbasis gender."',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colors.text3,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXxl),

                SizedBox(
                  width: double.infinity,
                  height: 53,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/login2'),
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
                      'Mulai',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
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

  Widget _buildStatItem(ShevaColors colors, String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(
            color: colors.accent2,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppTheme.spacingXxs),
        Text(
          label,
          style: TextStyle(
            color: colors.text3,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
