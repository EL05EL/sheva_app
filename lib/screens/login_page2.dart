import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';
import '../theme/theme_extension.dart';

class LoginPage2 extends StatefulWidget {
  const LoginPage2({super.key});

  @override
  State<LoginPage2> createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  final TextEditingController _nameController = TextEditingController();
  String _selectedGender = '';

  Future<void> _saveAndNavigate() async {
    if (_nameController.text.isEmpty || _selectedGender.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap isi nama dan pilih gender!')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', _nameController.text);
    await prefs.setString('userGender', _selectedGender);
    await prefs.setString(
      'joinDate',
      '${_getMonthName(DateTime.now().month)} ${DateTime.now().year}',
    );

    if (mounted) {
      Navigator.pushNamed(context, '/login3');
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return months[month - 1];
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.shevaColors;
    return Scaffold(
      backgroundColor: colors.bgDeep,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingXl,
              vertical: AppTheme.spacingXxl,
            ),
            child: Column(
              children: [
                Container(
                  width: 148,
                  height: 148,
                  decoration: ShapeDecoration(
                    image: const DecorationImage(
                      image: NetworkImage('https://placehold.co/148x148'),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.spacingXxl),
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingMd),
                Text(
                  'Kenalkan diri Anda',
                  style: TextStyle(
                    color: colors.accent,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXs),
                Text(
                  'Informasi ini hanya tersimpan di perangkat Anda dan tidak dikirim ke mana pun',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.text3,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXl),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nama Panggilan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXs),
                Container(
                  decoration: BoxDecoration(
                    color: colors.card,
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    border: Border.all(color: colors.border),
                  ),
                  child: TextField(
                    controller: _nameController,
                    style: TextStyle(color: colors.text1, fontSize: 14),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Masukan nama anda',
                      hintStyle: TextStyle(color: colors.text4, fontSize: 14),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingMd,
                        vertical: AppTheme.spacingSm,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingLg),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Identitas gender',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXs),
                Row(
                  children: [
                    Expanded(
                      child: _buildGenderOption('Laki-laki'),
                    ),
                    const SizedBox(width: AppTheme.spacingSm),
                    Expanded(
                      child: _buildGenderOption('Perempuan'),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacingXxl),
                SizedBox(
                  width: double.infinity,
                  height: 53,
                  child: ElevatedButton(
                    onPressed: _saveAndNavigate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF270F32),
                      foregroundColor: const Color(0xFFF5F6FB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                        side: BorderSide(color: colors.border),
                      ),
                      elevation: 4,
                    ),
                    child: const Text(
                      'Lanjutkan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingMd),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    'Kembali',
                    style: TextStyle(
                      color: colors.text3,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderOption(String gender) {
    final colors = context.shevaColors;
    final isSelected = _selectedGender == gender;
    return GestureDetector(
      onTap: () => setState(() => _selectedGender = gender),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingMd),
        decoration: ShapeDecoration(
          color: isSelected ? colors.accentMid : colors.card,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: isSelected ? colors.accent : colors.border,
            ),
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          ),
        ),
        child: Center(
          child: Text(
            gender,
            style: TextStyle(
              color: isSelected ? colors.text1 : colors.text4,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
