import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  // ============================================================
  // AUTH - Login Anonim
  // ============================================================
  Future<String> getOrCreateUserId() async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('supabase_user_id');

    if (userId != null) {
      try {
        final session = _client.auth.currentSession;
        if (session != null) {
          return userId;
        }
      } catch (_) {}
    }

    final response = await _client.auth.signInAnonymously();
    final user = response.user;
    if (user != null) {
      await prefs.setString('supabase_user_id', user.id);
      return user.id;
    }
    throw Exception('Gagal login anonim ke Supabase');
  }

  // ============================================================
  // PROFILES
  // ============================================================
  Future<void> upsertProfile({
    required String userId,
    required String name,
    required String gender,
    required String joinDate,
  }) async {
    await _client.from('profiles').upsert({
      'id': userId,
      'name': name,
      'gender': gender,
      'join_date': joinDate,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  Future<Map<String, dynamic>?> getProfile(String userId) async {
    return await _client
        .from('profiles')
        .select()
        .eq('id', userId)
        .maybeSingle();
  }

  // ============================================================
  // REPORTS
  // ============================================================
  Future<void> createReport(Map<String, dynamic> report) async {
    await _client.from('reports').insert(report);
  }

  Future<List<Map<String, dynamic>>> getReports(String userId) async {
    final response = await _client
        .from('reports')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    return response;
  }

  // ============================================================
  // SAVED MODULES
  // ============================================================
  Future<void> toggleSavedModule({
    required String userId,
    required int moduleId,
    required bool isSaved,
  }) async {
    if (isSaved) {
      await _client.from('saved_modules').insert({
        'user_id': userId,
        'module_id': moduleId,
      });
    } else {
      await _client.from('saved_modules').delete().match({
        'user_id': userId,
        'module_id': moduleId,
      });
    }
  }

  Future<List<int>> getSavedModuleIds(String userId) async {
    final response = await _client
        .from('saved_modules')
        .select('module_id')
        .eq('user_id', userId);
    return response.map<int>((map) => map['module_id'] as int).toList();
  }

  // ============================================================
  // USER SETTINGS
  // ============================================================
  Future<void> upsertSettings({
    required String userId,
    required String fontSize,
    required bool isDarkMode,
  }) async {
    await _client.from('user_settings').upsert({
      'user_id': userId,
      'font_size': fontSize,
      'is_dark_mode': isDarkMode,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  Future<Map<String, dynamic>?> getSettings(String userId) async {
    return await _client
        .from('user_settings')
        .select()
        .eq('user_id', userId)
        .maybeSingle();
  }

  // ============================================================
  // HOTLINES - AMBIL DATA DARI SUPABASE
  // ============================================================
  Future<List<Map<String, dynamic>>> getHotlines({String? category}) async {
    try {
      var query = _client.from('hotlines').select('*');
      if (category != null) {
        query = query.eq('category', category);
      }
      query = query.eq('is_active', true);
      final response = await query.order('sort_order', ascending: true);
      return response;
    } catch (e) {
      return [];
    }
  }
}
