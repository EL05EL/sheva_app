import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  String _themeMode = 'sistem';
  String _fontSize = 'sedang';
  bool _biometricEnabled = false;

  SettingsProvider() {
    _loadSettings();
  }

  String get themeMode => _themeMode;
  String get fontSize => _fontSize;
  bool get biometricEnabled => _biometricEnabled;

  ThemeMode get themeModeValue {
    switch (_themeMode) {
      case 'terang':
        return ThemeMode.light;
      case 'gelap':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

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
    _themeMode = prefs.getString('themeMode') ?? 'sistem';
    _fontSize = prefs.getString('fontSize') ?? 'sedang';
    _biometricEnabled = prefs.getBool('biometricEnabled') ?? false;
    notifyListeners();
  }

  Future<void> setThemeMode(String mode) async {
    _themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', mode);
    notifyListeners();
  }

  Future<void> setFontSize(String size) async {
    _fontSize = size;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fontSize', size);
    notifyListeners();
  }

  Future<void> setBiometricEnabled(bool value) async {
    _biometricEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('biometricEnabled', value);
    notifyListeners();
  }

  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _themeMode = 'sistem';
    _fontSize = 'sedang';
    _biometricEnabled = false;
    notifyListeners();
  }
}

class UserProvider extends ChangeNotifier {
  String _userName = 'Famuh24_';
  String _userGender = 'Laki-laki';
  String _joinDate = 'Maret 2022';
  String? _profileImagePath;

  UserProvider() {
    _loadUserData();
  }

  String get userName => _userName;
  String get userGender => _userGender;
  String get joinDate => _joinDate;
  String? get profileImagePath => _profileImagePath;

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _userName = prefs.getString('userName') ?? 'Famuh24_';
    _userGender = prefs.getString('userGender') ?? 'Laki-laki';
    _joinDate = prefs.getString('joinDate') ?? 'Maret 2022';
    _profileImagePath = prefs.getString('profileImagePath');
    notifyListeners();
  }

  Future<void> setUserName(String name) async {
    _userName = name;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
    notifyListeners();
  }

  Future<void> setUserGender(String gender) async {
    _userGender = gender;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userGender', gender);
    notifyListeners();
  }

  Future<void> setProfileImage(String? path) async {
    _profileImagePath = path;
    final prefs = await SharedPreferences.getInstance();
    if (path != null) {
      await prefs.setString('profileImagePath', path);
    } else {
      await prefs.remove('profileImagePath');
    }
    notifyListeners();
  }

  Future<void> setJoinDate(String date) async {
    _joinDate = date;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('joinDate', date);
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }
}
