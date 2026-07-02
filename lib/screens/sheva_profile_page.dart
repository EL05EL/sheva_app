import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../app_theme.dart';
import '../providers/settings_provider.dart';
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
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      floatingActionButton: const SosButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Profil', style: AppTheme.h2Medium),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingLg),
        child: Column(
          children: [
            // Foto Profil
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 61,
                    backgroundColor: AppTheme.background,
                    backgroundImage: userProvider.profileImagePath != null
                        ? FileImage(File(userProvider.profileImagePath!))
                            as ImageProvider
                        : null,
                    child: userProvider.profileImagePath == null
                        ? const Icon(Icons.person,
                            size: 60, color: AppTheme.textHint)
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
                              color: AppTheme.secondary,
                            ),
                          )
                        : InkWell(
                            onTap: () =>
                                _showImagePickerOptions(context, userProvider),
                            borderRadius: BorderRadius.circular(16),
                            splashColor: Colors.white.withOpacity(0.2),
                            highlightColor: Colors.white.withOpacity(0.1),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: AppTheme.secondary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.edit,
                                  color: Colors.white,
                                  size: AppTheme.iconSmall),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingMd),
            // Nama
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userProvider.userName,
                  style: AppTheme.bodyBold,
                ),
                const SizedBox(width: AppTheme.spacingXs),
                if (!_isLoading)
                  InkWell(
                    onTap: () => _editName(context, userProvider),
                    borderRadius: BorderRadius.circular(8),
                    child: const Icon(Icons.edit,
                        color: AppTheme.secondary, size: AppTheme.iconSmall),
                  ),
                if (_isLoading)
                  const SizedBox(
                    width: AppTheme.iconSmall,
                    height: AppTheme.iconSmall,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppTheme.secondary,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingXxs),
            Text(
              'Bergabung sejak ${userProvider.joinDate}',
              style: AppTheme.caption,
            ),
            const SizedBox(height: AppTheme.spacingLg),
            // Gender
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Gender',
                style: AppTheme.bodyBold,
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
            // Pengaturan & Lainnya
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Pengaturan & Lainnya',
                style: AppTheme.bodyBold,
              ),
            ),
            const SizedBox(height: AppTheme.spacingXs),
            // Pengaturan Aplikasi
            _buildMenuItem(
              icon: Icons.settings,
              title: 'Pengaturan Aplikasi',
              subtitle: 'tema, ukuran teks, keamanan',
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),
            const SizedBox(height: AppTheme.spacingSm),
            // Kebijakan Privasi
            _buildMenuItem(
              icon: Icons.privacy_tip,
              title: 'Kebijakan Privasi',
              subtitle: 'lihat cara kami melindungi data anda',
              onTap: () => Navigator.pushNamed(context, '/privacy'),
            ),
            const SizedBox(height: AppTheme.spacingXl),
            // Deskripsi SHEVA
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              decoration: ShapeDecoration(
                color: AppTheme.surfaceCardAlt,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: AppTheme.surfaceCard2),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SHEVA - SOLIDARITY HUB FOR EQUALITY, VOICE AND ACTION',
                    style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: AppTheme.spacingXxs),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Perpaduan "she" (perempuan) dan "Eva" (kehidupan) - ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ),
                        TextSpan(
                          text:
                              'melambangkan bahwa kesetaraan adalah nafas kehidupan bagi semua manusia',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingMd),
            const Center(
              child: Text(
                '"For She, For He, For All."',
                style: TextStyle(color: AppTheme.textSecondary, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderOption(
      BuildContext context, String gender, UserProvider userProvider) {
    final isSelected = userProvider.userGender == gender;
    return InkWell(
      onTap: () async {
        if (_isLoading) return;
        setState(() => _isLoading = true);
        await userProvider.setUserGender(gender);
        if (mounted) setState(() => _isLoading = false);
      },
      borderRadius: BorderRadius.circular(AppTheme.radiusSm),
      splashColor: Colors.white.withOpacity(0.1),
      highlightColor: Colors.white.withOpacity(0.05),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppTheme.spacingSm,
          horizontal: AppTheme.spacingXl,
        ),
        decoration: ShapeDecoration(
          color: isSelected ? AppTheme.surfaceCard2 : AppTheme.background,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 2,
              color: isSelected
                  ? AppTheme.secondary
                  : AppTheme.genderBorderUnselected,
            ),
            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
          ),
        ),
        child: Text(
          gender,
          style: TextStyle(
            color: isSelected ? Colors.white : AppTheme.textHint,
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      splashColor: Colors.white.withOpacity(0.1),
      highlightColor: Colors.white.withOpacity(0.05),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppTheme.spacingMd,
          horizontal: AppTheme.spacingMd,
        ),
        decoration: ShapeDecoration(
          color: AppTheme.surfaceCard,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppTheme.borderLight),
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: AppTheme.iconMain),
            const SizedBox(width: AppTheme.spacingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                  Text(subtitle,
                      style: const TextStyle(
                          color: AppTheme.textSecondary, fontSize: 10)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white),
          ],
        ),
      ),
    );
  }

  void _showImagePickerOptions(
      BuildContext context, UserProvider userProvider) {
    final picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.background,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppTheme.spacingLg)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppTheme.spacingLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Foto Profil',
              style: AppTheme.h2,
            ),
            const SizedBox(height: AppTheme.spacingLg),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.white),
              title: const Text('Pilih dari Galeri', style: AppTheme.body),
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
              leading: const Icon(Icons.close, color: Colors.grey),
              title: const Text('Batal', style: TextStyle(color: Colors.grey)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _editName(BuildContext context, UserProvider userProvider) {
    final controller = TextEditingController(text: userProvider.userName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ubah Nama Panggilan',
            style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          side: const BorderSide(color: AppTheme.borderDefault),
        ),
        content: TextField(
          controller: controller,
          style: AppTheme.body,
          decoration: const InputDecoration(
            hintText: 'Masukkan nama baru',
            hintStyle: TextStyle(color: AppTheme.textHint),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppTheme.borderDefault)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppTheme.borderDefault)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal',
                style: TextStyle(color: AppTheme.textMuted)),
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
              backgroundColor: AppTheme.surfaceCard2,
              foregroundColor: Colors.white,
            ),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}
