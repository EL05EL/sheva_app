import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';
import '../theme/theme_extension.dart';

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
    await Future.delayed(const Duration(milliseconds: 800));
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
