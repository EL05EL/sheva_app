import 'package:flutter/material.dart';

/// Semua warna aplikasi SHEVA sesuai dokumen.
/// Digunakan melalui Theme.of(context).extension<ShevaColors>()!
@immutable
class ShevaColors extends ThemeExtension<ShevaColors> {
  // ---- Dark Mode (sesuai PDF halaman 1) ----
  final Color bgDeep;      // #18071F
  final Color bgWarm;      // #290D36
  final Color card;        // #1E1836
  final Color cardWarm;    // #2B1440
  final Color cardSoft;    // #241531
  final Color header;      // #4A3374
  final Color accent;      // #9B8BE4
  final Color accent2;     // #7C5CD6
  final Color accentMid;   // #4E2B7B
  final Color accentDeep;  // #331858
  final Color border;      // #40A087E1  (dengan opacity)
  final Color borderStrong;// #80AA91E6
  final Color text1;       // #FFFFFF
  final Color text2;       // #BFB3DE
  final Color text3;       // #9186AE
  final Color text4;       // #6E6590

  // ---- Light Mode (PDF halaman 2) ----
  final Color bgDeepLight;     // #F3F0FA
  final Color bgWarmLight;     // #FFFFFF
  final Color cardLight;       // #FFFFFF
  final Color cardWarmLight;   // #EFE9FB
  final Color headerLight;     // #6D4AAE
  final Color text1Light;      // #241536
  final Color text2Light;      // #5B4C7A
  final Color text3Light;      // #8479A0
  final Color text4Light;      // #AEA3C9

  // ---- Warna Fungsional (PDF halaman 2-3) ----
  final Color sosRed;          // #B3223F
  final Color danger;          // #82061B
  final Color blue;            // #1E2A50
  final Color magenta;         // #5C1D52
  final Color green;           // #1F6B3B

  // ---- Gradient (PDF halaman 3) ----
  final Gradient accentGrad;
  final Gradient dangerGrad;
  final Gradient blueGrad;
  final Gradient magentaGrad;
  final Gradient greenGrad;

  // ---- Warna Ikon & Tombol (PDF halaman 3) ----
  final Color iconProtection;  // #F0637E
  final Color iconEdukasi;     // #7C97F5
  final Color iconKomunitas;   // #6BDB93
  final Color iconMap;         // #E38AC4
  final Color star;            // #FBBF24
  final Color bioToggle;       // #4FD3B0

  // ---- Konstruktor ----
  const ShevaColors({
    required this.bgDeep,
    required this.bgWarm,
    required this.card,
    required this.cardWarm,
    required this.cardSoft,
    required this.header,
    required this.accent,
    required this.accent2,
    required this.accentMid,
    required this.accentDeep,
    required this.border,
    required this.borderStrong,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.bgDeepLight,
    required this.bgWarmLight,
    required this.cardLight,
    required this.cardWarmLight,
    required this.headerLight,
    required this.text1Light,
    required this.text2Light,
    required this.text3Light,
    required this.text4Light,
    required this.sosRed,
    required this.danger,
    required this.blue,
    required this.magenta,
    required this.green,
    required this.accentGrad,
    required this.dangerGrad,
    required this.blueGrad,
    required this.magentaGrad,
    required this.greenGrad,
    required this.iconProtection,
    required this.iconEdukasi,
    required this.iconKomunitas,
    required this.iconMap,
    required this.star,
    required this.bioToggle,
  });

  @override
  @override
  ShevaColors copyWith() => ShevaColors(
    bgDeep: bgDeep,
    bgWarm: bgWarm,
    card: card,
    cardWarm: cardWarm,
    cardSoft: cardSoft,
    header: header,
    accent: accent,
    accent2: accent2,
    accentMid: accentMid,
    accentDeep: accentDeep,
    border: border,
    borderStrong: borderStrong,
    text1: text1,
    text2: text2,
    text3: text3,
    text4: text4,
    bgDeepLight: bgDeepLight,
    bgWarmLight: bgWarmLight,
    cardLight: cardLight,
    cardWarmLight: cardWarmLight,
    headerLight: headerLight,
    text1Light: text1Light,
    text2Light: text2Light,
    text3Light: text3Light,
    text4Light: text4Light,
    sosRed: sosRed,
    danger: danger,
    blue: blue,
    magenta: magenta,
    green: green,
    accentGrad: accentGrad,
    dangerGrad: dangerGrad,
    blueGrad: blueGrad,
    magentaGrad: magentaGrad,
    greenGrad: greenGrad,
    iconProtection: iconProtection,
    iconEdukasi: iconEdukasi,
    iconKomunitas: iconKomunitas,
    iconMap: iconMap,
    star: star,
    bioToggle: bioToggle,
  );

