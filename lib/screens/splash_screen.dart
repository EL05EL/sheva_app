import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/supabase_service.dart';
import '../theme/app_theme.dart';
import '../theme/theme_extension.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SupabaseService _supabase = SupabaseService();

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(milliseconds: 800));

    // 🔥 Coba buat user anonim, tapi TETAP LANJUTKAN walaupun gagal
    try {
      await _supabase.getOrCreateUserId();
    } catch (e) {
      debugPrint('⚠️ Supabase error (offline): $e');
      // Tetap lanjut ke halaman berikutnya
    }

    final prefs = await SharedPreferences.getInstance();
    final userName = prefs.getString('userName');

    if (mounted) {
      if (userName != null && userName.isNotEmpty) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.shevaColors;
    return Scaffold(
      backgroundColor: colors.bgDeep,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logosheva.png',
              width: 120,
              height: 120,
            ),
            const SizedBox(height: AppTheme.spacingLg),
            Text(
              'SHEVA',
              style: TextStyle(
                color: colors.accent,
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppTheme.spacingXs),
            CircularProgressIndicator(
              color: colors.accent,
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}
