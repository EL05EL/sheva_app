import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';
import 'providers/settings_provider.dart';
import 'screens/splash_screen.dart'; // 🔥 Import halaman splash baru
import 'screens/login_page1.dart';
import 'screens/login_page2.dart';
import 'screens/login_page3.dart';
import 'screens/home_screen.dart';
import 'screens/sheva_shield_page.dart';
import 'screens/sheva_report_page.dart';
import 'screens/sheva_circle_page.dart';
import 'screens/sheva_map_page.dart';
import 'screens/sheva_learn_page.dart';
import 'screens/sheva_profile_page.dart';
import 'screens/sheva_setting_page.dart';
import 'screens/sheva_privacy_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) {
        return MaterialApp(
          title: 'SHEVA',
          theme: AppTheme.darkTheme,
          themeMode: ThemeMode.dark,
          // 🔥 Perubahan: Awalnya ke SplashScreen, bukan langsung ke Login
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => const SplashScreen(),
            '/': (context) => const LoginPage1(),
            '/login2': (context) => const LoginPage2(),
            '/login3': (context) => const LoginPage3(),
            '/home': (context) => const HomeScreen(),
            '/shield': (context) => const ShevaShieldPage(),
            '/report': (context) => const ShevaReportPage(),
            '/circle': (context) => const ShevaCirclePage(),
            '/map': (context) => const ShevaMapPage(),
            '/learn': (context) => const ShevaLearnPage(),
            '/profile': (context) => const ShevaProfilePage(),
            '/settings': (context) => const ShevaSettingPage(),
            '/privacy': (context) => const ShevaPrivacyPage(),
          },
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: settingsProvider.fontScale,
              ),
              child: child!,
            );
          },
        );
      },
    );
  }
}
