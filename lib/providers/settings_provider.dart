import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/supabase_service.dart';

class SettingsProvider extends ChangeNotifier {
  String _fontSize = 'sedang';
  final SupabaseService _supabase = SupabaseService();

  SettingsProvider() {
    _loadSettings();
  }

  String get fontSize => _fontSize;

  double get fontScale {
    switch (_fontSize) {
      case 'kecil':
        return 0.85;
      case 'besar':
        return 1.3;
      default:
        return 1.0;
    }
  }

  // ============================================================
  // LOAD SETTINGS (Lokal + Supabase)
  // ============================================================
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _fontSize = prefs.getString('fontSize') ?? 'sedang';

    // Sync dari Supabase
    final userId = prefs.getString('supabase_user_id');
    if (userId != null) {
      try {
        final settings = await _supabase.getSettings(userId);
        if (settings != null) {
          _fontSize = settings['font_size'] ?? _fontSize;
          await prefs.setString('fontSize', _fontSize);
        }
      } catch (_) {}
    }
    notifyListeners();
  }

  // ============================================================
  // SET FONT SIZE (Lokal + Supabase)
  // ============================================================
  Future<void> setFontSize(String size) async {
    _fontSize = size;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fontSize', size);

    final userId = prefs.getString('supabase_user_id');
    if (userId != null) {
      try {
        final isDark = prefs.getBool('isDarkMode') ?? true;
        await _supabase.upsertSettings(
          userId: userId,
          fontSize: size,
          isDarkMode: isDark,
        );
      } catch (_) {}
    }
    notifyListeners();
  }

  // ============================================================
  // SYNC SETTINGS (dipanggil dari ThemeProvider)
  // ============================================================
  Future<void> syncSettingsWithSupabase(String userId, bool isDarkMode) async {
    try {
      await _supabase.upsertSettings(
        userId: userId,
        fontSize: _fontSize,
        isDarkMode: isDarkMode,
      );
    } catch (_) {}
  }

  // ============================================================
  // HAPUS SEMUA DATA
  // ============================================================
  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();

    // Hapus foto profil
    final oldImagePath = prefs.getString('profileImagePath');
    if (oldImagePath != null) {
      final file = File(oldImagePath);
      if (await file.exists()) await file.delete();
    }

    // Hapus semua SharedPreferences
    await prefs.clear();

    // Reset state
    _fontSize = 'sedang';
    notifyListeners();
  }
}
