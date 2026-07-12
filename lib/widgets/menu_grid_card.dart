import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/theme_extension.dart';

class MenuGridCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color; // fallback
  final Gradient? gradient; // prioritas
  final String route;
  final IconData icon;

  const MenuGridCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    this.gradient,
    required this.route,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.shevaColors;

    final Decoration decoration;
    if (gradient != null) {
      decoration = BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(
          color: colors.text1.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: (gradient! as LinearGradient).colors.first.withOpacity(0.5),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      );
    } else {
      decoration = BoxDecoration(
        color: color.withOpacity(0.85),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(
          color: colors.text1.withOpacity(0.2),
          width: 1,
        ),
      );
    }

    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      splashColor: colors.text1.withOpacity(0.1),
      highlightColor: colors.text1.withOpacity(0.05),
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacingSm),
        decoration: decoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
