import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheva_app/providers/user_provider.dart';
import 'theme/app_theme.dart';
import 'theme/theme_extension.dart';
import 'providers/settings_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/splash_screen.dart';
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
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    // Ambil warna yang sesuai
    final colors = isDark ? _darkColors : _lightColors;

    return MaterialApp(
      title: 'SHEVA',
      theme: isDark ? AppTheme.darkTheme(colors) : AppTheme.lightTheme(colors),
      themeMode: ThemeMode
          .system, // biar mengikuti sistem, tapi kita override dengan provider
      // kita paksa pakai tema dari provider
      // untuk itu kita set theme dan darkTheme, dan themeMode = ThemeMode.dark/light
      // tapi lebih mudah kita set theme langsung
      // Karena kita sudah menentukan, kita pakai builder untuk override
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
        // Agar perubahan ukuran teks tetap jalan
        final settingsProvider = Provider.of<SettingsProvider>(context);
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: settingsProvider.fontScale,
          ),
          child: child!,
        );
      },
    );
  }
}

// ---- Definisi warna sesuai PDF ----
const _darkColors = ShevaColors(
  bgDeep: Color(0xFF18071F),
  bgWarm: Color(0xFF290D36),
  card: Color(0xFF1E1836),
  cardWarm: Color(0xFF2B1440),
  cardSoft: Color(0xFF241531),
  header: Color(0xFF4A3374),
  accent: Color(0xFF9B8BE4),
  accent2: Color(0xFF7C5CD6),
  accentMid: Color(0xFF4E2B7B),
  accentDeep: Color(0xFF331858),
  border: Color(0x40A087E1),
  borderStrong: Color(0x80AA91E6),
  text1: Color(0xFFFFFFFF),
  text2: Color(0xFFBFB3DE),
  text3: Color(0xFF9186AE),
  text4: Color(0xFF6E6590),
  bgDeepLight: Color(0xFFF3F0FA),
  bgWarmLight: Color(0xFFFFFFFF),
  cardLight: Color(0xFFFFFFFF),
  cardWarmLight: Color(0xFFEFE9FB),
  headerLight: Color(0xFF6D4AAE),
  text1Light: Color(0xFF241536),
  text2Light: Color(0xFF5B4C7A),
  text3Light: Color(0xFF8479A0),
  text4Light: Color(0xFFAEA3C9),
  sosRed: Color(0xFFB3223F),
  danger: Color(0xFF82061B),
  blue: Color(0xFF1E2A50),
  magenta: Color(0xFF5C1D52),
  green: Color(0xFF1F6B3B),
  accentGrad:
      const LinearGradient(colors: [Color(0xFF9370E8), Color(0xFF6A3FC4)]),
  dangerGrad:
      const LinearGradient(colors: [Color(0xFFC23350), Color(0xFF7A0A22)]),
  blueGrad:
      const LinearGradient(colors: [Color(0xFF3E56A0), Color(0xFF1E2A50)]),
  magentaGrad:
      const LinearGradient(colors: [Color(0xFFC23E8E), Color(0xFF7A2560)]),
  greenGrad:
      const LinearGradient(colors: [Color(0xFF34A860), Color(0xFF1B6B3A)]),
  iconProtection: Color(0xFFF0637E),
  iconEdukasi: Color(0xFF7C97F5),
  iconKomunitas: Color(0xFF6BDB93),
  iconMap: Color(0xFFE38AC4),
  star: Color(0xFFFBBF24),
  bioToggle: Color(0xFF4FD3B0),
);

const _lightColors = ShevaColors(
  bgDeep: Color(0xFFF3F0FA),
  bgWarm: Color(0xFFFFFFFF),
  card: Color(0xFFFFFFFF),
  cardWarm: Color(0xFFEFE9FB),
  cardSoft: Color(0xFFF3F0FA), // tidak ada di light, kita pakai bgDeep
  header: Color(0xFF6D4AAE),
  accent: Color(0xFF9B8BE4),
  accent2: Color(0xFF7C5CD6),
  accentMid: Color(0xFF4E2B7B),
  accentDeep: Color(0xFF331858),
  border: Color(0xFFAEA3C9), // kurang lebih
  borderStrong: Color(0xFF5B4C7A),
  text1: Color(0xFF241536),
  text2: Color(0xFF5B4C7A),
  text3: Color(0xFF8479A0),
  text4: Color(0xFFAEA3C9),
  bgDeepLight: Color(0xFFF3F0FA),
  bgWarmLight: Color(0xFFFFFFFF),
  cardLight: Color(0xFFFFFFFF),
  cardWarmLight: Color(0xFFEFE9FB),
  headerLight: Color(0xFF6D4AAE),
  text1Light: Color(0xFF241536),
  text2Light: Color(0xFF5B4C7A),
  text3Light: Color(0xFF8479A0),
  text4Light: Color(0xFFAEA3C9),
  sosRed: Color(0xFFB3223F),
  danger: Color(0xFF82061B),
  blue: Color(0xFF1E2A50),
  magenta: Color(0xFF5C1D52),
  green: Color(0xFF1F6B3B),
  accentGrad:
      const LinearGradient(colors: [Color(0xFF9370E8), Color(0xFF6A3FC4)]),
  dangerGrad:
      const LinearGradient(colors: [Color(0xFFC23350), Color(0xFF7A0A22)]),
  blueGrad:
      const LinearGradient(colors: [Color(0xFF3E56A0), Color(0xFF1E2A50)]),
  magentaGrad:
      const LinearGradient(colors: [Color(0xFFC23E8E), Color(0xFF7A2560)]),
  greenGrad:
      const LinearGradient(colors: [Color(0xFF34A860), Color(0xFF1B6B3A)]),
  iconProtection: Color(0xFFF0637E),
  iconEdukasi: Color(0xFF7C97F5),
  iconKomunitas: Color(0xFF6BDB93),
  iconMap: Color(0xFFE38AC4),
  star: Color(0xFFFBBF24),
  bioToggle: Color(0xFF4FD3B0),
);
