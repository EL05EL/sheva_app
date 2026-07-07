import 'package:flutter/material.dart';
import '../theme/theme_extension.dart';

class LoginProgressIndicator extends StatelessWidget {
  final int currentPage; // 0 = halaman 1, 1 = halaman 2, 2 = halaman 3

  const LoginProgressIndicator({
    super.key,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.shevaColors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final isActive = index == currentPage;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? colors.accent : colors.text4,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
