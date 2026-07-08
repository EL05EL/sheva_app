import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/supabase_service.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = true;
  final SupabaseService _supabase = SupabaseService();

  ThemeProvider() {
    _loadTheme();
  }

  bool get isDarkMode => _isDarkMode;

  // ============================================================
  // LOAD THEME (Lokal + Supabase)
  // ============================================================
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? true;

    // Sync dari Supabase
    final userId = prefs.getString('supabase_user_id');
    if (userId != null) {
      try {
        final settings = await _supabase.getSettings(userId);
        if (settings != null) {
          _isDarkMode = settings['is_dark_mode'] ?? _isDarkMode;
          await prefs.setBool('isDarkMode', _isDarkMode);
        }
      } catch (_) {}
    }
    notifyListeners();
  }

  // ============================================================
  // TOGGLE THEME (Lokal + Supabase)
  // ============================================================
  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);

    final userId = prefs.getString('supabase_user_id');
    if (userId != null) {
      try {
        final fontSize = prefs.getString('fontSize') ?? 'sedang';
        await _supabase.upsertSettings(
          userId: userId,
          fontSize: fontSize,
          isDarkMode: _isDarkMode,
        );
      } catch (_) {}
    }
    notifyListeners();
  }

  Future<void> setDarkMode(bool dark) async {
    if (_isDarkMode == dark) return;
    _isDarkMode = dark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', dark);

    final userId = prefs.getString('supabase_user_id');
    if (userId != null) {
      try {
        final fontSize = prefs.getString('fontSize') ?? 'sedang';
        await _supabase.upsertSettings(
          userId: userId,
          fontSize: fontSize,
          isDarkMode: dark,
        );
      } catch (_) {}
    }
    notifyListeners();
  }
}
