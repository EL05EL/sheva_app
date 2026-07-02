import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart' show MediaQuery, BuildContext;

class DeviceUtils {
  /// Mendapatkan nama Operating System (Android, iOS, Web, Windows, dll)
  static String getOperatingSystem() {
    if (kIsWeb) return 'Web';
    if (Platform.isAndroid) return 'Android';
    if (Platform.isIOS) return 'iOS';
    if (Platform.isMacOS) return 'macOS';
    if (Platform.isWindows) return 'Windows';
    if (Platform.isLinux) return 'Linux';
    return 'Unknown OS';
  }

  /// Mendeteksi apakah perangkat adalah Phone atau Tablet
  /// Threshold: lebar/tinggi terkecil >= 600dp dianggap Tablet
  static String getFormFactor(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    // Tablet biasanya memiliki shortestSide >= 600dp (iPad, tablet Android)
    if (shortestSide >= 600) {
      return 'Tablet';
    } else {
      return 'Phone';
    }
  }

  /// Menggabungkan OS + Form Factor
  /// Contoh output: "Android - Phone", "iOS - Tablet", "Web - Phone"
  static String getFullDeviceInfo(BuildContext context) {
    return '${getOperatingSystem()} - ${getFormFactor(context)}';
  }

  /// Mendapatkan nama model perangkat (jika diperlukan di masa depan)
  /// Catatan: Untuk mendapatkan model spesifik, butuh package 'device_info_plus'.
  /// Ini hanya placeholder.
  static String getDeviceModel() {
    // Untuk sekarang, kita kembalikan 'Unknown' karena butuh izin tambahan.
    // Jika ingin model spesifik, tambahkan device_info_plus.
    return 'Unknown Model';
  }
}
