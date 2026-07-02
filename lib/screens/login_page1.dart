import 'package:flutter/material.dart';
import '../app_theme.dart';

class LoginPage1 extends StatelessWidget {
  const LoginPage1({super.key});

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
                const SizedBox(height: AppTheme.spacingLg),
                const Text(
                  'Selamat Datang di',
                  style: AppTheme.captionMuted,
                ),
                const Text(
                  'SHEVA',
                  style: AppTheme.h1Secondary,
                ),
                const Text(
                  'Solidarity Hub For Equality, Voice, And Action',
                  style: AppTheme.captionMuted,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTheme.spacingXxl),
                // Statistik
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem('378K+', 'Kasus KBG\nTercatat 2025'),
                    _buildStatItem(
                        '5', 'Fitur Perlindungan'), // 🔥 Perbaikan: 5 bukan 8
                    _buildStatItem('100%', 'Data\nTerenkripsi'),
                  ],
                ),
                const SizedBox(height: AppTheme.spacingXl),
                // Quote
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppTheme.spacingMd),
                  decoration: AppTheme.cardDecoration(
                    color: AppTheme.surface,
                  ),
                  child: const Text(
                    '"SHEVA hadir untuk mewujudkan masyarakat Indonesia yang setara, adil, dan bebas dari kekerasan berbasis gender."',
                    textAlign: TextAlign.center,
                    style: AppTheme.captionMuted,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXxl),
                // Tombol Mulai
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
                        side: const BorderSide(color: AppTheme.borderDefault),
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

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            color: Color(0xFFA49AE2),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppTheme.spacingXxs),
        Text(
          label,
          style: AppTheme.labelMuted,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
