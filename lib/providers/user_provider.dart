import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<String?> _saveImageToAppDir(File imageFile) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final newPath = '${dir.path}/$fileName';
      await imageFile.copy(newPath);
      return newPath;
    } catch (e) {
      return null;
    }
  }

  Future<void> _deleteImageFile(String? filePath) async {
    if (filePath == null) return;
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {}
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
