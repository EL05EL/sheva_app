import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import '../services/supabase_service.dart';

class UserProvider extends ChangeNotifier {
  String _userName = 'Famuh24_';
  String _userGender = 'Laki-laki';
  String _joinDate = 'Maret 2022';
  String? _profileImagePath;
  String? _userId;
  final SupabaseService _supabase = SupabaseService();

  UserProvider() {
    _loadUserData();
  }

  String get userName => _userName;
  String get userGender => _userGender;
  String get joinDate => _joinDate;
  String? get profileImagePath => _profileImagePath;
  String? get userId => _userId;

  // ============================================================
  // LOAD DATA
  // ============================================================
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    _userId = prefs.getString('supabase_user_id');
    _userName = prefs.getString('userName') ?? 'Famuh24_';
    _userGender = prefs.getString('userGender') ?? 'Laki-laki';
    _joinDate = prefs.getString('joinDate') ?? 'Maret 2022';
    _profileImagePath = prefs.getString('profileImagePath');

    if (_userId != null) {
      try {
        final profile = await _supabase.getProfile(_userId!);
        if (profile != null) {
          _userName = profile['name'] ?? _userName;
          _userGender = profile['gender'] ?? _userGender;
          _joinDate = profile['join_date'] ?? _joinDate;
          await prefs.setString('userName', _userName);
          await prefs.setString('userGender', _userGender);
          await prefs.setString('joinDate', _joinDate);
        }
      } catch (e) {
        // Gagal sync, tetap pakai data lokal
      }
    }

    notifyListeners();
  }

  // ============================================================
  // 🔥 REFRESH USER ID (DENGAN FALLBACK LOCAL)
  // ============================================================
  Future<String?> refreshUserId() async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('supabase_user_id');

    // Jika sudah ada di lokal, langsung return
    if (userId != null) {
      _userId = userId;
      notifyListeners();
      return userId;
    }

    // Coba buat di Supabase (dengan retry)
    try {
      userId = await _supabase.getOrCreateUserId();
      await prefs.setString('supabase_user_id', userId);
      _userId = userId;
      notifyListeners();
      return userId;
    } catch (e) {
      // 🔥 FALLBACK: Buat ID lokal sementara jika Supabase gagal
      final fallbackId = 'local_${DateTime.now().millisecondsSinceEpoch}';
      await prefs.setString('supabase_user_id', fallbackId);
      _userId = fallbackId;
      notifyListeners();
      return fallbackId;
    }
  }

  // ============================================================
  // SETTERS
  // ============================================================
  Future<void> setUserName(String name) async {
    _userName = name;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);

    if (_userId != null && !_userId!.startsWith('local_')) {
      try {
        await _supabase.upsertProfile(
          userId: _userId!,
          name: name,
          gender: _userGender,
          joinDate: _joinDate,
        );
      } catch (_) {}
    }
    notifyListeners();
  }

  Future<void> setUserGender(String gender) async {
    _userGender = gender;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userGender', gender);

    if (_userId != null && !_userId!.startsWith('local_')) {
      try {
        await _supabase.upsertProfile(
          userId: _userId!,
          name: _userName,
          gender: gender,
          joinDate: _joinDate,
        );
      } catch (_) {}
    }
    notifyListeners();
  }

  Future<void> setJoinDate(String date) async {
    _joinDate = date;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('joinDate', date);

    if (_userId != null && !_userId!.startsWith('local_')) {
      try {
        await _supabase.upsertProfile(
          userId: _userId!,
          name: _userName,
          gender: _userGender,
          joinDate: date,
        );
      } catch (_) {}
    }
    notifyListeners();
  }

  // ============================================================
  // FOTO PROFIL (Tetap Lokal)
  // ============================================================
  Future<String?> _saveImageToAppDir(File imageFile) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final newPath = '${dir.path}/$fileName';
      await imageFile.copy(newPath);
      return newPath;
    } catch (_) {
      return null;
    }
  }

  Future<void> _deleteImageFile(String? filePath) async {
    if (filePath == null) return;
    try {
      final file = File(filePath);
      if (await file.exists()) await file.delete();
    } catch (_) {}
  }

  Future<void> setProfileImage(String? originalPath) async {
    String? finalPath;
    if (originalPath != null) {
      final sourceFile = File(originalPath);
      if (await sourceFile.exists()) {
        finalPath = await _saveImageToAppDir(sourceFile);
      }
    }

    final prefs = await SharedPreferences.getInstance();
    final oldPath = prefs.getString('profileImagePath');
    if (oldPath != null && oldPath != finalPath) {
      await _deleteImageFile(oldPath);
    }

    _profileImagePath = finalPath;
    if (finalPath != null) {
      await prefs.setString('profileImagePath', finalPath);
    } else {
      await prefs.remove('profileImagePath');
    }
    notifyListeners();
  }

  Future<void> resetProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final oldPath = prefs.getString('profileImagePath');
    if (oldPath != null) await _deleteImageFile(oldPath);

    _profileImagePath = null;
    await prefs.remove('profileImagePath');
    notifyListeners();
  }

  void refresh() => notifyListeners();
}