  @override
  ShevaColors lerp(ThemeExtension<ShevaColors>? other, double t) {
    if (other is! ShevaColors) return this;
    return ShevaColors(
      bgDeep: Color.lerp(bgDeep, other.bgDeep, t)!,
      bgWarm: Color.lerp(bgWarm, other.bgWarm, t)!,
      card: Color.lerp(card, other.card, t)!,
      cardWarm: Color.lerp(cardWarm, other.cardWarm, t)!,
      cardSoft: Color.lerp(cardSoft, other.cardSoft, t)!,
      header: Color.lerp(header, other.header, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accent2: Color.lerp(accent2, other.accent2, t)!,
      accentMid: Color.lerp(accentMid, other.accentMid, t)!,
      accentDeep: Color.lerp(accentDeep, other.accentDeep, t)!,
      border: Color.lerp(border, other.border, t)!,
      borderStrong: Color.lerp(borderStrong, other.borderStrong, t)!,
      text1: Color.lerp(text1, other.text1, t)!,
      text2: Color.lerp(text2, other.text2, t)!,
      text3: Color.lerp(text3, other.text3, t)!,
      text4: Color.lerp(text4, other.text4, t)!,
      bgDeepLight: Color.lerp(bgDeepLight, other.bgDeepLight, t)!,
      bgWarmLight: Color.lerp(bgWarmLight, other.bgWarmLight, t)!,
      cardLight: Color.lerp(cardLight, other.cardLight, t)!,
      cardWarmLight: Color.lerp(cardWarmLight, other.cardWarmLight, t)!,
      headerLight: Color.lerp(headerLight, other.headerLight, t)!,
      text1Light: Color.lerp(text1Light, other.text1Light, t)!,
      text2Light: Color.lerp(text2Light, other.text2Light, t)!,
      text3Light: Color.lerp(text3Light, other.text3Light, t)!,
      text4Light: Color.lerp(text4Light, other.text4Light, t)!,
      sosRed: Color.lerp(sosRed, other.sosRed, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
      magenta: Color.lerp(magenta, other.magenta, t)!,
      green: Color.lerp(green, other.green, t)!,
      accentGrad: _lerpGradient(accentGrad, other.accentGrad, t),
      dangerGrad: _lerpGradient(dangerGrad, other.dangerGrad, t),
      blueGrad: _lerpGradient(blueGrad, other.blueGrad, t),
      magentaGrad: _lerpGradient(magentaGrad, other.magentaGrad, t),
      greenGrad: _lerpGradient(greenGrad, other.greenGrad, t),
      iconProtection: Color.lerp(iconProtection, other.iconProtection, t)!,
      iconEdukasi: Color.lerp(iconEdukasi, other.iconEdukasi, t)!,
      iconKomunitas: Color.lerp(iconKomunitas, other.iconKomunitas, t)!,
      iconMap: Color.lerp(iconMap, other.iconMap, t)!,
      star: Color.lerp(star, other.star, t)!,
      bioToggle: Color.lerp(bioToggle, other.bioToggle, t)!,
    );
  }

  static Gradient _lerpGradient(Gradient a, Gradient b, double t) {
    // Sederhana: ambil warna pertama dan kedua
    if (a is LinearGradient && b is LinearGradient) {
      return LinearGradient(
        colors: [
          Color.lerp(a.colors[0], b.colors[0], t)!,
          Color.lerp(a.colors[1], b.colors[1], t)!,
        ],
      );
    }
    return a;
  }
}

/// Extension untuk memudahkan akses ShevaColors dari BuildContext.
extension ShevaColorsContext on BuildContext {
  ShevaColors get shevaColors => Theme.of(this).extension<ShevaColors>()!;
}