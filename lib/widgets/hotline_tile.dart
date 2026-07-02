import 'package:flutter/material.dart';
import '../app_theme.dart';

/// Hotline list tile untuk digunakan di bottom sheet Shield & Report.
class HotlineTile extends StatelessWidget {
  final String name;
  final String phone;
  final String description;
  final VoidCallback onTap;

  const HotlineTile({
    super.key,
    required this.name,
    required this.phone,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          const Icon(Icons.phone, color: Colors.green, size: AppTheme.iconMain),
      title: Text(name, style: AppTheme.body),
      subtitle: Text(description, style: AppTheme.captionMuted),
      trailing: const Icon(Icons.chevron_right,
          color: Colors.white, size: AppTheme.iconMain),
      onTap: onTap,
      splashColor: Colors.white.withOpacity(0.1),
    );
  }
}
