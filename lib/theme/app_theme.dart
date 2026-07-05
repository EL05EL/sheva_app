import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'theme_extension.dart';

class AppTheme {
  // ---- Spacing ----
  static const double spacingXxs = 4.0;
  static const double spacingXs = 8.0;
  static const double spacingSm = 12.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 20.0;
  static const double spacingXl = 24.0;
  static const double spacingXxl = 40.0;

  // ---- Radius ----
  static const double radiusSm = 10.0;
  static const double radiusMd = 15.0;
  static const double radiusLg = 20.0;
  static const double radiusXl = 30.0;

  // ---- Elevation ----
  static const double elevationNone = 0;
  static const double elevationLow = 2;
  static const double elevationMedium = 4;
  static const double elevationHigh = 8;
  static const double elevationFAB = 12;

  // ---- Icon sizes ----
  static const double iconMain = 24.0;
  static const double iconSmall = 16.0;
  static const double iconLarge = 32.0;

  // ---- Touch target ----
  static const double touchTarget = 44.0;

  // ---- Typography (menggunakan Plus Jakarta Sans) ----
  static TextTheme textTheme = GoogleFonts.plusJakartaSansTextTheme(
    const TextTheme(
      displayLarge:
          TextStyle(fontSize: 28, fontWeight: FontWeight.w700, height: 1.3),
      displayMedium:
          TextStyle(fontSize: 24, fontWeight: FontWeight.w700, height: 1.3),
      bodyLarge:
          TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.45),
      bodyMedium:
          TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.45),
      labelLarge:
          TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 1.4),
      labelMedium:
          TextStyle(fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),
    ),
  );

  // ---- Tema Gelap (Dark Mode) ----
  static ThemeData darkTheme(ShevaColors colors) {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: colors.bgDeep,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: colors.header,
        secondary: colors.accent,
        surface: colors.bgWarm,
        background: colors.bgDeep,
      ),
      extensions: [colors],
      textTheme: textTheme.apply(
        bodyColor: colors.text1,
        displayColor: colors.text1,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.header,
        foregroundColor: colors.text1,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.displayMedium?.copyWith(color: colors.text1),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.card,
          foregroundColor: colors.text1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSm),
            side: BorderSide(color: colors.border),
          ),
          elevation: elevationLow,
          padding: const EdgeInsets.symmetric(
              horizontal: spacingMd, vertical: spacingMd),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.card,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide(color: colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide(color: colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide(color: colors.accent),
        ),
        hintStyle: TextStyle(color: colors.text4),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: spacingMd, vertical: spacingSm),
      ),
    );
  }

  // ---- Tema Terang (Light Mode) ----
  static ThemeData lightTheme(ShevaColors colors) {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: colors.bgDeepLight,
      colorScheme: const ColorScheme.light().copyWith(
        primary: colors.headerLight,
        secondary: colors.accent,
        surface: colors.bgWarmLight,
        background: colors.bgDeepLight,
      ),
      extensions: [colors],
      textTheme: textTheme.apply(
        bodyColor: colors.text1Light,
        displayColor: colors.text1Light,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.headerLight,
        foregroundColor: colors.text1Light,
        elevation: 0,
        centerTitle: false,
        titleTextStyle:
            textTheme.displayMedium?.copyWith(color: colors.text1Light),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.cardLight,
          foregroundColor: colors.text1Light,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSm),
            side: BorderSide(color: colors.border),
          ),
          elevation: elevationLow,
          padding: const EdgeInsets.symmetric(
              horizontal: spacingMd, vertical: spacingMd),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.cardLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide(color: colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide(color: colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide(color: colors.accent),
        ),
        hintStyle: TextStyle(color: colors.text4Light),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: spacingMd, vertical: spacingSm),
      ),
    );
  }

  // ---- SVG loader ----
  static Widget loadSvg(String assetPath,
      {double? width, double? height, Color? color}) {
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      colorFilter:
          color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }

  static Widget iconSvg(String assetPath, {Color? color}) =>
      loadSvg(assetPath, width: iconMain, height: iconMain, color: color);
  static Widget iconSmallSvg(String assetPath, {Color? color}) =>
      loadSvg(assetPath, width: iconSmall, height: iconSmall, color: color);
  static Widget iconLargeSvg(String assetPath, {Color? color}) =>
      loadSvg(assetPath, width: iconLarge, height: iconLarge, color: color);
}
