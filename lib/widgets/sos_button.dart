import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/theme_extension.dart';

class SosButton extends StatelessWidget {
  const SosButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.shevaColors;
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, '/shield'),
      backgroundColor: colors.sosRed,
      foregroundColor: colors.text1,
      elevation: AppTheme.elevationFAB,
      child: const Icon(Icons.sos, size: 32),
      shape: const CircleBorder(
        side: BorderSide(color: Colors.white, width: 1),
      ),
      tooltip: 'Darurat SOS',
    );
  }
}
