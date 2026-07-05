import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/theme_extension.dart';

class HotlineTile extends StatelessWidget {
  final String name;
  final String phone;
  final String? whatsapp;
  final String description;
  final VoidCallback onTap;

  const HotlineTile({
    super.key,
    required this.name,
    required this.phone,
    this.whatsapp,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.shevaColors;
    final displayPhone = whatsapp ?? phone;
    return ListTile(
      leading: Icon(Icons.phone, color: Colors.green, size: AppTheme.iconMain),
      title: Text(name, style: TextStyle(color: colors.text1, fontSize: 16)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            style: TextStyle(color: colors.text3, fontSize: 14),
          ),
          Text(
            'WhatsApp: $displayPhone',
            style: TextStyle(
              color: colors.text4,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      trailing: Icon(Icons.chevron_right,
          color: colors.text1, size: AppTheme.iconMain),
      onTap: onTap,
      splashColor: colors.text1.withOpacity(0.1),
    );
  }
}
