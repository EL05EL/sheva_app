import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Beri jeda 1 detik agar splash terlihat (opsional, untuk efek smooth)
    await Future.delayed(const Duration(milliseconds: 800));

    final prefs = await SharedPreferences.getInstance();
    final userName = prefs.getString('userName');

    if (mounted) {
      if (userName != null && userName.isNotEmpty) {
        // Sudah pernah login, langsung ke Home
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Belum pernah login, ke halaman Login
        Navigator.pushReplacementNamed(context, '/');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo / Placeholder
            Container(
              width: 120,
              height: 120,
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
              'SHEVA',
              style: AppTheme.h1Secondary,
            ),
            const SizedBox(height: AppTheme.spacingXs),
            const CircularProgressIndicator(
              color: AppTheme.secondary,
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}
