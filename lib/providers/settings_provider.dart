import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  String _fontSize = 'sedang';

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

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _fontSize = prefs.getString('fontSize') ?? 'sedang';
    notifyListeners();
  }

  Future<void> setFontSize(String size) async {
    _fontSize = size;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fontSize', size);
    notifyListeners();
  }

  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    final oldImagePath = prefs.getString('profileImagePath');
    if (oldImagePath != null) {
      final file = File(oldImagePath);
      if (await file.exists()) {
        await file.delete();
      }
    }
    await prefs.clear();
    _fontSize = 'sedang';
    notifyListeners();
  }
}
