import 'package:flutter/material.dart';
import '../app_theme.dart';

/// Card menu grid (Report, Learn, Map, Circle) di Home Screen.
class MenuGridCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final String route;

  const MenuGridCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      splashColor: Colors.white.withOpacity(0.1),
      highlightColor: Colors.white.withOpacity(0.05),
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacingSm),
        decoration: ShapeDecoration(
          color: color.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: Colors.white.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.spacingXxs),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white,
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
