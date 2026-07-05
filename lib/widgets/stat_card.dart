import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/theme_extension.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String source;
  final Color color;

  const StatCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.source,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.shevaColors;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spacingSm),
      decoration: BoxDecoration(
        color: colors.accentMid.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: colors.text1,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            source,
            style: TextStyle(
              color: colors.text1,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
