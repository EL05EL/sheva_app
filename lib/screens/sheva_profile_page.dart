import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../theme/app_theme.dart';
import '../theme/theme_extension.dart';
import '../widgets/sos_button.dart';

class ShevaProfilePage extends StatefulWidget {
  const ShevaProfilePage({super.key});

  @override
  State<ShevaProfilePage> createState() => _ShevaProfilePageState();
}

class _ShevaProfilePageState extends State<ShevaProfilePage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.shevaColors;
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: colors.bgDeep,
      floatingActionButton: const SosButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: colors.header,
        foregroundColor: colors.text1,
        elevation: 0,
        title: const Text('Profil',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingLg),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 61,
                    backgroundColor: colors.card,
                    backgroundImage: userProvider.profileImagePath != null
                        ? FileImage(File(userProvider.profileImagePath!))
                            as ImageProvider
                        : null,
                    child: userProvider.profileImagePath == null
                        ? Icon(Icons.person, size: 60, color: colors.text4)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: _isLoading
                        ? const SizedBox(
                            width: 32,
                            height: 32,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.purple,
                            ),
                          )
                        : InkWell(
                            onTap: () =>
                                _showImagePickerOptions(context, userProvider),
                            borderRadius: BorderRadius.circular(16),
                            splashColor: colors.text1.withOpacity(0.2),
                            highlightColor: colors.text1.withOpacity(0.1),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: colors.accent,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.edit,
                                  color: colors.text1,
                                  size: AppTheme.iconSmall),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingMd),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userProvider.userName,
                  style: TextStyle(
                    color: colors.text1,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: AppTheme.spacingXs),
                if (!_isLoading)
                  InkWell(
                    onTap: () => _editName(context, userProvider),
                    borderRadius: BorderRadius.circular(8),
                    child: Icon(Icons.edit,
                        color: colors.accent, size: AppTheme.iconSmall),
                  ),
                if (_isLoading)
                  const SizedBox(
                    width: AppTheme.iconSmall,
                    height: AppTheme.iconSmall,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.purple,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingXxs),
            Text(
              'Bergabung sejak ${userProvider.joinDate}',
              style: TextStyle(
                color: colors.text2,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: AppTheme.spacingLg),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Gender',
                style: TextStyle(
                  color: colors.text1,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingXs),
            Row(
              children: [
                _buildGenderOption(context, 'Laki-laki', userProvider),
                const SizedBox(width: AppTheme.spacingMd),
                _buildGenderOption(context, 'Perempuan', userProvider),
              ],
            ),
            const SizedBox(height: AppTheme.spacingXl),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Pengaturan & Lainnya',
                style: TextStyle(
                  color: colors.text1,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingXs),
            _buildMenuItem(
              icon: Icons.settings,
              title: 'Pengaturan Aplikasi',
              subtitle: 'tema, ukuran teks, keamanan',
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),
            const SizedBox(height: AppTheme.spacingSm),
            _buildMenuItem(
              icon: Icons.privacy_tip,
              title: 'Kebijakan Privasi',
              subtitle: 'lihat cara kami melindungi data anda',
              onTap: () => Navigator.pushNamed(context, '/privacy'),
            ),
            const SizedBox(height: AppTheme.spacingXl),
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              decoration: BoxDecoration(
                color: colors.card,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                border: Border.all(color: colors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SHEVA - SOLIDARITY HUB FOR EQUALITY, VOICE AND ACTION',
                    style: TextStyle(
                      color: colors.text2,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingXxs),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Perpaduan "she" (perempuan) dan "Eva" (kehidupan) - ',
                          style: TextStyle(
                            color: colors.text1,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text:
                              'melambangkan bahwa kesetaraan adalah nafas kehidupan bagi semua manusia',
                          style: TextStyle(
                            color: colors.text1,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingMd),
            Center(
              child: Text(
                '"For She, For He, For All."',
                style: TextStyle(
                  color: colors.text2,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderOption(
      BuildContext context, String gender, UserProvider userProvider) {
    final colors = context.shevaColors;
    final isSelected = userProvider.userGender == gender;
    return InkWell(
      onTap: () async {
        if (_isLoading) return;
        setState(() => _isLoading = true);
        await userProvider.setUserGender(gender);
        if (mounted) setState(() => _isLoading = false);
      },
      borderRadius: BorderRadius.circular(AppTheme.radiusSm),
      splashColor: colors.text1.withOpacity(0.1),
      highlightColor: colors.text1.withOpacity(0.05),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppTheme.spacingSm,
          horizontal: AppTheme.spacingXl,
        ),
        decoration: ShapeDecoration(
          color: isSelected ? colors.accentMid : colors.card,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 2,
              color: isSelected ? colors.accent : colors.border,
            ),
            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
          ),
        ),
        child: Text(
          gender,
          style: TextStyle(
            color: isSelected ? colors.text1 : colors.text4,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final colors = context.shevaColors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      splashColor: colors.text1.withOpacity(0.1),
      highlightColor: colors.text1.withOpacity(0.05),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppTheme.spacingMd,
          horizontal: AppTheme.spacingMd,
        ),
        decoration: BoxDecoration(
          color: colors.card,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          border: Border.all(color: colors.border),
        ),
        child: Row(
          children: [
            Icon(icon, color: colors.text1, size: AppTheme.iconMain),
            const SizedBox(width: AppTheme.spacingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: colors.text1,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: colors.text2,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: colors.text1),
          ],
        ),
      ),
    );
  }

  void _showImagePickerOptions(
      BuildContext context, UserProvider userProvider) {
    final colors = context.shevaColors;
    final picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      backgroundColor: colors.bgDeep,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppTheme.spacingLg)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppTheme.spacingLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Foto Profil',
              style: TextStyle(
                color: colors.text1,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppTheme.spacingLg),
            ListTile(
              leading: Icon(Icons.photo_library, color: colors.text1),
              title: Text('Pilih dari Galeri',
                  style: TextStyle(color: colors.text1)),
              onTap: () async {
                Navigator.pop(context);
                if (_isLoading) return;
                setState(() => _isLoading = true);
                final XFile? image = await picker.pickImage(
                  source: ImageSource.gallery,
                  maxWidth: 300,
                  maxHeight: 300,
                  imageQuality: 80,
                );
                if (image != null) {
                  await userProvider.setProfileImage(image.path);
                }
                if (mounted) setState(() => _isLoading = false);
              },
            ),
            if (userProvider.profileImagePath != null)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Hapus Foto',
                    style: TextStyle(color: Colors.red)),
                onTap: () async {
                  Navigator.pop(context);
                  if (_isLoading) return;
                  setState(() => _isLoading = true);
                  await userProvider.resetProfileImage();
                  if (mounted) setState(() => _isLoading = false);
                },
              ),
            ListTile(
              leading: Icon(Icons.close, color: colors.text4),
              title: Text('Batal', style: TextStyle(color: colors.text4)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _editName(BuildContext context, UserProvider userProvider) {
    final colors = context.shevaColors;
    final controller = TextEditingController(text: userProvider.userName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:
            Text('Ubah Nama Panggilan', style: TextStyle(color: colors.text1)),
        backgroundColor: colors.bgDeep,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          side: BorderSide(color: colors.border),
        ),
        content: TextField(
          controller: controller,
          style: TextStyle(color: colors.text1),
          decoration: InputDecoration(
            hintText: 'Masukkan nama baru',
            hintStyle: TextStyle(color: colors.text4),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: colors.border)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors.border)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal', style: TextStyle(color: colors.text4)),
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                Navigator.pop(context);
                if (_isLoading) return;
                setState(() => _isLoading = true);
                await userProvider.setUserName(controller.text);
                if (mounted) setState(() => _isLoading = false);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.accentMid,
              foregroundColor: colors.text1,
            ),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}
