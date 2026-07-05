import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/theme_extension.dart';

class MenuGridCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final String route;
  final IconData icon; // 🔥 TAMBAHKAN parameter icon

  const MenuGridCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.route,
    required this.icon, // 🔥 WAJIB diisi
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.shevaColors;
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      splashColor: colors.text1.withOpacity(0.1),
      highlightColor: colors.text1.withOpacity(0.05),
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacingSm),
        decoration: ShapeDecoration(
          // 🔥 PERBAIKAN: Kurangi transparansi (dari 0.5 jadi 0.85 agar lebih solid)
          color: color.withOpacity(0.85),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: colors.text1.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🔥 TAMBAHKAN IKON di atas teks
            Icon(
              icon,
              color: colors.text1,
              size: AppTheme.iconLarge,
            ),
            const SizedBox(height: AppTheme.spacingXs),
            Text(
              title,
              style: TextStyle(
                color: colors.text1,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.spacingXxs),
            Text(
              subtitle,
              style: TextStyle(
                color: colors.text1.withOpacity(0.9),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
