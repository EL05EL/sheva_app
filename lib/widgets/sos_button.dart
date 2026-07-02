import 'package:flutter/material.dart';
import '../app_theme.dart';

/// SOS Floating Action Button yang reusable.
/// Muncul di semua halaman kecuali Shield (karena Shield sudah punya tombol kirim).
class SosButton extends StatelessWidget {
  const SosButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, '/shield'),
      backgroundColor: AppTheme.danger,
      foregroundColor: Colors.white,
      elevation: AppTheme.elevationFAB,
      child: const Icon(Icons.sos, size: 32),
      shape: const CircleBorder(
        side: BorderSide(color: Colors.white, width: 1),
      ),
      tooltip: 'Darurat SOS',
    );
  }
}
