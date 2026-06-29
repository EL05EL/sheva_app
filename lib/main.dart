import 'package:flutter/material.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SHEVA',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF290D36),
      ),
      initialRoute: '/',
      routes: {
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
    );
  }
}
