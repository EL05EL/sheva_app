import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart' show MediaQuery, BuildContext;

class DeviceUtils {
  static String getOperatingSystem() {
    if (kIsWeb) return 'Web';
    if (Platform.isAndroid) return 'Android';
    if (Platform.isIOS) return 'iOS';
    if (Platform.isMacOS) return 'macOS';
    if (Platform.isWindows) return 'Windows';
    if (Platform.isLinux) return 'Linux';
    return 'Unknown OS';
  }

  static String getFormFactor(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    if (shortestSide >= 600) {
      return 'Tablet';
    } else {
      return 'Phone';
    }
  }

  static String getFullDeviceInfo(BuildContext context) {
    return '${getOperatingSystem()} - ${getFormFactor(context)}';
  }

  static String getDeviceModel() {
    return 'Unknown Model';
  }
}
