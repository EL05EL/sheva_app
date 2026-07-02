import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Centralized theme constants for SHEVA app.
/// Contains all colors, typography, spacing, radius, elevation, and SVG loader.
class AppTheme {
  // ============================================================
  // 🎨 COLORS (Semua warna aplikasi terpusat di sini)
  // ============================================================

  // Primary & Secondary
  static const Color primary = Color(0xFF493370);
  static const Color primaryDark = Color(0xFF290D36);
  static const Color primaryLight = Color(0xFF48336F); // AppBar Report
  static const Color secondary = Color(0xFF9B89EC);
  static const Color secondaryDark = Color(0xFF744AC1);

  // Backgrounds
  static const Color background = Color(0xFF290D36);
  static const Color backgroundLight = Color(0xFF17071F);
  static const Color surface = Color(0xFF240D2F);
  static const Color surfaceCard = Color(0xFF1A1732);
  static const Color surfaceCard2 = Color(0xFF4E2B7B);
  static const Color surfaceCardAlt = Color(0xFF291B4D);
  static const Color surfaceCardDark = Color(0xFF270F32);

  // Text
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFDAC4EB);
  static const Color textMuted = Color(0xFF919191);
  static const Color textHint = Color(0xFF736C78);
  static const Color textPurpleLight = Color(0xFFE5CFF6);
  static const Color textPurpleMuted = Color(0xFF837F98);

  // Accent
  static const Color accentPurple = Color(0xFF9B89EC);
  static const Color accentPink = Color(0xFFF30DB6);
  static const Color accentPurpleDark = Color(0xFF8A38F5);

  // Danger
  static const Color danger = Color(0xFFFF0C0C);
  static const Color dangerDark = Color(0xFFD90000);
  static const Color dangerLight = Color(0xFFDF0D0D);
  static const Color dangerBg = Color(0xFF401515);
  static const Color dangerBgSoft = Color(0x7FFF0C0C);

  // Borders
  static const Color borderDefault = Color(0xFF2A283E);
  static const Color borderLight = Color(0x7F744AC1);
  static const Color borderPink = Color(0xFF4F0970);
  static const Color borderBlue = Color(0xFF0061FF);
  static const Color borderEmergency = Color(0xFF0061FF);

  // Location / Map
  static const Color locateBg = Color(0x267A2062);
  static const Color locateBorder = Color(0xFF7A2062);

  // Emergency Cards
  static const Color emergencyCardBg = Color(0x4C450AF6);

  // Misc UI
  static const Color iconBgDark = Color(0xFF0C2230);
  static const Color chipBg = Color(0x7F744AC1);
  static const Color genderBgSelected = Color(0xFF3D1A4A);
  static const Color genderBorderUnselected = Color(0xFFDB97FB);
  static const Color statBg = Color(0x7F744AC1);
  static const Color shieldCardBg = Color(0xB2D90000);

  // ============================================================
  // 📏 ELEVATION (Standarisasi bayangan)
  // ============================================================
  static const double elevationNone = 0;
  static const double elevationLow = 2;
  static const double elevationMedium = 4;
  static const double elevationHigh = 8;
  static const double elevationFAB = 12;

  // ============================================================
  // 📝 TYPOGRAPHY
  // ============================================================
  static const TextStyle h1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.3,
    color: textPrimary,
  );
  static const TextStyle h1Secondary = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.3,
    color: secondary,
  );
  static const TextStyle h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.3,
    color: textPrimary,
  );
  static const TextStyle h2Secondary = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.3,
    color: secondary,
  );
  static const TextStyle h2Medium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: textPrimary,
  );
  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: textPrimary,
  );
  static const TextStyle bodySecondary = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: textSecondary,
  );
  static const TextStyle bodyBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.45,
    color: textPrimary,
  );
  static const TextStyle caption = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: textSecondary,
  );
  static const TextStyle captionMuted = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: textMuted,
  );
  static const TextStyle label = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.3,
    color: textSecondary,
  );
  static const TextStyle labelMuted = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.3,
    color: textMuted,
  );
  static const TextStyle labelBold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    height: 1.3,
    color: textPrimary,
  );
  static const TextStyle tiny = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    height: 1.2,
    color: textMuted,
  );

  // ============================================================
  // 🖼 ICON SIZES
  // ============================================================
  static const double iconMain = 24.0;
  static const double iconSmall = 16.0;
  static const double iconLarge = 32.0;

  // ============================================================
  // 👆 TOUCH TARGET
  // ============================================================
  static const double touchTarget = 44.0;

  // ============================================================
  // 📐 SPACING (kelipatan 4/8)
  // ============================================================
  static const double spacingXxs = 4.0;
  static const double spacingXs = 8.0;
  static const double spacingSm = 12.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 20.0;
  static const double spacingXl = 24.0;
  static const double spacingXxl = 40.0;

  // ============================================================
  // 🔲 BORDER RADIUS
  // ============================================================
  static const double radiusSm = 10.0;
  static const double radiusMd = 15.0;
  static const double radiusLg = 20.0;
  static const double radiusXl = 30.0;

  // ============================================================
  // 🧩 CARD DECORATIONS
  // ============================================================
  static BoxDecoration cardDecoration({
    Color? color,
    Color? borderColor,
    double borderRadius = radiusMd,
    double borderWidth = 1.0,
  }) {
    return BoxDecoration(
      color: color ?? surface,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: borderColor ?? borderDefault,
        width: borderWidth,
      ),
    );
  }

  static BoxDecoration cardDecorationHeavy({
    Color? color,
    Color? borderColor,
    double borderRadius = radiusMd,
    double borderWidth = 2.0,
  }) {
    return BoxDecoration(
      color: color ?? surfaceCard2,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: borderColor ?? const Color(0xFF270F32),
        width: borderWidth,
      ),
    );
  }

  // ============================================================
  // 🎯 THEME DATA (Dark Theme tetap dipaksa)
  // ============================================================
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: background,
        background: backgroundLight,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: h2Medium,
      ),
      textTheme: const TextTheme(
        displayLarge: h1,
        displayMedium: h2,
        bodyLarge: body,
        bodyMedium: bodySecondary,
        labelLarge: caption,
        labelMedium: label,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: surface,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSm),
            side: const BorderSide(color: borderDefault),
          ),
          elevation: elevationLow,
          padding: const EdgeInsets.symmetric(
            horizontal: spacingMd,
            vertical: spacingMd,
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: borderDefault),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: borderDefault),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: secondary),
        ),
        hintStyle: const TextStyle(color: textHint),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spacingMd,
          vertical: spacingSm,
        ),
      ),
    );
  }

  // ============================================================
  // 📥 SVG LOADER (Untuk ikon custom dari Figma)
  // ============================================================
  /// Cara pakai: AppTheme.loadSvg('assets/icons/logo_sheva.svg')
  static Widget loadSvg(
    String assetPath, {
    double? width,
    double? height,
    Color? color,
  }) {
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      colorFilter:
          color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }

  /// Shortcut untuk ikon utama (24x24)
  static Widget iconSvg(String assetPath, {Color? color}) {
    return loadSvg(assetPath, width: iconMain, height: iconMain, color: color);
  }

  /// Shortcut untuk ikon kecil (16x16)
  static Widget iconSmallSvg(String assetPath, {Color? color}) {
    return loadSvg(assetPath,
        width: iconSmall, height: iconSmall, color: color);
  }

  /// Shortcut untuk ikon besar (32x32)
  static Widget iconLargeSvg(String assetPath, {Color? color}) {
    return loadSvg(assetPath,
        width: iconLarge, height: iconLarge, color: color);
  }
}
