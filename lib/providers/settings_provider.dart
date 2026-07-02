import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

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
    // Hapus juga file foto profil jika ada
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

// ============================================================
// USER PROVIDER dengan Penyimpanan Foto Internal
// ============================================================
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

  // 🔥 METHOD BARU: Menyimpan foto ke direktori internal aplikasi
  Future<String?> _saveImageToAppDir(File imageFile) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      // Buat nama file unik berdasarkan timestamp
      final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final newPath = '${dir.path}/$fileName';
      // Copy file ke direktori aplikasi
      await imageFile.copy(newPath);
      return newPath;
    } catch (e) {
      return null;
    }
  }

  // 🔥 METHOD BARU: Menghapus file foto dari direktori internal
  Future<void> _deleteImageFile(String? filePath) async {
    if (filePath == null) return;
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      // Abaikan error, file mungkin sudah tidak ada
    }
  }

  // 🔥 UPDATE: SetProfileImage sekarang menyimpan file ke internal
  Future<void> setProfileImage(String? originalPath) async {
    String? finalPath;

    if (originalPath != null) {
      // Jika ada file baru, copy ke direktori internal
      final sourceFile = File(originalPath);
      if (await sourceFile.exists()) {
        finalPath = await _saveImageToAppDir(sourceFile);
      }
    }

    // Hapus foto lama jika ada dan berbeda
    final prefs = await SharedPreferences.getInstance();
    final oldPath = prefs.getString('profileImagePath');
    if (oldPath != null && oldPath != finalPath) {
      await _deleteImageFile(oldPath);
    }

    // Simpan path baru ke SharedPreferences
    _profileImagePath = finalPath;
    if (finalPath != null) {
      await prefs.setString('profileImagePath', finalPath);
    } else {
      await prefs.remove('profileImagePath');
    }
    notifyListeners();
  }

  // 🔥 METHOD BARU: Reset foto profil (termasuk hapus file)
  Future<void> resetProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final oldPath = prefs.getString('profileImagePath');
    if (oldPath != null) {
      await _deleteImageFile(oldPath);
    }
    _profileImagePath = null;
    await prefs.remove('profileImagePath');
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
